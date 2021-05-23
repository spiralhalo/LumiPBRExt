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

  bool isBrick = !data.ao;
  data.ao = true;

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

  #ifdef LUMIEXT_ApplyBumpMinerals
  if (beveled) {
    _applyBevel(data, isBrick);
  } else if ((frx_var3.z > 0.5 && frx_var3.z < 1.5) || bump_fallback) {
    _applyBump(data);
  }
  #endif

  // Crying obsidian
  if (data.emissivity > 0) {
    data.emissivity = data.spriteColor.b - 0.4;
  }
}
