#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/world.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/armor_metal.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBRX
  pbr_metallic = 1.0;
  pbr_roughness = 0.5;
  // data.spriteColor.rgb *= 2;
#endif
#ifdef LUMI_BUMP
#ifdef LUMIEXT_ApplyBumpDefault
  _applyBump(data);
  // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
#endif
}
