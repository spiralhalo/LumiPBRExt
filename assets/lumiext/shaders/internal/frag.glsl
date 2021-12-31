#include frex:shaders/lib/math.glsl
#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/material.glsl
#include frex:shaders/api/view.glsl
#include lumiext:shaders/internal/config.glsl
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

// GLSL 2.1 (Mac on 1.16) compat
#if __VERSION__ <= 120
#define lumiext_textureCompat texture2D
#else
#define lumiext_textureCompat texture
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
  frx_fragNormal = bump_bevel_normal(spriteUV, regionPos, isBrick);
}
#endif
