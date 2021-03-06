#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:ext_config.glsl
#include lumi:shaders/lib/bump.glsl
#include lumi:shaders/lib/bump_dark.glsl
#include lumi:shaders/lib/bump_alpha.glsl
#include lumi:shaders/lib/bump_step.glsl
#include lumi:shaders/lib/bump_step_s.glsl
#include lumi:shaders/lib/bump_coarse.glsl

/******************************************************
  lumi:shaders/internal/ext_frag.glsl
******************************************************/

const float BASE_METAL_ROUGHNESS = LUMIEXT_BaseMetalRoughness * 0.1;
const float WOOD_PLANKS_ROUGHNESS = LUMIEXT_WoodPlanksRoughness * 0.1;
const float BASE_STONE_ROUGHNESS = LUMIEXT_BaseStoneRoughness * 0.1;
const float SMOOTH_STONE_ROUGHNESS = LUMIEXT_SmoothStoneRoughness * 0.1;
const float POLISHED_STONE_ROUGHNESS = LUMIEXT_PolishedStoneRoughness * 0.1;

#ifdef LUMI_BUMP
void _applyBump(inout frx_FragmentData data) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_normal(
    frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(),
    uvN, uvT, uvB);
}

void _applyBump_dark(inout frx_FragmentData data, float colorMult, bool reverse) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_dark_normal(
    frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(),
    uvN, uvT, uvB, colorMult, reverse);
}

void _applyBump_alpha(inout frx_FragmentData data, bool reverse) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_alpha_normal(
    frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(),
    uvN, uvT, uvB, reverse);
}

void _applyBump_step(inout frx_FragmentData data, float step_, float strength, bool reverse) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_step_normal(
    frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(),
    uvN, uvT, uvB,
    step_, strength, reverse);
}

void _applyBump_step_s(inout frx_FragmentData data, float step_, float strength, bool reverse) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_step_s_normal(
    frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(),
    uvN, uvT, uvB,
    step_, strength, reverse);
}
#endif
