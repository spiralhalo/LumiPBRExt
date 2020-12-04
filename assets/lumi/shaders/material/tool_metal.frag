#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/context.glsl
#include frex:shaders/api/world.glsl
#include lumi:shaders/lib/bump.glsl
#include lumi:shaders/lib/apply_bump.glsl

/******************************************************
  lumi:shaders/material/tool_metal.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBR
  if(!frx_isGui()){
    vec4 c = data.spriteColor;
    float min_ = min( min(c.r, c.g), c.b );
    float max_ = max( max(c.r, c.g), c.b );
    float s = max_ > 0 ? (max_ - min_) / max_ : 0;
    if (s < 0.25 || (c.g > c.b * 2 && max_ > 0.6)) {
      data.spriteColor.rgb += 0.5;
      pbr_metallic = 1.0;
      pbr_roughness = 0.6;
#ifdef LUMI_BUMP
#ifdef LUMI_BUMP_DEFAULT
      _applyBump_step(data, 0.25, 0.5);
#endif
#endif
    }
  }
#endif
}
