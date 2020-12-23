/********************************************************
 * lumi:shaders/lib/bump_step_s.glsl
 ********************************************************
 * An extension of Lumi Lights PBR bump map generation.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

#include lumi:shaders/lib/bump.glsl

#ifndef VERTEX_SHADER
#ifdef LUMI_BUMP
/* Generate binary bump map by checking texel saturation against a value defined by `step_`.*/
vec3 bump_step_s_normal(sampler2D tex, vec3 normal, vec2 uvn, vec2 uvt, vec2 uvb, float step_, float strength, bool reverse)
{
    vec3 tangentMove = l2_tangent * (reverse ? -1 : 1);
    vec3 bitangentMove = l2_bitangent;
    
    vec4  c         = texture2D(tex, uvn, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0);
    float min_      = min( min(c.r, c.g), c.b );
    float max_      = max( max(c.r, c.g), c.b );
    float s         = (max_ > 0 ? (max_ - min_) / max_ : 0) + (1 - c.a);
    vec3  origin    = (s > step_ ? strength : 0.0) * normal;
    
          c         = texture2D(tex, uvt, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0);
          min_      = min( min(c.r, c.g), c.b );
          max_      = max( max(c.r, c.g), c.b );
          s         = (max_ > 0 ? (max_ - min_) / max_ : 0) + (1 - c.a);
    vec3  tangent   = tangentMove + (s > step_ ? strength : 0.0) * normal - origin;
    
          c         = texture2D(tex, uvb, _cv_getFlag(_CV_FLAG_UNMIPPED) * -4.0);
          min_      = min( min(c.r, c.g), c.b );
          max_      = max( max(c.r, c.g), c.b );
          s         = (max_ > 0 ? (max_ - min_) / max_ : 0) + (1 - c.a);
    vec3  bitangent = bitangentMove + (s > step_ ? strength : 0.0) * normal - origin;

    return normalize(cross(tangent, bitangent));
}
#endif
#endif
