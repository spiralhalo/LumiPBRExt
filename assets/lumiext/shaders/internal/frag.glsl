#include frex:shaders/lib/math.glsl
#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/material.glsl
#include lumiext:config.glsl
#include lumi:shaders/api/pbr_ext.glsl

// Fallback
#if !defined(LUMI_PBR_API) || LUMI_PBR_API < 2
  in vec3 l2_tangent;
#endif 

const float BASE_STONE_ROUGHNESS = clamp(LUMIEXT_BaseStoneRoughness * 0.1, 0.05, 1.0);
const float POLISHED_ROUGHNESS = clamp(LUMIEXT_PolishedRoughness * 0.1, 0.05, 1.0);
const float WOOD_PLANKS_ROUGHNESS = clamp(LUMIEXT_WoodPlanksRoughness * 0.1, 0.05, 1.0);

/* legacy bump height */
#define _bump_height(raw) frx_smootherstep(0, 1, pow(raw, 1 + raw * raw))

#define _bump_height2(x) sqrt((x.r + x.g + x.b) * 0.33333 * 2.0)

#include lumiext:shaders/lib/bump2.glsl
#include lumiext:shaders/lib/bump_alpha.glsl
#include lumiext:shaders/lib/bump_step.glsl
#include lumiext:shaders/lib/bump_step_s.glsl
#include lumiext:shaders/lib/bump_coarse.glsl

/******************************************************
  lumiext:shaders/internal/frag.glsl
******************************************************/

#if LUMI_PBR_API >= 3
#define _applyMicroNormal(x, m) pbr_normalMicro = m
#else
#define _applyMicroNormal(x, m) x.vertexNormal = m
#endif

void _applyBump(inout frx_FragmentData data) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  _applyMicroNormal(data, bump_normal2(
    frxs_baseColor, data.vertexNormal ,
    uvN, uvT, uvB, topRight, l2_tangent, false));
}

void _applyBump(inout frx_FragmentData data, bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  _applyMicroNormal(data, bump_normal2(
    frxs_baseColor, data.vertexNormal ,
    uvN, uvT, uvB, topRight, l2_tangent, reverse));
}

void _applyBump_alpha(inout frx_FragmentData data, bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  _applyMicroNormal(data, bump_alpha_normal(
    frxs_baseColor, data.vertexNormal ,
    uvN, uvT, uvB, topRight, l2_tangent, reverse));
}

void _applyBump_step(inout frx_FragmentData data, float step_, float strength, bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  _applyMicroNormal(data, bump_step_normal(
    frxs_baseColor, data.vertexNormal ,
    uvN, uvT, uvB, topRight, l2_tangent,
    step_, strength, reverse));
}

void _applyBump_step_s(inout frx_FragmentData data, float step_, float strength, bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  _applyMicroNormal(data, bump_step_s_normal(
    frxs_baseColor, data.vertexNormal,
    uvN, uvT, uvB, topRight, l2_tangent,
    step_, strength, reverse));
}

void _applyBevel(inout frx_FragmentData data, bool isBrick) 
{
  vec2 spriteUV = frx_var1.zw;
  vec3 regionPos = frx_var2.xyz; //nb: unlike world pos, region pos is always positive

  // COMPUTE MASK
  vec2 e1 = smoothstep(0.0725, 0.0525, spriteUV);
  vec2 e2 = smoothstep(1.0-0.0725, 1.0-0.0525, spriteUV);
  vec2 e = max(e1, e2);
  float mask = max(e.s, e.t); // edge mask
  if (isBrick) {
    float bottom = step(0.5-0.0525, spriteUV.t);
    vec2 m = smoothstep(0.0725, 0.0525, abs(spriteUV - vec2(0.5))); // middle + shaped mask
    m.s *= bottom;                                                  // cut top part of + to get ㅜ
    mask = max(mask * max(1.0 - bottom, e2.t), max(m.s, m.t));      // selective combine with edge mask = brick mask
  }
  if (mask <= 0) { // premature culling
    return;
  }

  // COMPUTE BEVEL CENTER
  vec3 model = fract(regionPos - data.vertexNormal * 0.1); // position roughly within a 1x1 cube
  vec3 center = vec3(0.5, 0.5, 0.5);                       // center of the bevel
  if (isBrick) {
    // 0.0725 < magic number < 0.5 - 0.0725. 0.15 gives smoothest result
    #define _BRICK_FALLBACK_MAGICN 0.15
    
    bool fallback = spriteUV.t < 0.5 && abs(spriteUV.s - 0.5) < _BRICK_FALLBACK_MAGICN; 
    fallback = fallback || spriteUV.t > 0.5 && abs(spriteUV.s - 0.5) > 0.5 - _BRICK_FALLBACK_MAGICN; // use ALG A where ALG B fails
    if (fallback) { // ALG A: nicely brick shaped, but stretched at the sides
      vec3 bitangent = cross(data.vertexNormal, l2_tangent);
      center += spriteUV.t < 0.5 ? vec3(0.0) : l2_tangent * (-0.5 + floor(spriteUV.s * 2.0));
      center -= bitangent * (-0.25 + 0.5 * floor(spriteUV.t * 2.0));
      model -= center;
      center = vec3(0.);
      model *= 1.0 - abs(l2_tangent) * 0.5;
    } else {        // ALG B: divide one cube into four small cubes, no stretching but has triangle marks
      center = vec3(0.25) + vec3(0.5) * floor(model * 2.0);
    }
  }

  // COMPUTE BEVEL
  center -= data.vertexNormal * 1.;
  vec3 a = (model - center);
  vec3 b = abs(a);                        // compute in positive space
  float minVal = min(b.x, min(b.y, b.z));
  b -= minVal;                            // make the normal favor one cardinal direction within the texture
  b = pow(normalize(b), vec3(.15));       // make the division between directions sharper, adjustable
  a = sign(a) * b;                        // return to real space
  a = mix(data.vertexNormal, normalize(a), mask); // apply mask
  _applyMicroNormal(data, normalize(a + data.vertexNormal));
}
