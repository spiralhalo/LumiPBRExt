#include lumi:shaders/api/pbr_ext.glsl

/***********************************************************
 *  lumi:shaders/internal/ext_vert.glsl                    *
 ***********************************************************/

// Fallback
#if !defined(LUMI_PBR_API) || LUMI_PBR_API < 2
    out vec3 l2_tangent;

    const mat4 _pbrExt_rotm = mat4(
    0,  0, -1,  0,
    0,  1,  0,  0,
    1,  0,  0,  0,
    0,  0,  0,  1 );

    void pbrExt_tangentSetup(vec3 normal)
    {
        vec3 aaNormal = vec3(normal.x + 0.01, 0, normal.z + 0.01);
            aaNormal = normalize(aaNormal);
        l2_tangent = (_pbrExt_rotm * vec4(aaNormal, 0.0)).xyz;
    }
#endif
