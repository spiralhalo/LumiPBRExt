#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/context.glsl
#include frex:shaders/api/world.glsl
#include frex:shaders/api/view.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/tool.frag
******************************************************/

void frx_materialFragment()
{
#if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
  if (!frx_fragEnableDiffuse) {

    // tool_gem
    #ifdef PBR_ENABLED
      if (frx_sampleColor.b > frx_sampleColor.r) {
        frx_fragReflectance = 0.17;
        frx_fragRoughness = 0.05;
        #ifdef LUMIEXT_ApplyToolBump
          _applyBump_step(0.25, 0.8, true);
        #endif
      }
    #endif

  } else {

    // tool_metal
    #ifdef PBR_ENABLED
      vec4 c = frx_sampleColor;
      float min_ = min( min(c.r, c.g), c.b );
      float max_ = max( max(c.r, c.g), c.b );
      float s = max_ > 0 ? (max_ - min_) / max_ : 0;
      if (s < 0.25 || (c.g > c.b * 2 && max_ > 0.6)) {
        frx_fragReflectance = 1.0;
        frx_fragRoughness = 0.4;
        #ifdef LUMIEXT_ApplyToolBump
          _applyBump_step(0.25, 0.5, false);
        #endif
      }
    #endif
  }
  frx_fragEnableDiffuse = !frx_isGui;
#endif
}
