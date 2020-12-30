/********************************************************
 * lumi:shaders/lib/bump_dark.glsl
 ********************************************************
 * An extension of Lumi Lights PBR bump map generation.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

#include lumi:shaders/lib/bump.glsl

#ifndef VERTEX_SHADER
#ifdef LUMI_BUMP
#define _bump_height_dark(x) sqrt(min(1.0, x))

/* Generate bump map by using texel luminance times a multiplier. */
vec3 bump_dark_normal(sampler2D tex, vec3 normal, vec2 uvn, vec2 uvt, vec2 uvb, float colorMult, bool reverse)
{
    vec3 tangentMove = l2_tangent * (reverse ? -1.0 : 1.0);
    vec3 bitangentMove = cross(normal, l2_tangent) * (reverse ? -1.0 : 1.0);

    if (uvn.x > bump_topRightUv.x) { uvt = uvn; }
    if (uvn.y < bump_topRightUv.y) { uvb = uvn; }

    vec3 origin = _bump_height_dark(frx_luminance(texture2D(tex, uvn, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).rgb) * colorMult) * normal;
    vec3 tangent = tangentMove + _bump_height_dark(frx_luminance(texture2D(tex, uvt, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).rgb) * colorMult) * normal - origin;
    vec3 bitangent = bitangentMove + _bump_height_dark(frx_luminance(texture2D(tex, uvb, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).rgb) * colorMult) * normal - origin;

    return normalize(cross(tangent, bitangent));
}
#endif
#endif
