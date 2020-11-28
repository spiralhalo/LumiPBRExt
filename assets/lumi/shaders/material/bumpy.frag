#include lumi:shaders/lib/bump.glsl
#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/lib/apply_bump.glsl

/******************************************************
  lumi:shaders/material/bumpy.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_BUMP
    __applyBump(data);
    // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
}
