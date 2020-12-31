#include frex:shaders/api/vertex.glsl

/******************************************************
  lumi:shaders/material/entity_hi_res.vert
******************************************************/

void frx_startVertex(inout frx_VertexData data) {
  #ifdef LUMI_BUMP
    bump_resolution = 0.0625;
    frx_var1.zw = data.spriteUV;
  #endif
}

void frx_endVertex(inout frx_VertexData data) {
  #ifdef LUMI_BUMP
    frx_var0.xy = uvN;
    frx_var0.zw = uvT;
    frx_var1.xy = uvB;
  #endif
}
