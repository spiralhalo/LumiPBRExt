#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/nether_ore_metal.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
#ifdef LUMI_PBRX
  pbr_roughness = 0.7;
  if (data.spriteColor.r > 0.6) {
    pbr_roughness = 0.5;
    pbr_metallic = 1.0;
  }
#endif
#endif

#ifdef LUMI_BUMP
#ifdef LUMIEXT_ApplyBumpMinerals
  _applyBump(data);  
  // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
#endif
}
