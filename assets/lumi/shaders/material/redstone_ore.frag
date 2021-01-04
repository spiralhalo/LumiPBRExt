#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/redstone_ore.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  if (data.emissivity > 0) {
    
  }
  if(data.spriteColor.r > data.spriteColor.b * 2){
    data.emissivity = 1.0;
  }
#if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
  #ifdef LUMI_PBRX
    pbr_roughness = 0.7;
  #endif
#endif

#ifdef LUMIEXT_ApplyBumpMinerals
    _applyBump(data);
    // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
}
