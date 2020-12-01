#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/world.glsl
#include lumi:shaders/lib/bump.glsl
#include lumi:shaders/lib/apply_bump.glsl

/******************************************************
  lumi:shaders/material/iron_wood.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBR
    vec4 c = data.spriteColor;
    float min_ = min( min(c.r, c.g), c.b );
    float max_ = max( max(c.r, c.g), c.b );
    float s = max_ > 0 ? (max_ - min_) / max_ : 0;
    if (s < 0.4) {
        data.spriteColor.rgb = min(vec3(1.0), c.rgb * 2);
        pbr_metallic = 1.0;
        pbr_roughness = 0.6 - s * 0.5;
#ifdef LUMI_BUMP
#ifdef LUMI_BUMP_MINERALS
        // if (frx_modelOriginType() == MODEL_ORIGIN_REGION) {
        __applyBump(data);
        // }
#endif
#endif
    }
#endif
}
