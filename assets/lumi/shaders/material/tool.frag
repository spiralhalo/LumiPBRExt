#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/context.glsl
#include frex:shaders/api/world.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/tool.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  #if LUMIEXT_MaterialCoverage == LUMIEXT_MaterialCoverage_ApplyAll
    if (!data.diffuse) {
      #ifdef LUMI_PBRX
        if (data.spriteColor.b > data.spriteColor.r) {
          #if LUMI_PBR_API >= 1
            pbr_f0 = 0.17;
          #endif
          pbr_roughness = 0.05;
          #ifdef LUMIEXT_ApplyBumpDefault
            #ifdef LUMIEXT_ApplyToolBump
              _applyBump_step(data, 0.25, 0.8, false);
            #endif
          #endif
        }
      #endif

    } else {

      #ifdef LUMI_PBRX
        if(!frx_isGui()){
          vec4 c = data.spriteColor;
          float min_ = min( min(c.r, c.g), c.b );
          float max_ = max( max(c.r, c.g), c.b );
          float s = max_ > 0 ? (max_ - min_) / max_ : 0;
          if (s < 0.25 || (c.g > c.b * 2 && max_ > 0.6)) {
            pbr_metallic = 1.0;
            pbr_roughness = 0.6;
            #ifdef LUMIEXT_ApplyBumpDefault
              #ifdef LUMIEXT_ApplyToolBump
                _applyBump_step(data, 0.25, 0.5, false);
              #endif
            #endif
          }
        }
      #endif
    }
    data.diffuse = true;
  #endif
}
