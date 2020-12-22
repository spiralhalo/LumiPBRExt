#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include lumi:shaders/lib/bump.glsl
#include lumi:shaders/lib/bump_coarse.glsl
#include lumi:shaders/internal/ext_frag.glsl

/******************************************************
  lumi:shaders/material/gem_frame.frag
******************************************************/

void frx_startFragment(inout frx_FragmentData data) 
{
#ifdef LUMI_PBR
  // pbr_metallic = 0.177083 / (frx_luminance(data.spriteColor.rgb));
  pbr_roughness = 0.1;
  #if LUMI_PBR_API >= 1
  pbr_f0 = vec3(0.17);
  #endif
#endif
#ifdef LUMI_BUMP
#ifdef LUMI_ApplyBumpMinerals
  float resolution = 16;
  float coarseness = 0.2;
  vec2 spriteUV = frx_var1.zw;
  vec2 e1 = 1.0-step(0.0625, spriteUV);
  vec2 e2 = step(1.0-0.0625, spriteUV);
  vec2 e = max(e1, e2);
  float frameness = max(e.x, e.y);
  if (frameness > 0) {
    _applyBump(data);
  } else { 
    vec2 uvN = floor(frx_var1.zw * resolution)/resolution;
    vec2 uvT = uvN + vec2(0.5/resolution,0);
    vec2 uvB = uvN + vec2(0,0.5/resolution);
    data.vertexNormal = bump_coarse_normal(data.vertexNormal, uvN, uvT, uvB, coarseness);
    // data.spriteColor.rgb *= (data.vertexNormal + 1) * 0.5;
  }
#endif
#endif
}
