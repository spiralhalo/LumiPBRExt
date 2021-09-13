#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/metal_bumpy.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  // Wrought Iron and Cauldron
  if (data.emissivity > 0) {
    data.emissivity = 0;
    data.spriteColor *= 1.5;
  }

#ifdef LUMI_PBRX
  pbr_metallic = 1.0;
  pbr_roughness = 0.8 - frx_luminance(data.spriteColor.rgb) * 0.7;
  // pbr_roughness = mod(frx_var2.xyz + frx_modelOriginWorldPos(), 10.0).z / 10.0; // roughness test material
#endif
#ifdef LUMIEXT_ApplyBumpMinerals
  if (frx_var3.z > 1.5 || !data.diffuse) { // the diffuse part is for legacy metal_frame
    _applyBevel(data, false);
  } else if (frx_var3.z > 0.5) {
    _applyBump(data);
  }
#endif
  
  data.diffuse = true;
}
