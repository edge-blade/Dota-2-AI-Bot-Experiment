X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_bracer",
	"item_magic_wand",
	"item_bracer",
	"item_phase_boots",
	"item_echo_sabre",
	"item_invis_sword",
	"item_cyclone",
	"item_heavens_halberd",
	"item_silver_edge",
	"item_ultimate_scepter",
	"item_wind_waker",
	"item_ultimate_scepter_2",
	"item_monkey_king_bar"
};			

X["builds"] = {
	{1,3,1,3,1,4,1,3,3,2,4,2,2,2,4},
	{1,3,1,2,3,4,1,3,1,3,4,2,2,2,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {1,4,6,8}, talents
);

return X