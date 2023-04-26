/********************************************************
 * lumiext:shaders/lib/bump_step.glsl
 ********************************************************
 * An extension of Lumi Lights PBR bump map generation.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

/* Generate binary bump map by checking texel luminance against a value defined by `step_`.*/
vec3 bump_step_normal(sampler2D tex, vec2 uvn, vec2 uvt, vec2 uvb, vec2 topRight, float step_, float strength, bool reverse)
{
    vec3 normal = vec3(0.0, 0.0, 1.0);
    vec3 tangentMove = vec3(1.0, 0.0, 0.0) * (reverse ? -1.0 : 1.0);
    vec3 bitangentMove = vec3(0.0, 1.0, 0.0) * (reverse ? -1.0 : 1.0);

    if (uvn.x > topRight.x) { uvt = uvn; }
    if (uvn.y < topRight.y) { uvb = uvn; }

    vec3 origin    =                 _bump_height(frx_luminance(lumiext_texture(tex, uvn).rgb) > step_ ? strength : 0.0) * normal;
    vec3 tangent   = tangentMove   + _bump_height(frx_luminance(lumiext_texture(tex, uvt).rgb) > step_ ? strength : 0.0) * normal - origin;
    vec3 bitangent = bitangentMove + _bump_height(frx_luminance(lumiext_texture(tex, uvb).rgb) > step_ ? strength : 0.0) * normal - origin;

    return normalize(cross(tangent, bitangent));
}
