if GetBot():IsInvulnerable() or not GetBot():IsHero() or not string.find(GetBot():GetUnitName(), "hero") or  GetBot():IsIllusion() then
	return;
end

local ability_item_usage_generic = dofile( GetScriptDirectory().."/ability_item_usage_generic" )
local utils = require(GetScriptDirectory() ..  "/util")
local mutil = require(GetScriptDirectory() ..  "/MyUtility")

--[[
	"Ability1"		"clinkz_strafe" -- Burning Barrage
	"Ability2"		"clinkz_searing_arrows"
	"Ability3"		"clinkz_wind_walk"
	"Ability4"		"clinkz_burning_army"
	"Ability5"		"generic_hidden"
	"Ability6"		"clinkz_death_pact"
	"Ability10"		"special_bonus_unique_clinkz_1"
	"Ability11"		"special_bonus_unique_clinkz_10"
	"Ability12"		"special_bonus_unique_clinkz_8"
	"Ability13"		"special_bonus_unique_clinkz_2"
	"Ability14"		"special_bonus_attack_range_125"
	"Ability15"		"special_bonus_unique_clinkz_12"
	"Ability16"		"special_bonus_unique_clinkz_4"
	"Ability17"		"special_bonus_unique_clinkz_3"
]]

function AbilityLevelUpThink()  
	ability_item_usage_generic.AbilityLevelUpThink(); 
end
function BuybackUsageThink()
	ability_item_usage_generic.BuybackUsageThink();
end
function CourierUsageThink()
	ability_item_usage_generic.CourierUsageThink();
end
function ItemUsageThink()
	ability_item_usage_generic.ItemUsageThink();
end

local castSTDesire = 0;
local castSADesire = 0;
local castWWDesire = 0;
local castDPDesire = 0;
local castBADesire = 0;

local abilityST = nil;
local abilitySA = nil;
local abilityWW = nil;
local abilityDP = nil;
local abilityBA = nil;

local npcBot = nil;

function AbilityUsageThink()

	if npcBot == nil then npcBot = GetBot(); end
	
	-- Check if we're already using an ability
	if mutil.CanNotUseAbility(npcBot) then return end

	if abilityST == nil then abilityST = npcBot:GetAbilityByName( "clinkz_strafe" ) end
	if abilitySA == nil then abilitySA = npcBot:GetAbilityByName( "clinkz_searing_arrows" ) end
	if abilityWW == nil then abilityWW = npcBot:GetAbilityByName( "clinkz_wind_walk" ) end
	if abilityDP == nil then abilityDP = npcBot:GetAbilityByName( "clinkz_death_pact" ) end
	if abilityBA == nil then abilityBA = npcBot:GetAbilityByName( "clinkz_burning_army" ) end
	-- Consider using each ability
	if abilitySA:IsTrained() then
		ToggleSearingArrow();
	end
	
	castSTDesire, castSTTarget = ConsiderStrafe()
	castSADesire, castSATarget = ConsiderSearingArrows()
	castWWDesire               = ConsiderWindWalk()
	castDPDesire, castDPTarget = ConsiderDeathPack()
	castBADesire, castBATarget = ConsiderBurningArmy()
	
	if castDPDesire > 0
	then
		npcBot:Action_UseAbilityOnEntity(abilityDP, castDPTarget);
		return;
	end
	
	if castSTDesire > 0
	then
		npcBot:Action_UseAbilityOnLocation(abilityST, castSTTarget );
		return;
	end
	
	if castSADesire > 0 
	then
		npcBot:Action_UseAbilityOnEntity(abilitySA, castSATarget);
		return;
	end
	
	if castWWDesire > 0
	then
		npcBot:Action_UseAbility(abilityWW);
		return;
	end
	
	if castBADesire > 0
	then
		npcBot:Action_UseAbilityOnLocation(abilityBA, castBATarget);
		return;
	end
	
end

function ToggleSearingArrow()

	local currManaP = npcBot:GetMana() / npcBot:GetMaxMana();
	local npcTarget = npcBot:GetTarget();
	
	if ( npcTarget ~= nil and 
		( npcTarget:IsHero() or npcTarget:IsTower() or npcTarget:GetUnitName() == "npc_dota_roshan" ) and 
		mutil.CanCastOnNonMagicImmune(npcTarget) and 
		currManaP > .25 
		) 
	then
		if not abilitySA:GetAutoCastState( ) then
			abilitySA:ToggleAutoCast()
		end
	else 
		if  abilitySA:GetAutoCastState( ) then
			abilitySA:ToggleAutoCast()
		end
	end
	
end

function GetMostHPCreep(range)
	local mostHP = nil;
	local maxHP = 0;
	local aCreeps = npcBot:GetNearbyCreeps(range, false);
	
	for i=1, #aCreeps do
		if aCreeps[i]:GetHealth() > maxHP 
			and aCreeps[i]:IsAncientCreep() == false
			and mutil.CanCastOnMagicImmune(aCreeps[i])
		then
			maxHP = aCreeps[i]:GetHealth();
			mostHP = aCreeps[i];
		end
	end
	
	local eCreeps = npcBot:GetNearbyCreeps(range, false);
	
	for i=1, #eCreeps do
		if eCreeps[i]:GetHealth() > maxHP 
			and eCreeps[i]:IsAncientCreep() == false
			and mutil.CanCastOnMagicImmune(eCreeps[i])
		then
			maxHP = eCreeps[i]:GetHealth();
			mostHP = eCreeps[i];
		end
	end
	
	if mostHP ~= nil and mostHP:GetHealth() < 0.50 * mostHP:GetMaxHealth() then
		mostHP = nil;
	end
	
	return mostHP;
end

function ConsiderStrafe()

	-- Make sure it's castable
	if ( abilityE:IsFullyCastable() == false or abilityE:IsTrained() == false ) then 
		return BOT_ACTION_DESIRE_NONE;
	end

	-- Get some of its values
	local nRadius      = 200;
	local nCastRange   = npcBot:GetAttackRange();
	local nAttackRange = npcBot:GetAttackRange( );
		
	if mutil.IsInTeamFight(npcBot, 1200)
	then
		local locationAoE = npcBot:FindAoELocation( true, true, npcBot:GetLocation(), nCastRange, nRadius, 0, 0 );
		if ( locationAoE.count >= 2 ) 
		then
			return BOT_ACTION_DESIRE_LOW, locationAoE.targetloc;
		end
	end

	-- If we're going after someone
	if mutil.IsGoingOnSomeone(npcBot)
	then
		local npcTarget = npcBot:GetTarget();
		if mutil.IsValidTarget(npcTarget) and mutil.CanCastOnNonMagicImmune(npcTarget) and mutil.IsInRange(npcTarget, npcBot, nAttackRange) 
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget:GetLocation();
		end
	end
	
	local skThere, skLoc = mutil.IsSandKingThere(npcBot, nCastRange, 2.0);
	
	if skThere then
		return BOT_ACTION_DESIRE_MODERATE, skLoc;
	end
	
	return BOT_ACTION_DESIRE_NONE, 0;

	
end

function ConsiderSearingArrows()

	if ( not abilitySA:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end

	if abilitySA:GetAutoCastState( ) then
		return BOT_ACTION_DESIRE_NONE, 0;
	end

	local nDamage = npcBot:GetAttackDamage() + abilitySA:GetSpecialValueInt( "damage_bonus" );
	local currManaP = npcBot:GetMana() / npcBot:GetMaxMana();
	local attackRange = npcBot:GetAttackRange()
	
	if npcBot:GetActiveMode() == BOT_MODE_LANING then
		local laneCreeps = npcBot:GetNearbyLaneCreeps(attackRange, true);
		for _,creep in pairs(laneCreeps)
		do
			if creep:GetHealth() <= nDamage and currManaP > 0.25  then
				return BOT_ACTION_DESIRE_LOW, creep;
			end
		end
	end
	
	if ( npcBot:GetActiveMode() == BOT_MODE_ROSHAN  ) 
	then
		local npcTarget = npcBot:GetAttackTarget();
		if ( mutil.IsRoshan(npcTarget) and mutil.CanCastOnMagicImmune(npcTarget) and mutil.IsInRange(npcTarget, npcBot, attackRange)  )
		then
			return BOT_ACTION_DESIRE_LOW, npcTarget;
		end
	end
	
	if npcBot:GetActiveMode() == BOT_MODE_LANING then
		local NearbyEnemyHeroes = npcBot:GetNearbyHeroes(attackRange, true, BOT_MODE_NONE);
		if NearbyEnemyHeroes[1] ~=  nil and mutil.CanCastOnNonMagicImmune(NearbyEnemyHeroes[1]) and currManaP > 0.65  then
			return BOT_ACTION_DESIRE_LOW, NearbyEnemyHeroes[1];
		end
	end
	
	
	return BOT_ACTION_DESIRE_NONE, 0;
	
end

function ConsiderWindWalk()
	
	if ( not abilityWW:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE;
	end
	
	local attackRange = npcBot:GetAttackRange()
	
	if mutil.IsRetreating(npcBot)
	then
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( 1000, true, BOT_MODE_NONE );
		if tableNearbyEnemyHeroes ~= nil and #tableNearbyEnemyHeroes >= 1 then
			return BOT_ACTION_DESIRE_HIGH;
		end
	end

	if mutil.IsGoingOnSomeone(npcBot)
	then
		local npcTarget = npcBot:GetTarget();
		if mutil.IsValidTarget(npcTarget) and not mutil.IsInRange(npcTarget, npcBot, attackRange + 300) 
		then
			return BOT_ACTION_DESIRE_MODERATE;
		end
	end
	
	return BOT_ACTION_DESIRE_NONE;
	
end

function ConsiderDeathPack()

	if ( not abilityDP:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE;
	end
	
	local nCastRange = abilityST:GetCastRange()
	-- local creepLvl = abilityST:GetSpecialValueInt('neutral_level');
	local creepLvl = 25;
	
	if mutil.IsRetreating(npcBot)
	then
		local target = GetMostHPCreep(nCastRange);
		if target ~= nil then
			return BOT_ACTION_DESIRE_LOW, target;
		end
	end
	
	if ( npcBot:GetActiveMode() == BOT_MODE_ROSHAN  ) 
	then
		local target = GetMostHPCreep(nCastRange);
		if target ~= nil then
			return BOT_ACTION_DESIRE_LOW, target;
		end
	end
	
	if mutil.IsGoingOnSomeone(npcBot)
	then
		local npcTarget = npcBot:GetTarget();
		if mutil.IsValidTarget(npcTarget)
			and mutil.CanCastOnMagicImmune(npcTarget)
			and mutil.IsInRange(npcTarget, npcBot, 2500)
		then
			local target = GetMostHPCreep(nCastRange);
			if target ~= nil then
				return BOT_ACTION_DESIRE_LOW, target;
			end
		end
	end
	
	return BOT_ACTION_DESIRE_NONE, 0;
end

function ConsiderBurningArmy()

	if ( abilityBA:IsFullyCastable() == false 
		or abilityBA:IsHidden() == true 
		or npcBot:HasScepter() == false  ) 
	then 
		return BOT_ACTION_DESIRE_NONE, 0;
	end

	local nAttackRange = npcBot:GetAttackRange();
	local nCastRange = abilityDP:GetCastRange();
	
	if mutil.IsInTeamFight(npcBot, 1200)
	then
		local locationAoE = npcBot:FindAoELocation( true, true, npcBot:GetLocation(), nAttackRange, 400, 0, 0 );
		if ( locationAoE.count >= 2 ) then
			skUse = false;
			return BOT_ACTION_DESIRE_LOW, locationAoE.targetloc;
		end
	end
	
	-- If we're going after someone
	if mutil.IsGoingOnSomeone(npcBot)
	then
		local npcTarget = npcBot:GetTarget();
		if mutil.IsValidTarget(npcTarget) and npcTarget:GetHealth() / npcTarget:GetMaxHealth() > 0.25 and mutil.IsInRange(npcTarget, npcBot, nCastRange+200)
		then
			skUse = false;
			return BOT_ACTION_DESIRE_MODERATE, npcTarget:GetLocation();
		end
	end
--
	return BOT_ACTION_DESIRE_NONE, 0;

end
