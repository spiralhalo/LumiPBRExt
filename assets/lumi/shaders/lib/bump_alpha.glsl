/********************************************************
 * lumi:shaders/lib/bump_alpha.glsl
 ********************************************************
 * An extension of Lumi Lights PBR bump map generation.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

/* Generate bumpy edge between solid and transparent texels. */
vec3 bump_alpha_normal(sampler2D tex, vec3 normal, vec2 uvn, vec2 uvt, vec2 uvb, vec2 topRight, vec3 bump_tangent, bool reverse)
{
    vec3 tangentMove = bump_tangent * (reverse ? -1.0 : 1.0);
    vec3 bitangentMove = cross(normal, bump_tangent) * (reverse ? -1.0 : 1.0);

    if (uvn.x > topRight.x) { uvt = uvn; }
    if (uvn.y < topRight.y) { uvb = uvn; }

    vec3 origin = _bump_height(texture2D(tex, uvn, frx_matUnmippedFactor() * -4.0).a) * normal;
    vec3 tangent = tangentMove + _bump_height(texture2D(tex, uvt, frx_matUnmippedFactor() * -4.0).a) * normal - origin;
    vec3 bitangent = bitangentMove + _bump_height(texture2D(tex, uvb, frx_matUnmippedFactor() * -4.0).a) * normal - origin;

    return normalize(cross(tangent, bitangent));
    return vec3(0.0);
}
