/********************************************************
 * lumiext:shaders/lib/bump2.glsl
 ********************************************************
 * Lumi PBR Ext Texture Bump Library by spiralhalo
 * Generates bumps based on texture brigthness.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

#define _bump_height2(x) sqrt((x.r + x.g + x.b) * 0.33333 * 10.0)
vec3 bump_normal2(sampler2D tex, vec2 uvn, vec2 uvt, vec2 uvb, vec2 topRight, bool reverse)
{
    vec3 normal = vec3(0.0, 0.0, 1.0);
    vec3 tangentMove = vec3(1.0, 0.0, 0.0) * (reverse ? -1.0 : 1.0);
    vec3 bitangentMove = vec3(0.0, 1.0, 0.0) * (reverse ? -1.0 : 1.0);

    if (uvn.x > topRight.x) { uvt = uvn; }
    if (uvn.y < topRight.y) { uvb = uvn; }

    float hn = _bump_height2(lumiext_hd_texture(tex, uvn).rgb);
    float ht = _bump_height2(lumiext_hd_texture(tex, uvt).rgb);
    float hb = _bump_height2(lumiext_hd_texture(tex, uvb).rgb);
    
    vec3 origin = hn * normal;
    vec3 tangent = tangentMove + ht * normal - origin;
    vec3 bitangent = bitangentMove + hb * normal - origin;

    return normalize(cross(tangent, bitangent));
}
