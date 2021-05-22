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

  data.diffuse = true;

  #ifdef LUMIEXT_ApplyBumpMinerals
  if (frx_var3.z > 1.5) {
    _applyBevel(data, !data.ao);
  } else if (frx_var3.z > 0.5) {
    _applyBump(data);
  }
  #endif

  data.ao = true;

  // Crying obsidian
  if (data.emissivity > 0) {
    data.emissivity = data.spriteColor.b - 0.4;
  }
}
