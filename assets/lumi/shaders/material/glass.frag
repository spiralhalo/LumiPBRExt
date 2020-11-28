#include frex:shaders/api/fragment.glsl

/******************************************************
  lumi:shaders/material/glass.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBR
  pbr_roughness = 0.05;
#endif
}
