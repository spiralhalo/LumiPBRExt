#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/lib/bump.glsl

#ifdef LUMI_PBR
#ifdef LUMI_BUMP
void __applyBump(inout frx_FragmentData data) 
{
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = frx_normalModelMatrix() * bump_normal(frxs_spriteAltas, data.vertexNormal * frx_normalModelMatrix(), uvN, uvT, uvB);
}
#endif
#endif
