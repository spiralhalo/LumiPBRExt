#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/context.glsl
#include frex:shaders/api/world.glsl
#include lumi:shaders/lib/bump.glsl
#include lumi:shaders/lib/apply_bump.glsl

/******************************************************
  lumi:shaders/material/tool_gem.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBR
  if (data.spriteColor.b > data.spriteColor.r) {
    pbr_roughness = 0.05;
#ifdef LUMI_BUMP
#ifdef LUMI_BUMP_DEFAULT
    
    __applyBump_step(data, 0.25, 0.8);
#endif
#endif
  }
#endif
}
