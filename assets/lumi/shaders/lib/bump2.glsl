/********************************************************
 * lumi:shaders/lib/bump2.glsl
 ********************************************************
 * An extension of Lumi Lights PBR bump map generation.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

#ifndef VERTEX_SHADER
#ifdef LUMI_BUMP
#define _bump_height2(x) (x.r + x.g + x.b) * 0.33333 * 2.0
vec3 bump_normal2(sampler2D tex, vec3 normal, vec2 uvn, vec2 uvt, vec2 uvb, bool reverse)
{
    vec3 tangentMove = l2_tangent * (reverse ? -1.0 : 1.0);
    vec3 bitangentMove = cross(normal, l2_tangent) * (reverse ? -1.0 : 1.0);

    if (uvn.x > bump_topRightUv.x) { uvt = uvn; }
    if (uvn.y < bump_topRightUv.y) { uvb = uvn; }

    vec3 texel = texture2D(tex, uvn, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).rgb;
    vec3 origin = _bump_height2(texel) * normal;
    texel = texture2D(tex, uvt, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).rgb;
    vec3 tangent = tangentMove + _bump_height2(texel) * normal - origin;
    texel = texture2D(tex, uvb, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0).rgb;
    vec3 bitangent = bitangentMove + _bump_height2(texel) * normal - origin;

    return normalize(cross(tangent, bitangent));
}
#endif
#endif
