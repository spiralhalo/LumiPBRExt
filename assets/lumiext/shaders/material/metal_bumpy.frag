#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/metal_bumpy.frag
******************************************************/

void frx_materialFragment()
{
  bool isCut = frx_fragEmissive > 0.0;
  frx_fragEmissive = 0.0;

  bool waxed = !frx_fragEnableDiffuse;

  // doesn't seem to affect iron/gold/netherite... in vanilla pack anyway
  float weathered = max(0.0, (frx_sampleColor.g + frx_sampleColor.b * 0.5) - frx_sampleColor.r * 1.5);

#ifdef LUMI_PBRX
  pbr_metallic = max(0.0, 1.0 - weathered * 2.0);
  pbr_roughness = waxed ? 0.2 : 0.8 - frx_luminance(frx_sampleColor.rgb) * 0.7;
  pbr_roughness = mix(pbr_roughness, 1.0, weathered);
  // pbr_roughness = mod(frx_var2.xyz + frx_modelOriginWorldPos(), 10.0).z / 10.0; // roughness test material
#endif

#ifdef PBR_ENABLED
#ifdef LUMIEXT_ApplyBumpMinerals
  if (frx_var3.z > 1.5) {
    _applyBevel2(isCut);
  } else if (frx_var3.z > 0.5) {
    _applyBump();
  }
#endif
#endif
  
  frx_fragEnableDiffuse = true;
}
