#include frex:shaders/api/vertex.glsl
#include lumiext:shaders/internal/vert.glsl

/******************************************************
  lumiext:shaders/material/default_bevel.vert
******************************************************/

void frx_startVertex(inout frx_VertexData data) {
  float bump_resolution = ONE_PIXEL;

#if LUMIEXT_BricksBevelMode == LUMIEXT_BricksBevelMode_TextureBump || LUMIEXT_BevelMode == LUMIEXT_BevelMode_TextureBump
  frx_var0.xy = frx_mapNormalizedUV(data.spriteUV);
  frx_var0.zw = frx_mapNormalizedUV(data.spriteUV + vec2(bump_resolution, 0.0));
  frx_var1.xy = frx_mapNormalizedUV(data.spriteUV + vec2(0.0, -bump_resolution));
  frx_var3.xy = frx_mapNormalizedUV(vec2(1.0, 0.0) + vec2(-bump_resolution, bump_resolution));
#endif

  frx_var3.z = 2.;
  frx_var2.xyzw = data.vertex;
  frx_var1.zw = data.spriteUV;

  // Special tangent for bricks. Can also work with texture bumps if necessary
  // This works poorly for entities or flipped textures. Exotic block slopes are untested
  vec3 c1 = cross(data.normal, vec3(0.0, 0.0, 1.0));
  vec3 c2 = cross(data.normal, vec3(0.0, 1.0, 0.0));
  float mult = data.normal.y > 0.1 ? 1. : -1.;
  l2_tangent = mult * normalize(length(c1) > length(c2) ? c1 : c2);

  // No PBR Ext tangent setup
  // pbrExt_tangentSetup(data.normal);
}
