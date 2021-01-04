#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/smooth_bumpy.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  #ifdef LUMI_PBRX
    if (!data.diffuse) {
      pbr_roughness = 0.4;
    } else {
      pbr_roughness = 0.7;
    }
  #endif

  #ifdef LUMIEXT_ApplyBumpMinerals
    _applyBump(data);
  #endif

  // Crying obsidian
  if (data.emissivity > 0) {
    data.emissivity = data.spriteColor.b - 0.4;
  }
  
  data.diffuse = true;
}
