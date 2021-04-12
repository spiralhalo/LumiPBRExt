#include frex:shaders/api/vertex.glsl
#include lumi:shaders/internal/ext_vert.glsl

/******************************************************
  lumi:shaders/material/default.vert
******************************************************/

#define ONE_PIXEL 1.0/16.0
void frx_startVertex(inout frx_VertexData data) {
  float bump_resolution = 0.25 * ONE_PIXEL;
  frx_var0.xy = frx_mapNormalizedUV(data.spriteUV);
  frx_var0.zw = frx_mapNormalizedUV(data.spriteUV + vec2(bump_resolution, 0.0));
  frx_var1.xy = frx_mapNormalizedUV(data.spriteUV + vec2(0.0, -bump_resolution));
  frx_var3.xy = frx_mapNormalizedUV(vec2(1.0, 0.0) + vec2(-bump_resolution, bump_resolution));
  frx_var2.xyzw = data.vertex;
  frx_var1.zw = data.spriteUV;
  pbrExt_tangentSetup(data.normal);
}
