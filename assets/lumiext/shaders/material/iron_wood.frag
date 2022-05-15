#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/world.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/iron_wood.frag
******************************************************/

void frx_materialFragment()
{
#if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
#ifdef PBR_ENABLED
#ifdef PBR_ENABLED
  vec4 c = frx_sampleColor;
  float min_ = min( min(c.r, c.g), c.b );
  float max_ = max( max(c.r, c.g), c.b );
  float s = max_ > 0 ? (max_ - min_) / max_ : 0;
  if (s < 0.4) {
    // frx_fragColor.rgb += (1-min_) * 0.3;
    frx_fragReflectance = 1.0;
    frx_fragRoughness = 0.5 - s * 0.5;
    #ifdef LUMIEXT_ApplyBumpMinerals
      _applyBump_step_s(0.4, 0.4, frx_modelOriginType() == MODEL_ORIGIN_REGION);
    #endif
  }
#endif
#endif
#endif
}
