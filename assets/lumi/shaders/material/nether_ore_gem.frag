#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/nether_ore_gem.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBR
  pbr_roughness = 0.7;
  if (data.spriteColor.r > 0.6) {
    pbr_roughness = 0.2;
  #if LUMI_PBR_API >= 1
    pbr_f0 = vec3(0.17);
  #endif
  }
#endif
#ifdef LUMI_BUMP
#ifdef LUMI_BUMP_MINERALS
  _applyBump(data);  
  // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
#endif
}
