#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/wood_polished.frag
******************************************************/

void frx_materialFragment()
{
  #ifdef LUMI_PBRX
    pbr_roughness = WOOD_PLANKS_ROUGHNESS;
  #endif

  #ifdef LUMIEXT_ApplyBumpMinerals
    _applyBump();
  #endif

  // Crying obsidian
  if (frx_fragEmissive > 0) {
    frx_fragEmissive = frx_sampleColor.b - 0.4;
  }
  
  frx_fragEnableDiffuse = true;
}
