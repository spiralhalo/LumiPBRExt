#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/nether_ore.frag
******************************************************/

void frx_materialFragment()
{
#if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
#ifdef PBR_ENABLED
  frx_fragRoughness = 0.7;
  if (frx_sampleColor.r > 0.6) {
    if (!frx_fragEnableDiffuse) {
      frx_fragRoughness = 0.2;
      frx_fragReflectance = 0.17;
    } else {
      frx_fragRoughness = 0.5;
      frx_fragReflectance = 1.0;
    }
  }
#endif
#endif

#ifdef PBR_ENABLED
#ifdef LUMIEXT_ApplyBumpMinerals
  _applyBump();
#endif
#endif

  frx_fragEnableDiffuse = true;
}
