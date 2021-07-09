/********************************************************
 * lumiext:shaders/lib/bump2.glsl
 ********************************************************
 * Lumi PBR Ext Texture Bump Library by spiralhalo
 * Generates bumps based on texture brigthness.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

#define _bump_height2(x) sqrt((x.r + x.g + x.b) * 0.33333 * 2.0)
vec3 bump_normal2(sampler2D tex, vec3 normal, vec2 uvn, vec2 uvt, vec2 uvb, vec2 topRight, vec3 l2_tangent, bool reverse)
{
    vec3 tangentMove = l2_tangent * (reverse ? -1.0 : 1.0);
    vec3 bitangentMove = cross(normal, l2_tangent) * (reverse ? -1.0 : 1.0);

    if (uvn.x > topRight.x) { uvt = uvn; }
    if (uvn.y < topRight.y) { uvb = uvn; }

    vec3 texel = lumiext_textureCompat(tex, uvn, frx_matUnmippedFactor() * -4.0).rgb;
    float hn = _bump_height2(texel);
    vec3 origin = hn * normal;
    texel = lumiext_textureCompat(tex, uvt, frx_matUnmippedFactor() * -4.0).rgb;
    float ht = _bump_height2(texel);
    vec3 tangent = tangentMove + ht * normal - origin;
    texel = lumiext_textureCompat(tex, uvb, frx_matUnmippedFactor() * -4.0).rgb;
    float hb = _bump_height2(texel);
    vec3 bitangent = bitangentMove + hb * normal - origin;

    return normalize(cross(tangent, bitangent));
}
