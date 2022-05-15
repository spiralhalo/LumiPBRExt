#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/world.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/iron_golem.frag
******************************************************/

void frx_materialFragment()
{
#ifdef PBR_ENABLED
  vec4 c = frx_sampleColor;
  float min_ = min( min(c.r, c.g), c.b );
  float max_ = max( max(c.r, c.g), c.b );
  float s = max_ > 0 ? (max_ - min_) / max_ : 0;
  if (s < 0.4) {
      frx_fragColor.rgb /= max_;
      frx_fragColor.b *= 0.8;
      frx_fragReflectance = 1.0;
      frx_fragRoughness = 0.4 - s * 0.2;
  }
#endif

#ifdef PBR_ENABLED
#ifdef LUMIEXT_ApplyBumpDefault
  _applyBump(true);
#endif
#endif

  if (frx_sampleColor.r > frx_sampleColor.g * 2) {
      frx_fragEmissive = 1.0;
  }
}
