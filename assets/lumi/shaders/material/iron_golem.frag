#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/world.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/iron_golem.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  #ifdef LUMI_PBRX
    vec4 c = data.spriteColor;
    float min_ = min( min(c.r, c.g), c.b );
    float max_ = max( max(c.r, c.g), c.b );
    float s = max_ > 0 ? (max_ - min_) / max_ : 0;
    if (s < 0.4) {
        data.spriteColor.rgb /= max_;
        data.spriteColor.b *= 0.8;
        pbr_metallic = 1.0;
        pbr_roughness = 0.4 - s * 0.2;
    }
    #ifdef LUMIEXT_ApplyBumpDefault
      _applyBump(data, true);
    #endif
  #endif
  if(data.spriteColor.r > data.spriteColor.g * 2) {
      data.emissivity = 1.0;
  }
}
