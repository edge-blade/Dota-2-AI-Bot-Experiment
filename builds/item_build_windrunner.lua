X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_magic_wand",
	"item_phase_boots",
	"item_maelstrom",
	"item_black_king_bar",
	"item_ultimate_scepter",
	"item_orchid",
	"item_bloodthorn",
	"item_mjollnir",
	"item_monkey_king_bar",
	"item_ultimate_scepter_2",
	"item_nullifier"
};			

X["builds"] = {
	{3,2,2,1,3,4,2,2,1,1,4,1,3,3,4},
	{2,3,2,1,2,4,2,3,3,3,4,1,1,1,4},
	{3,2,2,1,2,4,2,1,1,1,4,3,3,3,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,4,6,7}, talents
);

return X