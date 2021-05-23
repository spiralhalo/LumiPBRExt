// Hand special case
// ALMOST working if not for the fact that hand animations are all baked
if (frx_modelOriginType() == MODEL_ORIGIN_SCREEN) {
  float rightHand = sign(frx_var2.x);

  float angle = PI * 0.25;
  vec3 ax = vec3(0.0, 1.0, 0.0);
  float s = sin(angle);
  float c = cos(angle);
  float oc = 1.0 - c;
  mat4 r = mat4(       oc * ax.x * ax.x + c,  oc * ax.x * ax.y - ax.z * s,  oc * ax.z * ax.x + ax.y * s,  0.0,
                oc * ax.x * ax.y + ax.z * s,         oc * ax.y * ax.y + c,  oc * ax.y * ax.z - ax.x * s,  0.0,
                oc * ax.z * ax.x - ax.y * s,  oc * ax.y * ax.z + ax.x * s,         oc * ax.z * ax.z + c,  0.0,
                                        0.0,                          0.0,                          0.0,  1.0);

// Restore hand to model space. Works for stationary player only
// * Tangent is still broken for left hand
// * seems broken except for top of block
  frx_var2.xyz -= vec3(0.56 * rightHand, -0.52, -0.71999997);
  frx_var2.xyz = (r * frx_var2).xyz;
  frx_var2.xyz *= 2.5;
  frx_var2.xyz += vec3(0.5);
}
