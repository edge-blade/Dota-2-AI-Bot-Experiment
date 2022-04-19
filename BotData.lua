local X = {}

--[[
Basic Role Mappings:
1 = Carry
2 = Mid
3 = Offlaner
4 = Roamer
5 = Hard Support

npc_dota_hero_marci = 4
npc_dota_hero_primal_beast = 3

--]]

X.Roles = {
   ["npc_dota_hero_abaddon"] = 5;
   ["npc_dota_hero_abyssal_underlord"] = 3;
   ["npc_dota_hero_alchemist"] = 1;
   ["npc_dota_hero_ancient_apparition"] = 5;
   ["npc_dota_hero_antimage"] = 1;
   ["npc_dota_hero_arc_warden"] = 1;
   ["npc_dota_hero_axe"] = 3;
   ["npc_dota_hero_bane"] = 5;
   ["npc_dota_hero_batrider"] = 3;
   ["npc_dota_hero_beastmaster"] = 4;
   ["npc_dota_hero_bloodseeker"] = 2;
   ["npc_dota_hero_bounty_hunter"] = 4;
   ["npc_dota_hero_brewmaster"] = 4;
   ["npc_dota_hero_bristleback"] = 3;
   ["npc_dota_hero_broodmother"] = 2;
   ["npc_dota_hero_centaur"] = 3;
   ["npc_dota_hero_chaos_knight"] = 1;
   ["npc_dota_hero_chen"] = 5;
   ["npc_dota_hero_clinkz"] = 2;
   ["npc_dota_hero_crystal_maiden"] = 5;
   ["npc_dota_hero_dark_seer"] = 3;
   ["npc_dota_hero_dark_willow"] = 5;
   ["npc_dota_hero_dawnbreaker"] = 3;
   ["npc_dota_hero_dazzle"] = 5;
   ["npc_dota_hero_death_prophet"] = 2;
   ["npc_dota_hero_disruptor"] = 5;
   ["npc_dota_hero_doom_bringer"] = 3;
   ["npc_dota_hero_dragon_knight"] = 2;
   ["npc_dota_hero_drow_ranger"] = 1;
   ["npc_dota_hero_earthshaker"] = 4;
   ["npc_dota_hero_earth_spirit"] = 4;
   ["npc_dota_hero_elder_titan"] = 4;
   ["npc_dota_hero_ember_spirit"] = 2;
   ["npc_dota_hero_enchantress"] = 5;
   ["npc_dota_hero_enigma"] = 5;
   ["npc_dota_hero_faceless_void"] = 1;
   ["npc_dota_hero_furion"] = 4;
   ["npc_dota_hero_grimstroke"] = 5;
   ["npc_dota_hero_gyrocopter"] = 1;
   ["npc_dota_hero_hoodwink"] = 1;
   ["npc_dota_hero_huskar"] = 2;
   ["npc_dota_hero_invoker"] = 2;
   ["npc_dota_hero_jakiro"] = 5;
   ["npc_dota_hero_juggernaut"] = 1;
   ["npc_dota_hero_keeper_of_the_light"] = 5;
   ["npc_dota_hero_kunkka"] = 2;
   ["npc_dota_hero_legion_commander"] = 3;
   ["npc_dota_hero_leshrac"] = 2;
   ["npc_dota_hero_lich"] = 5;
   ["npc_dota_hero_life_stealer"] = 1;
   ["npc_dota_hero_lina"] = 2;
   ["npc_dota_hero_lion"] = 5;
   ["npc_dota_hero_lone_druid"] = 1;
   ["npc_dota_hero_luna"] = 1;
   ["npc_dota_hero_lycan"] = 3;
   ["npc_dota_hero_magnataur"] = 3;
   ["npc_dota_hero_mars"] = 3;
   ["npc_dota_hero_medusa"] = 1;
   ["npc_dota_hero_meepo"] = 1;
   ["npc_dota_hero_mirana"] = 4;
   ["npc_dota_hero_monkey_king"] = 1;
   ["npc_dota_hero_morphling"] = 1;
   ["npc_dota_hero_naga_siren"] = 1;
   ["npc_dota_hero_necrolyte"] = 2;
   ["npc_dota_hero_nevermore"] = 2;
   ["npc_dota_hero_night_stalker"] = 3;
   ["npc_dota_hero_nyx_assassin"] = 4;
   ["npc_dota_hero_obsidian_destroyer"] = 2;
   ["npc_dota_hero_ogre_magi"] = 5;
   ["npc_dota_hero_omniknight"] = 5;
   ["npc_dota_hero_oracle"] = 5;
   ["npc_dota_hero_pangolier"] = 3;
   ["npc_dota_hero_phantom_assassin"] = 1;
   ["npc_dota_hero_phantom_lancer"] = 1;
   ["npc_dota_hero_phoenix"] = 5;
   ["npc_dota_hero_puck"] = 2;
   ["npc_dota_hero_pudge"] = 4;
   ["npc_dota_hero_pugna"] = 2;
   ["npc_dota_hero_queenofpain"] = 2;
   ["npc_dota_hero_rattletrap"] = 4;
   ["npc_dota_hero_razor"] = 3;
   ["npc_dota_hero_riki"] = 1;
   ["npc_dota_hero_rubick"] = 5;
   ["npc_dota_hero_sand_king"] = 4;
   ["npc_dota_hero_shadow_demon"] = 5;
   ["npc_dota_hero_shadow_shaman"] = 5;
   ["npc_dota_hero_shredder"] = 3;
   ["npc_dota_hero_silencer"] = 4;
   ["npc_dota_hero_skeleton_king"] = 1;
   ["npc_dota_hero_skywrath_mage"] = 5;
   ["npc_dota_hero_slardar"] = 3;
   ["npc_dota_hero_slark"] = 1;
   ["npc_dota_hero_snapfire"] = 5;
   ["npc_dota_hero_sniper"] = 2;
   ["npc_dota_hero_spectre"] = 1;
   ["npc_dota_hero_spirit_breaker"] = 3;
   ["npc_dota_hero_storm_spirit"] = 2;
   ["npc_dota_hero_sven"] = 1;
   ["npc_dota_hero_techies"] = 2;
   ["npc_dota_hero_templar_assassin"] = 2;
   ["npc_dota_hero_terrorblade"] = 1;
   ["npc_dota_hero_tidehunter"] = 4;
   ["npc_dota_hero_tinker"] = 2;
   ["npc_dota_hero_tiny"] = 3;
   ["npc_dota_hero_treant"] = 5;
   ["npc_dota_hero_troll_warlord"] = 1;
   ["npc_dota_hero_tusk"] = 4;
   ["npc_dota_hero_undying"] = 4;
   ["npc_dota_hero_ursa"] = 1;
   ["npc_dota_hero_vengefulspirit"] = 5;
   ["npc_dota_hero_venomancer"] = 5;
   ["npc_dota_hero_viper"] = 2;
   ["npc_dota_hero_visage"] = 5;
   ["npc_dota_hero_void_spirit"] = 2;
   ["npc_dota_hero_warlock"] = 5;
   ["npc_dota_hero_weaver"] = 3;
   ["npc_dota_hero_windrunner"] = 3;
   ["npc_dota_hero_winter_wyvern"] = 5;
   ["npc_dota_hero_wisp"] = 5;
   ["npc_dota_hero_witch_doctor"] = 5;
   ["npc_dota_hero_zuus"] = 2;   
}

return X