#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/wood_polished.frag
******************************************************/

void frx_materialFragment()
{
#ifdef PBR_ENABLED
  frx_fragRoughness = WOOD_PLANKS_ROUGHNESS;
#endif

#ifdef PBR_ENABLED
#ifdef LUMIEXT_ApplyBumpDefault
  _applyBump();
#endif
#endif
}
