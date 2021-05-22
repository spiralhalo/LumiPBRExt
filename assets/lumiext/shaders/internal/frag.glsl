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

  vec2 e1 = smoothstep(0.0725, 0.0525, spriteUV);
  vec2 e2 = smoothstep(1.0-0.0725, 1.0-0.0525, spriteUV);
  vec2 e = max(e1, e2);
  float mask = max(e.s, e.t);
  if (isBrick) {
    float bottom = smoothstep(0.5+0.0525, 0.5+0.0725, spriteUV.t);
    vec2 m = smoothstep(0.0725, 0.0525, abs(spriteUV - vec2(0.5)));
    m.s *= bottom;
    mask = max(mask * (1.0 - bottom), max(m.s, m.t));
  }
  if (mask <= 0) {
    return;
  }
  vec3 model = fract(regionPos - data.vertexNormal * 0.1);
  vec3 center = vec3(0.5, 0.5, 0.5);
  if (isBrick) {
    center = vec3(0.25) + vec3(0.5) * floor(model * 2.0);
  }
  center -= data.vertexNormal * 1.;
  vec3 a = (model - center);
  vec3 b = abs(a);
  float minVal = min(b.x, min(b.y, b.z));
  b -= minVal;
  b = pow(normalize(b), vec3(.15));
  a = sign(a) * b;
  a = mix(data.vertexNormal, normalize(a), mask);
  _applyMicroNormal(data, normalize(a + data.vertexNormal));
}
