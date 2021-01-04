#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/bumpy.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  #ifdef LUMIEXT_ApplyBumpDefault
    _applyBump(data);
  #endif
}
