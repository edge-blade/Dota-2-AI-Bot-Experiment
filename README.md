# Dota 2 AI Bot Experiment
Based on FuriousPuppy BotScript to try fixing bots and learn some Lua Scripting. No intent to profit or take advantage of the original source project.

----
#### Useful Bot Scripting Resources:
https://developer.valvesoftware.com/wiki/Dota_Bot_Scripting - Extremely useful reference for checking on what functions Valve will call on the AI scripts

https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting

https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/Abilities_Data_Driven

### Useful Lua Scripting Resources:
https://devhints.io/lua

---
#### Reference to get a VPK.exe

* Add VPK.exe to your path from  `steamapps\common\Source SDK Base 2013 Singleplayer\bin`
* Ensure you have GCFScape installed locally
* Open `pak01_dir.vpk` in the `...\steamapps\common\dota 2 beta\game\dota` folder
* Reference text files are inside the `scripts\npc` folder

---
#### Usage / Testing
Place all script files in `Steam\SteamApps\common\dota 2 beta\game\dota\scripts\vscripts\bots`, and select `default bots` in the practice.

---
#### Basic Breakdown
I believe some of the generic bot scripts will affect NPCs that have AI that a standard player would control, so you may need to account for illusions and other creeps when aborting decision making in things like Item Purchasing for characters like Phantom Lancer, amoung others.

##### Key Files Dota 2 Will Reference
* **bot_generic.lua** -  Main bot script that acts as the entry point for directing bot behavior (ability selection, item selection, practical usage guidelines)
* **hero_selection.lua** - Main bot script that dictates how bots will select their hero composition
* **mode_farm_generic.lua** - establishes farm strategy on lane and if they should attack neutrals
* **mode_rune_generic.lua** - decides behavior surrounding Rune interactions
* **mode_secret_shop_generic.lua** - decides when and how to interact with Secret Shops
* **mode_side_shop_generic.lua** - decides when and how bots will interact with outposts
* **mode_team_roam_generic.lua** - decides how the bots will decide to prioritize skills on enemies during roaming behavior *(traveling to other lanes)*
* **mode_ward_generic.lua** - decides bot behavior on placing wards around the map
* **item_purchase_generic.lua**  - decides how a bot will select items to purchase 

#### Util Files used by other scripts dynamically
* BotData.lua - NOT REFERENCED
* BotNameUtility.lua - Name groupings to assign bot names as if they're "teams"
* botutils.lua - generic repeatable functions to decide bot behavior (abbadon & underlord only reference this currently)
* CampUtility.lua - helper functions around farming and camp assessment
* CourierUtility.lua - courier module that functions like a Class in OO programming
* DebugUtility.lua
* enemy_status.lua - support module for `team_status.lua`
* EnemyUtility.lua - NOT USED - apparent planned support module for referencing enemy team
* inspect.lua
* ItemBuildUtility.lua - helper functions to fill out bot skill & talent tables
* ItemUsageUtility.lua - support file for when, where, and how to use different items
* ItemUtility.lua - utilities defining how items are built and logic surrounding item decisions
* jungle_status.lua - used in meepo bot to decide when jungles are ready to be farmed or have been cleared/reset
* meepo_status.lua - support module to coordinate meepo desires
* MinionUtility.lua - decision making for each minion type
* neutral_spells.lua - *NOT IMPLEMENTED* - Seems to contain ability decision making specific to neutral skills for using via Doom or other NPC Control techniques like Chen
* NewMinionUtil.lua *** new design of of the MinionUtility module
* NewUtility.lua *** new Design of the Utility module
* RoleUtility.lua - Decides role each hero has in order of ranking preference for building out teams
* RuneUtility.lua - lookup mappings for different rune categories
* skillData.lua - *NOT IMPLEMENTED*
* SkillsUtility.lua - Generic utilities for skill decision making
* team_status.lua - utils to help manage which heroes are present and do rough calculations to use for power comparisons bewtween units
* Vectors.lua - Key map location coordinates and definitions to aid in bots decision making
* WardUtility.lua - support file that contains location and logic to decide warding decisions

##### Other
* ability - stores Cast.lua, prototype casting script to be more generic with Casting
* abiilty_item_usage - holds hero specific logic for deciding how bots should behave - this gets loaded per hero based on their name and then dicates ability specific decision making. Otherwise it boilerplate loads generic functions
    * ability_item_usage_generic generalizes decision making for item/glyph usage that is common across most bots. 
* bot
    * dictates how minions of a bot will operate. A minion can be any non-hero NPC e.g. beastmaster animals, brewmaster split, chen conversion, techies remote mines
* builds - item and skill builds that are loaded as a module per hero
* dev_and_plan - playground for trying out other concepts
* npc - reference files for DOTA 2 internals to customize bot scripting since Valve's official scripting wiki seem to not be updated with changes to the game (names and definitions for heroes, abilities, items, status effects, and other NPC units)
