#include frex:shaders/api/vertex.glsl
#include lumiext:shaders/internal/vert.glsl

/******************************************************
  lumiext:shaders/material/entity_hi_res.vert
******************************************************/

void frx_materialVertex() {
  float bump_resolution = 0.0625 * ONE_PIXEL;
  frx_var0.xy = frx_mapNormalizedUV(frx_texcoord);
  frx_var0.zw = frx_mapNormalizedUV(frx_texcoord + vec2(bump_resolution, 0.0));
  frx_var1.xy = frx_mapNormalizedUV(frx_texcoord + vec2(0.0, bump_resolution));
  frx_var3.xy = frx_mapNormalizedUV(vec2(1.0, 0.0) + vec2(-bump_resolution, bump_resolution));
  frx_var3.z = 1.;
  frx_var2.xyzw = frx_vertex;
  frx_var1.zw = frx_texcoord;
  pbrExt_tangentSetup(frx_vertexNormal);
}
