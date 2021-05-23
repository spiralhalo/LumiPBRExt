/********************************************
  lumiext:shaders/internal/config.glsl
*********************************************/

#include respackopts:config_supplier
#ifndef respackopts_loaded

#include lumiext:userconfig.glsl

#define LUMIEXT_MaterialCoverage_ApplyAll 0
#define LUMIEXT_MaterialCoverage_NonVanillaFriendly 1

#define LUMIEXT_BricksBevelMode_Beveled 0
#define LUMIEXT_BricksBevelMode_TextureBump 1
#define LUMIEXT_BricksBevelMode_Off 2

#define LUMIEXT_BevelMode_Beveled 0
#define LUMIEXT_BevelMode_TextureBump 1
#define LUMIEXT_BevelMode_Off 2

#if LUMIEXT_ApplyBumpMineralsB == 1
    #define LUMIEXT_ApplyBumpMinerals
#endif
#if LUMIEXT_ApplyBumpLowB == 1
    #define LUMIEXT_ApplyBumpLow
#endif
#if LUMIEXT_ApplyToolBumpB == 1
    #define LUMIEXT_ApplyToolBump
#endif
#if LUMIEXT_ApplyBumpDefaultB == 1
    #define LUMIEXT_ApplyBumpDefault
#endif

/* UNUSED VARIABLES */
// #define LUMIEXT_ApplyArmorBump
// #define LUMIEXT_ApplyEntityBump

#endif // respackopts_loaded

const float ONE_PIXEL = 1. / clamp(float(LUMIEXT_TextureResolution), 0., 2048.);
