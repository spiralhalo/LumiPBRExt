#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/bumpy.frag
******************************************************/

void frx_materialFragment()
{
  #ifdef LUMIEXT_ApplyBumpDefault
    if (frx_var3.z > 0.5) {
      _applyBump();
    }
  #endif
}
