/********************************************************
 * lumiext:shaders/lib/bump_bevel.glsl
 ********************************************************
 * Lumi PBR Ext Bevel Bump Library by spiralhalo
 * Generates bevels in border and brick-pattern flavors.
 * LICENSED under LGPL-3.0 and provided WITHOUT WARRANTY.
 ********************************************************/

vec3 bump_bevel_normal(vec2 spriteUV, vec3 regionPos, bool isBrick) 
{
  vec2 mul = vec2(1.0);

  if (isBrick) {
    if (spriteUV.y > 0.5) {
      spriteUV.x = mod(spriteUV.x + 0.5, 1.0);
    }
    spriteUV.y = mod(spriteUV.y, 0.5);
    mul.y = 2.0;
  }

  vec2 eA = smoothstep(vec2(0.0725) * mul, vec2(0.0), spriteUV * mul);
  vec2 eB = smoothstep(vec2(1.0) - vec2(0.0725) * mul, vec2(1.0), spriteUV * mul);
  vec2 eMax = max(eA, eB);

  vec3 normal = vec3(eA.x > eB.x ? -eA.x : eB.x, eA.y > eB.y ? eA.y : -eB.y, 1.0);
  normal.xy = smoothstep(0.0, 0.25, abs(normal.xy)) * sign(normal.xy);
  normal.xy *= eMax.x > eMax.y ? vec2(1.0, 0.0) : vec2(0.0, 1.0);

  return normalize(normal);
}
