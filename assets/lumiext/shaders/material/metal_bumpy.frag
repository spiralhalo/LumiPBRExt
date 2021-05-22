#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/metal_bumpy.frag
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
      // float maxc = max(data.spriteColor.r, max(data.spriteColor.g, data.spriteColor.b)); 
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
      pbr_roughness = 0.8 - frx_luminance(data.spriteColor.rgb) * 0.7;
      // pbr_roughness = mod(frx_var2.xyz + frx_modelOriginWorldPos(), 10.0).z / 10.0; // roughness test material
    #endif
    #ifdef LUMIEXT_ApplyBumpMinerals
      if (frx_var3.z > 1.5 || !data.diffuse) { // the diffuse part is for legacy metal_frame
        _applyBevel(data, frx_var1.zw, frx_var2.xyz, false);
      } else if (frx_var3.z > 0.5) {
        _applyBump(data);
      }
    #endif
  }
  
  data.diffuse = true;
}
