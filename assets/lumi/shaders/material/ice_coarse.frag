#include frex:shaders/api/fragment.glsl
#include lumi:shaders/lib/bump.glsl
#include lumi:shaders/lib/bump_coarse.glsl

/******************************************************
  lumi:shaders/material/ice_coarse.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBR
    pbr_roughness = 0.1;
#ifdef LUMI_BUMP
#ifdef LUMI_BUMP_MINERALS
    float resolution = 64;
    float coarseness = 0.2;
    vec2 uvN = floor(frx_var1.zw * resolution)/resolution;
    vec2 uvT = uvN + vec2(0.5/resolution,0);
    vec2 uvB = uvN + vec2(0,0.5/resolution);
    data.vertexNormal = bump_coarse_normal(data.vertexNormal, uvN, uvT, uvB, coarseness);
    // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
#endif
#endif
#endif
}
