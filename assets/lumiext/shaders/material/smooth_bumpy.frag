#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/smooth_bumpy.frag
******************************************************/

void frx_materialFragment()
{
#ifdef LUMI_PBRX
  if (!frx_fragEnableDiffuse) {
    pbr_roughness = POLISHED_ROUGHNESS;
  } else {
    pbr_roughness = BASE_STONE_ROUGHNESS;
  }
#endif

  frx_fragEnableDiffuse = true;

  bool isBrick = frx_fragEmissive > 0.5;
  frx_fragEmissive = 0.0;

  bool beveled = frx_var3.z > 1.5;

#if LUMIEXT_BricksBevelMode != LUMIEXT_BricksBevelMode_Beveled
  beveled = beveled && !isBrick;
#endif

#if LUMIEXT_BevelMode != LUMIEXT_BevelMode_Beveled
  beveled = beveled && isBrick;
#endif

  bool bump_fallback = false;

#if LUMIEXT_BricksBevelMode == LUMIEXT_BricksBevelMode_TextureBump
  bump_fallback = bump_fallback || isBrick;
#endif

#if LUMIEXT_BevelMode == LUMIEXT_BevelMode_TextureBump
  bump_fallback = bump_fallback || !isBrick;
#endif

  bump_fallback = bump_fallback && frx_var3.z > 1.5;

  // PBR_ENABLED check is late to minimize chance of important frx_frag* assignment being skipped
#ifdef PBR_ENABLED
#ifdef LUMIEXT_ApplyBumpMinerals
  if (beveled) {
    _applyBevel(isBrick);
  } else if ((frx_var3.z > 0.5 && frx_var3.z < 1.5) || bump_fallback) {
    _applyBump();
  }
#endif
#endif

  // Crying obsidian
  if (!frx_fragEnableAo && frx_modelOriginRegion) {
    frx_fragEmissive = step(0.0, frx_sampleColor.b * frx_sampleColor.b - 0.22);
  }
}
