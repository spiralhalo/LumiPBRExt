#include lumi:shaders/lib/bump.glsl
#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/lib/apply_bump.glsl

/******************************************************
  lumi:shaders/material/obsidian.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBR
  pbr_roughness = 0.2;
#endif
#ifdef LUMI_BUMP
#ifdef LUMI_BUMP_MINERALS
    __applyBump_dark(data, 4.0);
    // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
#endif
    if (data.spriteColor.b > 0.4) {
        data.emissivity = 0.5;
    }
}
