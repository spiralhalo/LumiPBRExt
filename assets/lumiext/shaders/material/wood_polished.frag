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

#ifdef PBR_ENABLED
#ifdef LUMIEXT_ApplyBumpDefault
  _applyBump();
#endif
#endif
}
