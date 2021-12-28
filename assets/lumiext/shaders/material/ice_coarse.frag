#include frex:shaders/api/fragment.glsl
#include lumiext:shaders/internal/frag.glsl

/******************************************************
  lumiext:shaders/material/ice_coarse.frag
******************************************************/

void frx_materialFragment()
{
  #ifdef LUMI_PBRX
    pbr_roughness = 0.1;
    #ifdef LUMIEXT_ApplyBumpMinerals
      float resRCP = ONE_PIXEL;
      float coarseness = 0.2;
      vec2 uvN = floor(frx_var1.zw / resRCP) * resRCP;
      vec2 uvT = uvN + vec2(0.5 * resRCP, 0.);
      vec2 uvB = uvN + vec2(0., 0.5 * resRCP);
      _applyMicroNormal(bump_coarse_normal(frx_vertexNormal, uvN, uvT, uvB, l2_tangent, coarseness));
      // frx_fragColor.rgb *= (frx_vertexNormal + 1) * 0.5;
    #endif
  #endif
}
