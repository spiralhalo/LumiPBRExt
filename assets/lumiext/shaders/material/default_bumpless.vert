#include frex:shaders/api/vertex.glsl
#include lumiext:shaders/internal/vert.glsl

/******************************************************
  lumiext:shaders/material/default_bumpless.vert
******************************************************/

void frx_startVertex(inout frx_VertexData data) {
  float bump_resolution = ONE_PIXEL;
// Unused
//   frx_var0.xyzw
//   frx_var1.xy
//   frx_var3.xy
  frx_var3.z = 0.;
  frx_var2.xyzw = data.vertex;
  frx_var1.zw = data.spriteUV;
  pbrExt_tangentSetup(data.normal);
}
