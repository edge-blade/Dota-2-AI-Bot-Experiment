--[[
    	"Ability1"		"marci_grapple"
		"Ability2"		"marci_companion_run"
		"Ability3"		"marci_guardian"
		"Ability4"		"generic_hidden"
		"Ability5"		"generic_hidden"
		"Ability6"		"marci_unleash"
		
		"AbilityDraftAbilities"
		{
			"Ability1"		"marci_grapple"
			"Ability2"		"marci_companion_run"
			"Ability3"		"marci_guardian"
			"Ability6"		"marci_unleash"
		}	

		"Ability10"		"special_bonus_armor_5"
		"Ability11"		"special_bonus_mp_regen_2"
		"Ability12"		"special_bonus_unique_marci_grapple_stun_duration"
		"Ability13"		"special_bonus_unique_marci_lunge_range"
		"Ability14"		"special_bonus_unique_marci_guardian_lifesteal"
		"Ability15"		"special_bonus_movement_speed_30"
		"Ability16"		"special_bonus_unique_marci_unleash_silence"
		"Ability17"		"special_bonus_unique_marci_guardian_magic_immune"
]]

if GetBot():IsInvulnerable() or not GetBot():IsHero() or not string.find(GetBot():GetUnitName(), "hero") or  GetBot():IsIllusion() then
	return;
end

local ability_item_usage_generic = dofile( GetScriptDirectory().."/ability_item_usage_generic" )
local utils = require(GetScriptDirectory() ..  "/util")
local mutil = require(GetScriptDirectory() ..  "/MyUtility")

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

local npcBot = GetBot();

local abilityQ = nil;
local abilityW = nil;
local abilityE = nil;
local abilityR = nil;

local castQDesire = 0;
local castWDesire = 0;
local castEDesire = 0;
local castRDesire = 0;

local qTarget = nil;
local wTarget = nil;
local eTarget = nil;

local castWLoc = nil;

function AbilityUsageThink()
	
	if npcBot:IsUsingAbility() or npcBot:IsChanneling() or npcBot:IsSilenced() then return end
	
	if abilityQ == nil then abilityQ = npcBot:GetAbilityByName( "marci_grapple" ) end
	if abilityW == nil then abilityW = npcBot:GetAbilityByName( "marci_companion_run" ) end
	if abilityE == nil then abilityE = npcBot:GetAbilityByName( "marci_guardian" ) end
	if abilityR == nil then abilityR = npcBot:GetAbilityByName( "marci_unleash" ) end


	castQDesire, qTarget            = ConsiderQ();
	castWDesire, castWLoc, wTarget	= ConsiderW();
	castEDesire, eTarget   			= ConsiderE();
	castRDesire    					= ConsiderR();

	if ( castWDesire > 0  and mutil.IsValidTarget(wTarget)) 
	then
		npcBot:ActionQueue_UseAbilityOnEntity(abilityW, wTarget);
		npcBot:ActionQueue_UseAbilityOnLocation(abilityW, castWLoc);
		return;
	end

	if ( castQDesire > 0 ) 
	then
		npcBot:ActionQueue_UseAbilityOnEntity( abilityQ, qTarget );
		return;
	end

	if ( castEDesire > 0 ) 
	then
		npcBot:Action_UseAbilityOnEntity( abilityE, eTarget );
		return;
	end

	if ( castRDesire > 0 ) 
	then
		npcBot:Action_UseAbility( abilityR );
		return;
	end
	
end

function ConsiderQ()

	-- Make sure it's castable
	if ( not abilityW:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, nil;
	end

	-- Get some of its values
	local nCastRange = abilityW:GetCastRange( );
	local nDamage    = abilityW:GetAbilityDamage( );
			
	local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nCastRange + 200, true, BOT_MODE_NONE );
	
	--if we can kill any enemies
	for _,npcEnemy in pairs(tableNearbyEnemyHeroes)
	do
		if mutil.CanCastOnNonMagicImmune(npcEnemy) and ( mutil.CanKillTarget(npcEnemy, nDamage, DAMAGE_TYPE_MAGICAL) or npcEnemy:IsChanneling() ) then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy;
		end
	end
	
	-- If we're seriously retreating, see if we can land a stun on someone who's damaged us recently
	if mutil.IsRetreating(npcBot)
	then
		if tableNearbyEnemyHeroes ~= nil and #tableNearbyEnemyHeroes >= 1 then
			return BOT_ACTION_DESIRE_LOW, tableNearbyEnemyHeroes[1];
		end
	end
		
	-- If we're going after someone
	if mutil.IsGoingOnSomeone(npcBot)
	then
		local npcTarget = npcBot:GetTarget();
		if mutil.IsValidTarget(npcTarget) and mutil.CanCastOnNonMagicImmune(npcTarget) and mutil.IsInRange(npcTarget, npcBot, nCastRange+200) 
            and not mutil.IsDisabled(true, npcTarget) 		
		then
			return BOT_ACTION_DESIRE_HIGH, npcTarget;
		end
	end
	
	return BOT_ACTION_DESIRE_NONE, nil;

end

function ConsiderW()

	-- Make sure it's castable
	if ( not abilityW:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, 0, nil;
	end

	-- Get some of its values
	local nCastRange = abilityW:GetCastRange();
	local nMinDistance = 450;
	local nMaxDistance = 800;
	local nDamage    = abilityW:GetSpecialValueInt('impact_damage');
	
	-- Get allies that are valid jump targets
	local tableNearbyAlliedHeroes = npcBot:GetNearbyHeroes(nCastRange, false, BOT_MODE_NONE);
	for _,npcAlly in pairs(tableNearbyAlliedHeroes)
	do
		local tableNearbyEnemyHeroes = npcAlly:GetNearbyHeroes(nMaxDistance, true, BOT_MODE_NONE );
		for _,npcEnemy in pairs(tableNearbyEnemyHeroes)
		do
			-- check if enemy is in castable distance
			local allyDistanceToEnemy = GetUnitToUnitDistance(npcAlly, npcEnemy)
			if allyDistanceToEnemy >= nMinDistance then
				-- if we can kill the enemy
				if mutil.CanCastOnMagicImmune(npcEnemy) and mutil.CanKillTarget(npcEnemy, nDamage, DAMAGE_TYPE_MAGICAL) then
					return BOT_ACTION_DESIRE_HIGH, npcEnemy:GetLocation(), npcAlly;
				end
				
				-- If we're going after someone
				if mutil.IsGoingOnSomeone(npcBot)
				then
					local npcTarget = npcBot:GetTarget();
					if mutil.IsValidTarget(npcTarget) and mutil.CanCastOnMagicImmune(npcTarget)
					then
						return BOT_ACTION_DESIRE_HIGH, npcTarget:GetLocation(), npcAlly;
					end
				end

			end
		end
		
		-- If we're seriously retreating, see if we can land a stun on someone who's damaged us recently
		if mutil.IsRetreating(npcBot)
		then
			-- check if anyone is closer to fountain and jump towards fountain
			if npcBot:DistanceFromFountain() > npcAlly:DistanceFromFountain() then
				return BOT_ACTION_DESIRE_HIGH, GetShopLocation(GetTeam(), SHOP_HOME), npcAlly;
			end
		end
	end
	
	return BOT_ACTION_DESIRE_NONE, 0, nil;

end

function ConsiderE()

	-- Make sure it's castable
	if ( not abilityE:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE, nil;
	end

	-- Get some of its values
	local nCastRange = abilityE:GetCastRange();
	
	if  npcBot:GetActiveMode() == BOT_MODE_FARM 
	    and not mutil.StillHasModifier(npcBot, 'modifier_marci_guardian')
	then
		local tableNearbyCreeps  = npcBot:GetNearbyCreeps( 400, true );
		if tableNearbyCreeps ~= nil and #tableNearbyCreeps >= 2 then
			return BOT_ACTION_DESIRE_HIGH, npcBot;
		end		
	end	
	
	if ( npcBot:GetActiveMode() == BOT_MODE_ROSHAN  ) 
		and not mutil.StillHasModifier(npcBot, 'modifier_marci_guardian')
	then
		local npcTarget = npcBot:GetAttackTarget();
		if ( mutil.IsRoshan(npcTarget) and mutil.CanCastOnMagicImmune(npcTarget) and mutil.IsInRange(npcTarget, npcBot, 325) )
		then
			return BOT_ACTION_DESIRE_LOW, npcBot;
		end
	end

	if mutil.IsInTeamFight(npcBot, 1200) or  mutil.IsPushing(npcBot) or mutil.IsDefending(npcBot)
	then
		local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE );
	    
		if tableNearbyEnemyHeroes ~= nil and #tableNearbyEnemyHeroes >= 1 then
			local tableNearbyAllyHeroes = npcBot:GetNearbyHeroes( nCastRange + 200, false, BOT_MODE_NONE );
			local highesAD = 0;
			local highesADUnit = nil;
			
			for _,npcAlly in pairs( tableNearbyAllyHeroes )
			do
				local AllyAD = npcAlly:GetAttackDamage();
				if ( mutil.CanCastOnNonMagicImmune(npcAlly) 
					and not mutil.StillHasModifier(npcAlly, 'modifier_marci_guardian') 
					and AllyAD > highesAD ) 
				then
					highesAD = AllyAD;
					highesADUnit = npcAlly;
				end
			end
			
			if highesADUnit ~= nil then
				return BOT_ACTION_DESIRE_HIGH, highesADUnit;
			end
		
		end	
		
	end
	
	-- If we're going after someone
	if mutil.IsGoingOnSomeone(npcBot)
		and not mutil.StillHasModifier(npcBot, 'modifier_marci_guardian')
	then
		local npcTarget = npcBot:GetTarget();
		if mutil.IsValidTarget(npcTarget) and mutil.CanCastOnMagicImmune(npcTarget) and mutil.IsInRange(npcTarget, npcBot, 350) 
		then
			return BOT_ACTION_DESIRE_HIGH, npcBot;
		end
	end
	
	return BOT_ACTION_DESIRE_NONE, nil;

end

function ConsiderR()
	
	if ( not abilityR:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE;
	end
	
	if mutils.IsGoingOnSomeone(npcBot)
	then
		local target = npcBot:GetTarget();
		if mutils.IsValidTarget(target) 
			and mutils.CanCastOnMagicImmune(target) 
			and mutils.IsInRange(target, npcBot, 500)  
		then
			return BOT_ACTION_DESIRE_HIGH;
		end
	end
	
	return BOT_ACTION_DESIRE_NONE;
end