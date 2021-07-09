/********************************************************
 * lumiext:shaders/lib/bump_step.glsl
 ********************************************************
 * An extension of Lumi Lights PBR bump map generation.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

/* Generate binary bump map by checking texel luminance against a value defined by `step_`.*/
vec3 bump_step_normal(sampler2D tex, vec3 normal, vec2 uvn, vec2 uvt, vec2 uvb, vec2 topRight, vec3 l2_tangent, float step_, float strength, bool reverse)
{
    vec3 tangentMove = l2_tangent * (reverse ? -1.0 : 1.0);
    vec3 bitangentMove = cross(normal, l2_tangent) * (reverse ? -1.0 : 1.0);

    if (uvn.x > topRight.x) { uvt = uvn; }
    if (uvn.y < topRight.y) { uvb = uvn; }

    vec3 origin = _bump_height(frx_luminance(lumiext_textureCompat(tex, uvn, frx_matUnmippedFactor() * -4.0).rgb) > step_ ? strength : 0.0) * normal;
    vec3 tangent = tangentMove + _bump_height(frx_luminance(lumiext_textureCompat(tex, uvt, frx_matUnmippedFactor() * -4.0).rgb) > step_ ? strength : 0.0) * normal - origin;
    vec3 bitangent = bitangentMove + _bump_height(frx_luminance(lumiext_textureCompat(tex, uvb, frx_matUnmippedFactor() * -4.0).rgb) > step_ ? strength : 0.0) * normal - origin;

    return normalize(cross(tangent, bitangent));
}
