#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/smooth_bumpy.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  #ifdef LUMI_PBRX
    if (!data.diffuse) {
      pbr_roughness = POLISHED_ROUGHNESS;
    } else {
      pbr_roughness = BASE_STONE_ROUGHNESS;
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
