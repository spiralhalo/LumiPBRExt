#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/wrought_iron.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  if (data.vertexColor.b * 0.8 > data.vertexColor.r) {
#ifdef LUMI_PBRX
    pbr_roughness = 0.1;
#endif
    vec3 desat = vec3(frx_luminance(data.vertexColor.rgb));
    data.vertexColor.rgb = mix(data.vertexColor.rgb, desat, 0.7);
    float maxc = max(data.spriteColor.r, max(data.spriteColor.g, data.spriteColor.b)); 
    data.spriteColor.rgb *= data.spriteColor.rgb * data.spriteColor.rgb * 2.0;
    // data.spriteColor.a = min(0.8, data.spriteColor.a);
  } else
  // probably lava cauldron ??
  if (data.spriteColor.r * 0.8 > data.spriteColor.b) {
    data.emissivity = 1.0;
  } else {
#ifdef LUMI_PBRX
    pbr_metallic = 1.0;
    pbr_roughness = 0.5;
    data.spriteColor.rgb *= 2;
#endif
#ifdef LUMI_BUMP
#ifdef LUMIEXT_ApplyBumpMinerals
  _applyBump(data);
  // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
#endif
  }
}
