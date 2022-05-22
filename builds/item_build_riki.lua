X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_magic_wand",
	"item_power_treads_agi",
	"item_diffusal_blade",
	"item_manta",
	"item_basher",
	"item_butterfly",
	"item_abyssal_blade",
	"item_ultimate_scepter_2",
	"item_skadi",
};			

X["builds"] = {
	{3,2,1,3,3,4,3,2,2,2,4,1,1,1,4},
	{3,1,3,2,3,4,3,2,1,2,4,1,2,1,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,4,6,8}, talents
);

return X