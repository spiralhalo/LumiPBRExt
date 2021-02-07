#include frex:shaders/api/fragment.glsl
#include lumi:shaders/lib/bump.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/stone_bumpy_polished.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBRX
  pbr_roughness = WOOD_PLANKS_ROUGHNESS;
#endif
#ifdef LUMI_BUMP
#ifdef LUMIEXT_ApplyBumpDefault
    _applyBump(data);
    // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
#endif
}
