/********************************************************
 * lumi:shaders/lib/bump_coarse.glsl
 ********************************************************
 * An extension of Lumi Lights PBR bump map generation.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

/* Derived from Hash without Sine by David Hoskins, MIT License.
 * https://www.shadertoy.com/view/4djSRW */
float _hash12(vec2 p)
{
	vec3 p3  = fract(vec3(p.xyx) * 10.1313);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

/* Generate random bump map by using a noise function. */
vec3 bump_coarse_normal(vec3 normal, vec2 uvn, vec2 uvt, vec2 uvb, vec3 l2_tangent, float coarseness)
{
    vec3 tangentMove = l2_tangent;
    vec3 bitangentMove = cross(normal, l2_tangent);

    vec3 origin = _bump_height(coarseness * _hash12(uvn)) * normal;
    vec3 tangent = tangentMove + _bump_height(coarseness * _hash12(uvt)) * normal - origin;
    vec3 bitangent = bitangentMove + _bump_height(coarseness * _hash12(uvb)) * normal - origin;

    return normalize(cross(tangent, bitangent));
}
