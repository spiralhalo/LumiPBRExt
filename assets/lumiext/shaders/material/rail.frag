#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/world.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/rail.frag
******************************************************/

void frx_materialFragment()
{
#if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
  vec4 c = frx_sampleColor;
  if (frx_fragEmissive > 0.0) {
    if (c.r > c.g * 2) {
      frx_fragEmissive = 1.0;
    } else {
      frx_fragEmissive = 0.0;
    }
  }

#ifdef PBR_ENABLED
#ifdef LUMI_PBRX
  float min_ = min( min(c.r, c.g), c.b );
  float max_ = max( max(c.r, c.g), c.b );
  float s = max_ > 0 ? (max_ - min_) / max_ : 0;
  if (s < 0.2 || (c.g > c.b * 2 && s > 0.6)) {
    pbr_metallic = 1.0;
    pbr_roughness = 0.4;
    #ifdef LUMIEXT_ApplyBumpDefault
      _applyBump();
    #endif
  }
#endif
#endif
// #else
//   frx_fragEmissive = 0.0;
#endif
}
