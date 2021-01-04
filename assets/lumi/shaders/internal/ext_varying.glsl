/***********************************************************
 *  lumi:shaders/internal/ext_varying.glsl                 *
 ***********************************************************/
 
varying vec3 bump_tangent;

#ifdef VERTEX_SHADER
void set_bump_tangent(vec3 normal)
{
    mat4 rotator = mat4(
        0,  0, -1,  0,
        0,  1,  0,  0,
        1,  0,  0,  0,
        0,  0,  0,  1
    );
    vec3 axis_aligned_normal = vec3(normal.x + 0.01, 0, normal.z + 0.01);
        axis_aligned_normal = normalize(axis_aligned_normal);
    bump_tangent = (rotator * vec4(axis_aligned_normal, 0.0)).xyz;
}
#endif
