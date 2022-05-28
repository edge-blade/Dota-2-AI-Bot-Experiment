X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_magic_wand",
	"item_power_treads_agi",
	"item_dragon_lance",
	"item_yasha",
	"item_black_king_bar",
	"item_manta",
	--"item_aghanims_shard",
	"item_hurricane_pike",
	"item_butterfly",
	"item_ultimate_scepter_2",
	"item_satanic",
	"item_aghanims_shard",
};			

X["builds"] = {
	{3,1,1,2,1,4,1,2,2,2,4,3,3,3,4},
	{3,1,1,3,1,4,1,2,2,2,4,2,3,3,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,4,6,8}, talents
);

return X