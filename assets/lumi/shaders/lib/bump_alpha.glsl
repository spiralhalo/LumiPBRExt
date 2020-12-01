/********************************************************
 * lumi:shaders/lib/bump_alpha.glsl
 ********************************************************
 * An extension of Lumi Lights PBR bump map generation.
 * Licensed under LGPL-3.0 and provided without warranty.
 ********************************************************/

#include lumi:shaders/lib/bump_alpha.glsl

vec3 bump_alpha_normal(sampler2D tex, vec3 normal, vec2 uvn, vec2 uvt, vec2 uvb)
{
    vec3 tangentMove = _bump_tangentMove(normal);
    vec3 bitangentMove = _bump_bitangentMove(normal, tangentMove);

    vec3 origin = _bump_height(texture2D(tex, uvn, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).a) * normal;
    vec3 tangent = tangentMove + _bump_height(texture2D(tex, uvt, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).a) * normal - origin;
    vec3 bitangent = bitangentMove + _bump_height(texture2D(tex, uvb, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).a) * normal - origin;

    return normalize(cross(tangent, bitangent));
}
