#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/ore.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  // Redstone
  if (data.emissivity > 0) {
    #if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
      if(data.spriteColor.r < data.spriteColor.b * 2){
        data.emissivity = 0.0;
      }
    #endif

    #ifdef LUMI_PBRX
      pbr_roughness = 0.7;
    #endif

    #ifdef LUMIEXT_ApplyBumpMinerals
      _applyBump(data);
    #endif
  
  } else {

    #if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
    #ifdef LUMI_PBRX
      pbr_roughness = 0.7;
      vec3 c = data.spriteColor.rgb;
      float min_ = min( min(c.r, c.g), c.b );
      float max_ = max( max(c.r, c.g), c.b );
      float s = max_ > 0 ? (max_ - min_) / max_ : 0;
      if (s > 0.3 || min_ > 0.65) {
        if (!data.diffuse) {
          pbr_roughness = 0.2;
          #if LUMI_PBR_API >= 1
            pbr_f0 = 0.17;
          #endif
        } else {
          pbr_roughness = 0.5;
          pbr_metallic = 1.0;
        }
      }
    #endif
    #endif

    #ifdef LUMIEXT_ApplyBumpMinerals
      _applyBump(data);
      // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
    #endif
  }

  data.diffuse = true;
}
