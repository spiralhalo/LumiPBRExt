#include lumi:shaders/lib/bump.glsl
#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/lib/apply_bump.glsl

/******************************************************
  lumi:shaders/material/metal_bumpy.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBR
  // pbr_metallic = 0.177083 / (frx_luminance(data.spriteColor.rgb));
  pbr_roughness = 0.1;
#endif
#ifdef LUMI_BUMP
#ifdef LUMI_BUMP_MINERALS
  __applyBump(data);
  // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
#endif
}
