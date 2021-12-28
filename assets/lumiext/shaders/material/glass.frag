#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/glass.frag
******************************************************/

void frx_materialFragment()
{
  #ifdef LUMI_PBRX
    pbr_roughness = 0.05;
  #endif
}
