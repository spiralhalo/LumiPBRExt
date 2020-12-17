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
  #if LUMI_PBR_API >= 1
    pbr_f0 = vec3(0.17);
  #endif
    pbr_roughness = 0.05;
#ifdef LUMI_BUMP
#ifdef LUMI_BUMP_DEFAULT
    _applyBump_step(data, 0.25, 0.8);
#endif
#endif
  }
#endif
}
