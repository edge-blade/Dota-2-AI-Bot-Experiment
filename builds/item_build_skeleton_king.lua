X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_magic_wand",
	"item_boots",
	"item_armlet",
	"item_phase_boots",
	"item_assault",
	"item_aghanims_shard",
	"item_black_king_bar",
	"item_invis_sword",
	"item_silver_edge",
	"item_ultimate_scepter_2",
	"item_satanic",
};			

X["builds"] = {
	{1,2,1,3,1,4,1,3,3,3,4,2,2,2,4},
	{1,3,1,3,1,4,1,2,3,3,4,2,2,2,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,4,5,8}, talents
);

return X