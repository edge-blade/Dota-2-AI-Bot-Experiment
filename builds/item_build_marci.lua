X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_magic_wand",
	"item_phase_boots",
	"item_basher",
	"item_heavens_halberd",
	"item_monkey_king_bar",
    "item_blink",
    "item_desolator",
	"item_abyssal_blade",
    "item_overwhelming_blink",
	"item_ultimate_scepter_2"
};			

X["builds"] = {
	{1,2,2,1,2,4,2,3,3,3,3,4,1,1,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,3,6,8}, talents
);

return X