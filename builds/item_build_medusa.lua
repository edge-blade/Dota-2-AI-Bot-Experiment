X = {}
local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_wraith_pact",
	"item_magic_wand",
	"item_power_treads_int",
	"item_dragon_lance",
	"item_maelstrom",
	"item_manta",
	"item_mjollnir",
	"item_skadi",
	"item_ultimate_scepter_2",
	"item_butterfly",
	"item_hurricane_pike"
};			

X["builds"] = {
	{2,3,2,3,2,4,2,3,3,1,4,1,1,1,4},
	{2,3,2,1,3,4,2,3,2,3,4,1,1,1,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,4,6,8}, talents
);

return X