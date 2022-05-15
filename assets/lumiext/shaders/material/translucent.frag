#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/translucent.frag
******************************************************/

void frx_materialFragment()
{
#ifdef PBR_ENABLED
  if (!frx_fragEnableDiffuse) {
    // honey and slime, inspired by PR #8
    frx_fragReflectance = 0.3;
  }

  frx_fragRoughness = 0.05;
#endif

  frx_fragEnableDiffuse = true;
}
