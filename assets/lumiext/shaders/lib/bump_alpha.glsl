/********************************************************
 * lumiext:shaders/lib/bump_alpha.glsl
 ********************************************************
 * An extension of Lumi Lights PBR bump map generation.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

/* Generate bumpy edge between solid and transparent texels. */
vec3 bump_alpha_normal(sampler2D tex, vec2 uvn, vec2 uvt, vec2 uvb, vec2 topRight, bool reverse)
{
    vec3 normal = vec3(0.0, 0.0, 1.0);
    vec3 tangentMove = vec3(1.0, 0.0, 0.0) * (reverse ? -1.0 : 1.0);
    vec3 bitangentMove = vec3(0.0, 1.0, 0.0) * (reverse ? -1.0 : 1.0);

    if (uvn.x > topRight.x) { uvt = uvn; }
    if (uvn.y < topRight.y) { uvb = uvn; }

    vec3 origin    =                 _bump_height(textureLod(tex, uvn, 0.0).a) * normal;
    vec3 tangent   = tangentMove   + _bump_height(textureLod(tex, uvt, 0.0).a) * normal - origin;
    vec3 bitangent = bitangentMove + _bump_height(textureLod(tex, uvb, 0.0).a) * normal - origin;

    return normalize(cross(tangent, bitangent));
    return vec3(0.0);
}
