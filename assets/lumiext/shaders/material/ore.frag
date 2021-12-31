#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/ore.frag
******************************************************/

void frx_materialFragment()
{
  // Redstone
  if (frx_fragEmissive > 0) {
    #if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
      if (frx_sampleColor.r < frx_sampleColor.b * 2){
        frx_fragEmissive = 0.0;
      }
    #endif

    #ifdef LUMI_PBRX
      pbr_roughness = 0.7;
    #endif

    #ifdef PBR_ENABLED
    #ifdef LUMIEXT_ApplyBumpMinerals
      _applyBump();
    #endif
    #endif
  
  } else {

    #if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
    #ifdef LUMI_PBRX
      pbr_roughness = 0.7;
      vec3 c = frx_sampleColor.rgb;
      float min_ = min( min(c.r, c.g), c.b );
      float max_ = max( max(c.r, c.g), c.b );
      float s = max_ > 0 ? (max_ - min_) / max_ : 0;
      if (s > 0.3 || min_ > 0.65) {
        if (!frx_fragEnableDiffuse) {
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

    #ifdef PBR_ENABLED
    #ifdef LUMIEXT_ApplyBumpMinerals
      _applyBump();
      // frx_fragColor.rgb *= (frx_vertexNormal + 1) * 0.5;
    #endif
    #endif
  }

  frx_fragEnableDiffuse = true;
}
