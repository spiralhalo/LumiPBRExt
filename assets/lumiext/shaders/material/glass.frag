#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/glass.frag
******************************************************/

void frx_materialFragment()
{
  #ifdef PBR_ENABLED
    frx_fragRoughness = 0.05;
  #endif
}
