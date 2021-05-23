/********************************************************
 * lumiext:shaders/lib/bump_bevel.glsl
 ********************************************************
 * Lumi PBR Ext Bevel Bump Library by spiralhalo
 * Generates bevels in border and brick-pattern flavors.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

vec3 bump_bevel_normal(vec3 vertexNormal, vec2 spriteUV, vec3 regionPos, bool isBrick) 
{
  // COMPUTE MASK
  vec2 e1 = smoothstep(0.0725, 0.0525, spriteUV);
  vec2 e2 = smoothstep(1.0-0.0725, 1.0-0.0525, spriteUV);
  vec2 e = max(e1, e2);
  float mask = max(e.s, e.t); // edge mask
  if (isBrick) {
    float bottom = step(0.5-0.0525, spriteUV.t);
    vec2 m = smoothstep(0.0725, 0.0525, abs(spriteUV - vec2(0.5))); // middle + shaped mask
    m.s *= bottom;                                                  // cut top part of + to get ㅜ
    mask = max(mask * max(1.0 - bottom, e2.t), max(m.s, m.t));      // selective combine with edge mask = brick mask
  }
  if (mask <= 0) { // premature culling
    return vertexNormal;
  }

  // COMPUTE BEVEL CENTER
  //nb: unlike world pos, region pos is always positive
  vec3 model = fract(regionPos - vertexNormal * 0.1); // position roughly within a 1x1 cube
  vec3 center = vec3(0.5, 0.5, 0.5);                       // center of the bevel
  if (isBrick) {
    // 0.0725 < magic number < 0.5 - 0.0725. 0.15 gives smoothest result
    #define _BRICK_FALLBACK_MAGICN 0.15
    
    bool fallback = spriteUV.t < 0.5 && abs(spriteUV.s - 0.5) < _BRICK_FALLBACK_MAGICN; 
    fallback = fallback || spriteUV.t > 0.5 && abs(spriteUV.s - 0.5) > 0.5 - _BRICK_FALLBACK_MAGICN; // use ALG A where ALG B fails
    if (fallback) { // ALG A: nicely brick shaped, but stretched at the sides
      vec3 bitangent = cross(vertexNormal, l2_tangent);
      center += spriteUV.t < 0.5 ? vec3(0.0) : l2_tangent * (-0.5 + floor(spriteUV.s * 2.0));
      center -= bitangent * (-0.25 + 0.5 * floor(spriteUV.t * 2.0));
      model -= center;
      center = vec3(0.);
      model *= 1.0 - abs(l2_tangent) * 0.5;
    } else {        // ALG B: divide one cube into four small cubes, no stretching but has triangle marks
      center = vec3(0.25) + vec3(0.5) * floor(model * 2.0);
    }
  }

  // COMPUTE BEVEL
  center -= vertexNormal * 1.;
  vec3 a = (model - center);
  vec3 b = abs(a);                        // compute in positive space
  float minVal = min(b.x, min(b.y, b.z));
  b -= minVal;                            // make the normal favor one cardinal direction within the texture
  b = pow(normalize(b), vec3(.15));       // make the division between directions sharper, adjustable
  a = sign(a) * b;                        // return to real space
  a = mix(vertexNormal, normalize(a), mask); // apply mask
  return normalize(a + vertexNormal);
}
