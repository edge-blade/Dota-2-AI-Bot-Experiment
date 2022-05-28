X = {}
local IBUtil = require(GetScriptDirectory() .. "/ItemBuildUtility");
local npcBot = GetBot();
local talents = IBUtil.FillTalenTable(npcBot);
local skills  = IBUtil.FillSkillTable(npcBot, IBUtil.GetSlotPattern(1));

X["items"] = {
	"item_magic_wand",
	"item_tranquil_boots",
	"item_blink",
	"item_force_staff",
	"item_black_king_bar",
	--"item_aghanims_shard",
	"item_cyclone",
	"item_ultimate_scepter",
	"item_hurricane_pike",
	"item_wind_waker",
	"item_ultimate_scepter_2",
	"item_octarine_core",
	"item_aghanims_shard",
};

X["builds"] = {
	{1,3,1,2,1,4,1,3,3,3,4,2,2,2,4},
	{1,3,1,3,3,4,3,1,1,2,4,2,2,2,4},
	{1,3,3,2,3,4,3,2,2,2,4,1,1,1,4},
}

X["skills"] = IBUtil.GetBuildPattern(
	  "normal", 
	  IBUtil.GetRandomBuild(X['builds']), skills, 
	  {2,3,6,7}, talents
);

return X