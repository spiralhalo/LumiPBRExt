#include frex:shaders/api/fragment.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/ice_coarse.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
  #ifdef LUMI_PBRX
    pbr_roughness = 0.1;
    #ifdef LUMIEXT_ApplyBumpMinerals
      float resolution = 64;
      float coarseness = 0.2;
      vec2 uvN = floor(frx_var1.zw * resolution)/resolution;
      vec2 uvT = uvN + vec2(0.5/resolution,0);
      vec2 uvB = uvN + vec2(0,0.5/resolution);
      data.vertexNormal = bump_coarse_normal(data.vertexNormal, uvN, uvT, uvB, bump_tangent, coarseness);
      // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
    #endif
  #endif
}
