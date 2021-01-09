#include frex:shaders/lib/math.glsl
#include frex:shaders/api/sampler.glsl
#include frex:shaders/api/fragment.glsl
#include frex:shaders/api/material.glsl
#include lumi:ext_config.glsl
#include lumi:shaders/api/param_frag.glsl
#include lumi:shaders/internal/ext_varying.glsl

/* legacy bump height */
#define _bump_height(raw) frx_smootherstep(0, 1, pow(raw, 1 + raw * raw))

#define _bump_height2(x) sqrt((x.r + x.g + x.b) * 0.33333 * 2.0)

#include lumi:shaders/lib/bump2.glsl
#include lumi:shaders/lib/bump_alpha.glsl
#include lumi:shaders/lib/bump_step.glsl
#include lumi:shaders/lib/bump_step_s.glsl
#include lumi:shaders/lib/bump_coarse.glsl

/******************************************************
  lumi:shaders/internal/ext_frag.glsl
******************************************************/

void _applyBump(inout frx_FragmentData data) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal =  bump_normal2(
    frxs_spriteAltas, data.vertexNormal ,
    uvN, uvT, uvB, topRight, bump_tangent, false);
}

void _applyBump(inout frx_FragmentData data, bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal =  bump_normal2(
    frxs_spriteAltas, data.vertexNormal ,
    uvN, uvT, uvB, topRight, bump_tangent, reverse);
}

void _applyBump_alpha(inout frx_FragmentData data, bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal =  bump_alpha_normal(
    frxs_spriteAltas, data.vertexNormal ,
    uvN, uvT, uvB, topRight, bump_tangent, reverse);
}

void _applyBump_step(inout frx_FragmentData data, float step_, float strength, bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal =  bump_step_normal(
    frxs_spriteAltas, data.vertexNormal ,
    uvN, uvT, uvB, topRight, bump_tangent,
    step_, strength, reverse);
}

void _applyBump_step_s(inout frx_FragmentData data, float step_, float strength, bool reverse) 
{
  vec2 topRight = frx_var3.xy;
  vec2 uvN = frx_var0.xy;
  vec2 uvT = frx_var0.zw;
  vec2 uvB = frx_var1.xy;
  data.vertexNormal = bump_step_s_normal(
    frxs_spriteAltas, data.vertexNormal,
    uvN, uvT, uvB, topRight, bump_tangent,
    step_, strength, reverse);
}
