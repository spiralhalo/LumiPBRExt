#include lumi:shaders/lib/bump.glsl
#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/lib/apply_bump.glsl

/******************************************************
  lumi:shaders/material/ore_gem.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBR
  pbr_roughness = 0.7;
  if(data.spriteColor.b > data.spriteColor.r){
    pbr_roughness = 0.2;
  }
#endif
#ifdef LUMI_BUMP
  __applyBump(data);
  // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
}
