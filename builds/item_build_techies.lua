X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_null_talisman",
	"item_arcane_boots",
	"item_aether_lens",
	"item_kaya",
	"item_ethereal_blade",
	"item_aghanims_shard",
	"item_lotus_orb",
	"item_ultimate_scepter",
	"item_hurricane_pike",
	"item_ultimate_scepter_2",
	"item_octarine_core"
};			

X["builds"] = {
	{1,3,1,3,1,4,1,3,3,2,4,2,2,2,4},
	{1,3,1,2,3,4,1,3,1,3,4,2,2,2,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,3,6,7}, talents
);

return X