/*******************************
 *    User Configurations      *
 *******************************/

// NOTE: These configurations are ignored if Respackopts is present.

// OPTION                        // VALUE  // DESCRIPTION                         // RANGE                                // DEFAULT
#define LUMIEXT_TextureResolution   64     // Bump map resolution                 // 16~2048                              // 16
#define LUMIEXT_MaterialCoverage    0      // Selectively apply materials         // 0: All, 1: Texture pack friendly     // 0
#define LUMIEXT_ApplyBumpMineralsB  1      // Bump map for rocks, gem, and metal  // 0: Disable, 1: Enable                // 1
#define LUMIEXT_BricksBevelMode     0      // Bump map mode for stone* bricks     // 0: Beveled, 1: Texture bump, 2: Off  // 0
#define LUMIEXT_BevelMode           0      // Bump map mode for tile blocks       // 0: Beveled, 1: Texture bump, 2: Off  // 0 
#define LUMIEXT_ApplyBumpLowB       0      // Bump map for low priority materials // 0: Disable, 1: Enable                // 0
#define LUMIEXT_ApplyToolBumpB      1      // Bump map for tool items             // 0: Disable, 1: Enable                // 1
#define LUMIEXT_ApplyBumpDefaultB   1      // Bump map for other materials        // 0: Disable, 1: Enable                // 1
#define LUMIEXT_BaseStoneRoughness  7      // Roughness of natural rocks          // 1~10                                 // 7
#define LUMIEXT_PolishedRoughness   3      // Roughness of polished rocks         // 1~10                                 // 3
#define LUMIEXT_WoodPlanksRoughness 5      // Roughness of wood planks            // 1~10                                 // 5
