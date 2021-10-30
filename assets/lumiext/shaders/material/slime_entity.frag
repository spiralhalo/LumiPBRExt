#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/slime.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{

#ifdef LUMI_PBRX
  pbr_metallic = 0.5;
  pbr_roughness = 0.5;
#endif
  
  data.diffuse = true;
}
