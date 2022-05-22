X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_magic_wand",
	"item_falcon_blade",
	"item_power_treads_str",
	"item_black_king_bar",
	"item_sange_and_yasha",
	"item_assault",
	"item_satanic",
	"item_ultimate_scepter_2",
	"item_skadi"
};			

X["builds"] = {
	{2,1,2,1,1,4,1,2,2,3,4,3,3,3,4},
	{2,1,2,3,2,4,2,1,1,1,4,3,3,3,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,4,6,8}, talents
);
return X