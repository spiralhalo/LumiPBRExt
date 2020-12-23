/********************************************************
 * lumi:shaders/lib/bump_step.glsl
 ********************************************************
 * An extension of Lumi Lights PBR bump map generation.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

#include lumi:shaders/lib/bump.glsl

#ifndef VERTEX_SHADER
#ifdef LUMI_BUMP
/* Generate binary bump map by checking texel luminance against a value defined by `step_`.*/
vec3 bump_step_normal(sampler2D tex, vec3 normal, vec2 uvn, vec2 uvt, vec2 uvb, float step_, float strength)
{
    vec3 tangentMove = l2_tangent;
    vec3 bitangentMove = l2_bitangent;

    vec3 origin = _bump_height(frx_luminance(texture2D(tex, uvn, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).rgb) > step_ ? strength : 0.0) * normal;
    vec3 tangent = tangentMove + _bump_height(frx_luminance(texture2D(tex, uvt, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).rgb) > step_ ? strength : 0.0) * normal - origin;
    vec3 bitangent = bitangentMove + _bump_height(frx_luminance(texture2D(tex, uvb, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).rgb) > step_ ? strength : 0.0) * normal - origin;

    return normalize(cross(tangent, bitangent));
}
#endif
#endif
