#include frex:shaders/lib/math.glsl
#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/material.glsl
#include frex:shaders/api/view.glsl
#include lumiext:shaders/internal/config.glsl
#include lumi:shaders/api/pbr_ext.glsl

const float BASE_STONE_ROUGHNESS = clamp(LUMIEXT_BaseStoneRoughness * 0.1, 0.05, 1.0);
const float POLISHED_ROUGHNESS = clamp(LUMIEXT_PolishedRoughness * 0.1, 0.05, 1.0);
const float WOOD_PLANKS_ROUGHNESS = clamp(LUMIEXT_WoodPlanksRoughness * 0.1, 0.05, 1.0);

/* legacy bump height */
#define _bump_height(raw) frx_smootherstep(0, 1, pow(raw, 1 + raw * raw))

// #define LUMIEXT_USE_BICUBIC
#define LUMIEXT_USE_MIPMAPS

#ifdef LUMIEXT_USE_MIPMAPS
#define LUMIEXT_BIAS (float(frx_matUnmipped) * -4.0)
#else
#define LUMIEXT_BIAS -4.0
#endif

#define lumiext_texture(samplr, texuv) texture(samplr, texuv, LUMIEXT_BIAS)

#ifdef LUMIEXT_HiResBumps
  #ifndef LUMIEXT_USE_BICUBIC
    vec4 lumiext_hd_texture(sampler2D tex, vec2 uv)
    {
        vec2 mil = frx_mapNormalizedUV(vec2(0.0));
        vec2 mov = frx_mapNormalizedUV(vec2(ONE_PIXEL)) - mil;
        vec2 rng = frx_mapNormalizedUV(vec2(1.0)) - mil;
        
        vec2 co  = uv - mil;
        vec2 cx  = mod(co + vec2(mov.x, 0), rng) + mil;
        vec2 cy  = mod(co + vec2(0, mov.y), rng) + mil;
        vec2 cxy = mod(co + mov, rng) + mil;

        vec4 o   = texture(tex, uv , LUMIEXT_BIAS);
        vec4 ox  = texture(tex, cx , LUMIEXT_BIAS);
        vec4 oy  = texture(tex, cy , LUMIEXT_BIAS);
        vec4 oxy = texture(tex, cxy, LUMIEXT_BIAS);
        vec2 blend = fract(uv * textureSize(tex, 0));
        vec4 blend_ox = mix(o, ox, blend.x);
        vec4 blend_oyx = mix(oy, oxy, blend.x);
        return mix(blend_ox, blend_oyx, blend.y);
    }
  
  #else

    vec4 lumiext_cubic(float v)
    {
      vec4 n = vec4(1.0, 2.0, 3.0, 4.0) - v;
      vec4 s = n * n * n;
      float x = s.x;
      float y = s.y - 4.0 * s.x;
      float z = s.z - 4.0 * s.y + 6.0 * s.x;
      float w = 6.0 - x - y - z;
      return vec4(x, y, z, w) * (1.0/6.0);
    }

    vec4 lumiext_hd_texture(sampler2D sampler, vec2 texCoords)
    {
      vec2 texSize = textureSize(sampler, 0);
      vec2 invTexSize = 1.0 / texSize;

      texCoords = texCoords * texSize;// - 0.5;

      vec2 fxy = fract(texCoords);
      texCoords -= fxy;

      vec4 xcubic = lumiext_cubic(fxy.x);
      vec4 ycubic = lumiext_cubic(fxy.y);

      vec4 c = texCoords.xxyy + vec2 (-0.5, +1.5).xyxy;

      vec4 s = vec4(xcubic.xz + xcubic.yw, ycubic.xz + ycubic.yw);
      vec4 offset = c + vec4 (xcubic.yw, ycubic.yw) / s;

      offset *= invTexSize.xxyy;

      vec2 mil = frx_mapNormalizedUV(vec2(0.0));
      vec2 rng = frx_mapNormalizedUV(vec2(1.0)) - mil;

      vec2 c0 = mod(offset.xz - mil, rng) + mil;
      vec2 c1 = mod(offset.yz - mil, rng) + mil;
      vec2 c2 = mod(offset.xw - mil, rng) + mil;
      vec2 c3 = mod(offset.yw - mil, rng) + mil;

      vec4 sample0 = texture(sampler, c0, LUMIEXT_BIAS);
      vec4 sample1 = texture(sampler, c1, LUMIEXT_BIAS);
      vec4 sample2 = texture(sampler, c2, LUMIEXT_BIAS);
      vec4 sample3 = texture(sampler, c3, LUMIEXT_BIAS);

      float sx = s.x / (s.x + s.y);
      float sy = s.z / (s.z + s.w);

      return mix(
        mix(sample3, sample2, sx),
        mix(sample1, sample0, sx),
        sy);
    }
  #endif
#else

#define lumiext_hd_texture(samplr, texuv) texture(samplr, texuv, LUMIEXT_BIAS)

#endif

#include lumiext:shaders/lib/bump2.glsl
#include lumiext:shaders/lib/bump_alpha.glsl
#include lumiext:shaders/lib/bump_bevel.glsl
#include lumiext:shaders/lib/bump_step.glsl
#include lumiext:shaders/lib/bump_step_s.glsl
#include lumiext:shaders/lib/bump_coarse.glsl

/******************************************************
  lumiext:shaders/internal/frag.glsl
******************************************************/

#ifdef PBR_ENABLED
#define _applyMicroNormal(m) frx_fragNormal = m

void _applyBump()
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  _applyMicroNormal(bump_normal2(
    frxs_baseColor,     uvN, uvT, uvB, topRight, false));
}

void _applyBump(bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  _applyMicroNormal(bump_normal2(frxs_baseColor, uvN, uvT, uvB, topRight, reverse));
}

void _applyBump_alpha(bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  _applyMicroNormal(bump_alpha_normal(frxs_baseColor, uvN, uvT, uvB, topRight, reverse));
}

void _applyBump_step(float step_, float strength, bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  _applyMicroNormal(bump_step_normal(
    frxs_baseColor, uvN, uvT, uvB, topRight,
    step_, strength, reverse));
}

void _applyBump_step_s(float step_, float strength, bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  _applyMicroNormal(bump_step_s_normal(
    frxs_baseColor, uvN, uvT, uvB, topRight,
    step_, strength, reverse));
}

void _applyBevel(bool isBrick) 
{
  vec2 spriteUV = frx_var1.zw;
  vec3 regionPos = frx_var2.xyz;
  frx_fragNormal = bump_bevel_normal(spriteUV, regionPos, isBrick, false);
}

void _applyBevel2(bool isCut) 
{
  vec2 spriteUV = frx_var1.zw;
  vec3 regionPos = frx_var2.xyz;
  frx_fragNormal = bump_bevel_normal(spriteUV, regionPos, false, isCut);
}
#endif
