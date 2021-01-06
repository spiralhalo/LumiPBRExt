#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/metal_bumpy.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  bool is_liquid = false;
  // Wrought Iron and Cauldron
  if (data.emissivity > 0) {
    data.emissivity = 0;
    if (data.vertexColor.b * 0.8 > data.vertexColor.r) {
      #ifdef LUMI_PBRX
        pbr_roughness = 0.1;
      #endif
      vec3 desat = vec3(frx_luminance(data.vertexColor.rgb));
      data.vertexColor.rgb = mix(data.vertexColor.rgb, desat, 0.7);
      float maxc = max(data.spriteColor.r, max(data.spriteColor.g, data.spriteColor.b)); 
      data.spriteColor.rgb *= data.spriteColor.rgb * data.spriteColor.rgb * 2.0;
      is_liquid = true;
      // data.spriteColor.a = min(0.8, data.spriteColor.a);
    } else {
      // probably lava cauldron ??
      if (data.spriteColor.r * 0.8 > data.spriteColor.b) {
        data.emissivity = 1.0;
        is_liquid = true;
      } 
    }
  }

  if (!is_liquid) {
    #ifdef LUMI_PBRX
      pbr_metallic = 1.0;
      pbr_roughness = 0.5;
    #endif
    #ifdef LUMIEXT_ApplyBumpMinerals
      if (!data.diffuse) {
        vec2 spriteUV = frx_var1.zw;
        vec2 e1 = 1.0-step(0.0625, spriteUV);
        vec2 e2 = step(1.0-0.0625, spriteUV);
        vec2 e = max(e1, e2);
        float frameness = max(e.x, e.y);
        if (frameness > 0) {
          _applyBump(data);
        }
      } else {
        _applyBump(data);
      }
    #endif
  }
  
  data.diffuse = true;
}
