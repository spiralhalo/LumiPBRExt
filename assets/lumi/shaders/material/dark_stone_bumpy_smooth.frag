#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/dark_stone_bumpy_smooth.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBRX
  pbr_roughness = 0.7;
#endif
#ifdef LUMI_BUMP
#ifdef LUMIEXT_ApplyBumpMinerals
    _applyBump_dark(data, 2.0, false);
    // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
#endif
}
