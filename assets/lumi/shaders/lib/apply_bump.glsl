#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/lib/bump.glsl
#include lumi:shaders/lib/bump_dark.glsl
#include lumi:shaders/lib/bump_alpha.glsl
#include lumi:shaders/lib/bump_step.glsl

#ifdef LUMI_BUMP
void __applyBump(inout frx_FragmentData data) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_normal(frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(), uvN, uvT, uvB);
}

void __applyBump_dark(inout frx_FragmentData data, float colorMult) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_dark_normal(frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(), uvN, uvT, uvB, colorMult);
}

void __applyBump_alpha(inout frx_FragmentData data) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_alpha_normal(frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(), uvN, uvT, uvB);
}

void __applyBump_step(inout frx_FragmentData data, float step_, float strength) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_step_normal(frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(), uvN, uvT, uvB, step_, strength);
}
#endif
