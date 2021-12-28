#include frex:shaders/api/vertex.glsl
#include lumiext:shaders/internal/vert.glsl

/******************************************************
  lumiext:shaders/material/default_bumpless.vert
******************************************************/

void frx_materialVertex() {
  float bump_resolution = ONE_PIXEL;
// Unused
//   frx_var0.xyzw
//   frx_var1.xy
//   frx_var3.xy
  frx_var3.z = 0.;
  frx_var2.xyzw = frx_vertex;
  frx_var1.zw = frx_texcoord;
  pbrExt_tangentSetup(frx_vertexNormal);
}
