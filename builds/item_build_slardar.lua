X = {}

local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = { 
	"item_magic_wand",
	"item_power_treads_str",
	"item_echo_sabre",
	"item_blink",
	--"item_aghanims_shard",
	"item_black_king_bar",
	"item_assault",
	"item_ultimate_scepter_2",
	"item_heart",
	"item_overwhelming_blink",
	"item_aghanims_shard",
};			

X["builds"] = {
	{2,1,2,3,2,4,2,1,1,1,4,3,3,3,4},
	{2,1,2,3,1,4,2,1,2,1,4,3,3,3,4}
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,4,6,7}, talents
);

return X