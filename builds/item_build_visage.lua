X = {};

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_null_talisman",
	"item_null_talisman",
	"item_magic_wand",
	"item_tranquil_boots",
	"item_medallion_of_courage",
	"item_hood_of_defiance",
	"item_rod_of_atos",
	"item_solar_crest",
	"item_pipe",
	"item_assault",
	"item_ultimate_scepter",
	"item_boots_of_bearing",
	"item_ultimate_scepter_2",
	"item_shivas_guard",
};			

X["builds"] = {
	{1,2,1,3,1,4,1,3,3,3,4,2,2,2,4},
	{1,2,3,2,2,4,2,3,3,3,4,1,1,1,4},
	{1,2,3,2,3,4,2,3,2,3,4,1,1,1,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,4,5,8}, talents
);

return X