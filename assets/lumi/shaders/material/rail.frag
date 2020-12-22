#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/world.glsl
#include lumi:shaders/lib/bump.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/rail.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBR
    vec4 c = data.spriteColor;
    float min_ = min( min(c.r, c.g), c.b );
    float max_ = max( max(c.r, c.g), c.b );
    float s = max_ > 0 ? (max_ - min_) / max_ : 0;
    if (s < 0.2 || (c.g > c.b * 2 && s > 0.6)) {
        pbr_metallic = 1.0;
        pbr_roughness = 0.5;
#ifdef LUMI_BUMP
#ifdef LUMI_BUMP_DEFAULT
        _applyBump(data);
#endif
#endif
    }
#endif
}
