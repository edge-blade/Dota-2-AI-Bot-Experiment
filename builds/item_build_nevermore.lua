X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(3));

X["items"] = { 
	"item_magic_wand",
	"item_power_treads_agi",
	"item_dragon_lance",
	"item_invis_sword",
	"item_black_king_bar",
	--"item_aghanims_shard",
	"item_skadi",
	"item_silver_edge",
	"item_ultimate_scepter_2",
	"item_butterfly",
	"item_hurricane_pike",
	"item_aghanims_shard",
};			

X["builds"] = {
	{2,1,1,2,1,2,1,2,4,3,4,3,3,3,4},
	{2,1,1,2,1,1,2,2,4,3,4,3,3,3,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,4,6,8}, talents
);

return X