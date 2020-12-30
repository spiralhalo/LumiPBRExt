#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/dark_bumpy_side_x.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_BUMP
#ifdef LUMIEXT_ApplyBumpDefault
  if (abs(data.vertexNormal.x) < 0.02) {
    _applyBump_dark(data, 2.0, false);
    // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
  }
#endif
#endif
}
