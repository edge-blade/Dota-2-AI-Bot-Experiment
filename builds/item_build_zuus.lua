X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_magic_wand",
	"item_null_talisman",
	"item_arcane_boots",
	"item_aether_lens",
	"item_ultimate_scepter",
	--"item_aghanims_shard",
	"item_cyclone",
	"item_octarine_core",
	"item_ultimate_scepter_2",
	"item_ethereal_blade",
	"item_aghanims_shard",
};			

X["builds"] = {
	{1,2,2,1,2,4,2,1,1,3,4,3,3,3,4},
	{1,2,2,3,2,4,2,1,1,1,4,3,3,3,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,4,6,8}, talents
);

return X