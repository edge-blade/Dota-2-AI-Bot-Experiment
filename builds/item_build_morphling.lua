X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(2));

X["items"] = { 
	"item_magic_wand",
	"item_falcon_blade",
	"item_power_treads_agi",
	"item_hurricane_pike",
	"item_manta",
	"item_aghanims_shard",
	"item_skadi",
	"item_butterfly",
	"item_ultimate_scepter_2",
	"item_satanic"
};			

X["builds"] = {
	{3,1,3,2,3,2,3,2,2,4,4,1,1,1,4},
	{3,1,3,2,1,3,1,3,1,4,4,2,2,2,4},
	{3,1,1,3,2,1,3,1,3,2,2,2,4,4,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,3,6,7}, talents
);

return X