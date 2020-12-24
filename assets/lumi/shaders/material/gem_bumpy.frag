#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/metal_bumpy.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBRX
  // pbr_metallic = 0.177083 / (frx_luminance(data.spriteColor.rgb));
  pbr_roughness = 0.1;
  #if LUMI_PBR_API >= 1
  pbr_f0 = vec3(0.17);
  #endif
#endif
#ifdef LUMI_BUMP
  #ifdef LUMIEXT_ApplyBumpMinerals
  _applyBump(data);
  // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
  #endif
#endif
}
