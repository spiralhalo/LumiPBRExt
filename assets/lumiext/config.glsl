/*******************************
 *  lumiext:config.glsl        *
 *******************************/

/*******************************
 *  SYSTEM -SKIP THIS SECTION- *
 *******************************/

#include respackopts:config_supplier
#ifndef respackopts_loaded

#define LUMIEXT_MaterialCoverage_ApplyAll 0
#define LUMIEXT_MaterialCoverage_NonVanillaFriendly 1

#define LUMIEXT_BricksBevelMode_Beveled 0
#define LUMIEXT_BricksBevelMode_TextureBump 1
#define LUMIEXT_BricksBevelMode_Off 2

#define LUMIEXT_BevelMode_Beveled 0
#define LUMIEXT_BevelMode_TextureBump 1
#define LUMIEXT_BevelMode_Off 2



/*******************************
 * vv CONFIGURATIONS START vv  *
 *******************************/

/* Texture resolution (default = 16)
 ***********************************/
#define LUMIEXT_TextureResolution 64

/* Material coverage
 * 0 = apply all materials
 * 1 = don't apply materials that are fine-tuned for vanilla (good for 3rd party resource pack)
 ***********************************************************************************************/
#define LUMIEXT_MaterialCoverage 0

/* Apply bumps to stone, metal and gems 
 * Comment out to disable
 * ("Comment out" means adding double slash at the beginning)
 ***************************************************************/
#define LUMIEXT_ApplyBumpMinerals
// #define LUMIEXT_ApplyBumpMinerals /* this is example of commented out variable. */

/* Bump mode for *stone Bricks (default = 0)
 * 0 = beveled bumps
 * 1 = texture-based bumps
 * 2 = off
 **********************************************/
#define LUMIEXT_BricksBevelMode 0

/* Bump mode for tile blocks. Same as above (default = 0)
 **********************************************/
#define LUMIEXT_BevelMode 0

/* Uncomment to apply bumps to frequently occuring blocks such as stone
 *************************************************************************/
// #define LUMIEXT_ApplyBumpLow

/* Apply bumps to every other types of blocks
 ***************************************************************/
#define LUMIEXT_ApplyBumpDefault

/* Apply bumps to tools
 ***************************************************************/
#define LUMIEXT_ApplyToolBump
 
/* Material roughness values 
 ****************************************************************************************/
#define LUMIEXT_BaseStoneRoughness 7   // Base stone (1..10, default: 7)
#define LUMIEXT_PolishedRoughness 4    // Smooth and polished stone (1..10, default: 4)
#define LUMIEXT_WoodPlanksRoughness 5  // Wood planks (1..10, default: 5)


/*******************************
 * ^^ CONFIGURATIONS END ^^    *
 *******************************/






/*******************************
 *  SYSTEM -DO NOT EDIT-       *
 *******************************/

/* UNUSED VARIABLES (for now) */
// #define LUMIEXT_ApplyArmorBump
// #define LUMIEXT_ApplyEntityBump

#endif

const float ONE_PIXEL = 1. / clamp(float(LUMIEXT_TextureResolution), 0., 2048.);
