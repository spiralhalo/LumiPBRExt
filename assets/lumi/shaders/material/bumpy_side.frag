#include lumi:shaders/lib/bump.glsl
#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/lib/apply_bump.glsl

/******************************************************
  lumi:shaders/material/bumpy_side.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_BUMP
#ifdef LUMI_BUMP_DEFAULT
  if (abs(data.vertexNormal.y) < 0.02) {
    _applyBump(data);
    // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
  }
#endif
#endif
}
