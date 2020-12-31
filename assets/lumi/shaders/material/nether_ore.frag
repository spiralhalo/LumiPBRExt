#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/nether_ore.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  #if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
    #ifdef LUMI_PBRX
      pbr_roughness = 0.7;
      if (data.spriteColor.r > 0.6) {
        if (!data.diffuse) {
          pbr_roughness = 0.2;
          #if LUMI_PBR_API >= 1
            pbr_f0 = vec3(0.17);
          #endif
        } else {
          pbr_roughness = 0.5;
          pbr_metallic = 1.0;
        }
      }
    #endif
  #endif

  #ifdef LUMI_BUMP
  #ifdef LUMIEXT_ApplyBumpMinerals
    _applyBump(data);
  #endif
  #endif

  data.diffuse = true;
}
