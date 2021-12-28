#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/world.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/iron_golem.frag
******************************************************/

void frx_materialFragment()
{
  #ifdef LUMI_PBRX
    vec4 c = frx_sampleColor;
    float min_ = min( min(c.r, c.g), c.b );
    float max_ = max( max(c.r, c.g), c.b );
    float s = max_ > 0 ? (max_ - min_) / max_ : 0;
    if (s < 0.4) {
        frx_fragColor.rgb /= max_;
        frx_fragColor.b *= 0.8;
        pbr_metallic = 1.0;
        pbr_roughness = 0.4 - s * 0.2;
    }
    #ifdef LUMIEXT_ApplyBumpDefault
      _applyBump(true);
    #endif
  #endif
  if (frx_sampleColor.r > frx_sampleColor.g * 2) {
      frx_fragEmissive = 1.0;
  }
}
