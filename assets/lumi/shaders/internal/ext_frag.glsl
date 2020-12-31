#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:ext_config.glsl
#include lumi:shaders/lib/bump.glsl
#include lumi:shaders/lib/bump2.glsl
#include lumi:shaders/lib/bump_alpha.glsl
#include lumi:shaders/lib/bump_step.glsl
#include lumi:shaders/lib/bump_step_s.glsl
#include lumi:shaders/lib/bump_coarse.glsl

/******************************************************
  lumi:shaders/internal/ext_frag.glsl
******************************************************/

#ifdef LUMI_BUMP
void _applyBump(inout frx_FragmentData data) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_normal2(
    frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(),
    uvN, uvT, uvB, false);
}

void _applyBump(inout frx_FragmentData data, bool reverse) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_normal2(
    frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(),
    uvN, uvT, uvB, reverse);
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
