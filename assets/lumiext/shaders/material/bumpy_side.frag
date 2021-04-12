#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/bumpy_side.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  #ifdef LUMIEXT_ApplyBumpDefault
    if (abs(data.vertexNormal.y) < 0.02) {
      _applyBump(data);
    }
  #endif
}
