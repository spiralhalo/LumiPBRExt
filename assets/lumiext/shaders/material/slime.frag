#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/slime.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  // Wrought Iron and Cauldron
  if (data.emissivity > 0) {
    data.emissivity = 0;
    data.spriteColor *= 1.5;
  }

#ifdef LUMI_PBRX
  pbr_metallic = 0.7;
  pbr_roughness = 0.3 - frx_luminance(data.spriteColor.rgb) * 0.7;
#endif
  
  data.diffuse = true;
}
