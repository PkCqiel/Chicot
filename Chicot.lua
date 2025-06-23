assert(SMODS.load_file("globals.lua"))()
assert(SMODS.load_file("configUI.lua"))() 

assert(SMODS.load_file("src/jokers.lua"))()
assert(SMODS.load_file("src/backs.lua"))()
assert(SMODS.load_file("src/spectrals.lua"))()
assert(SMODS.load_file("src/tags.lua"))()
assert(SMODS.load_file("src/boosters.lua"))()

if CHIC.mod and CHIC.mod.config.load_challenges then
    assert(SMODS.load_file("src/challenges.lua"))()
end

-- icon in the ingame mod menu, modicon.png is the same as trophy tag
-- modicon.png is actually 34x34 but it seems to not matter so whatever
if SMODS.Atlas then
    SMODS.Atlas({
        key = "modicon",
        path = "modicon.png",
        px = 32,
        py = 32
    })
end

-- yoinked from cryptid shhh
-- for loot tag to work, then again I haven't tried if this is actually necessary
function safe_get(t, ...)
	local current = t
	for _, k in ipairs({ ... }) do
		if not current or current[k] == nil then
			return false
		end
		current = current[k]
	end
	return current
end

-- custom function for [champion] deck, get beaten boss blind joker
function get_loot_bossjoker(boss_key)
    -- dictionary of key="bossblind key", value="bossjoker key"
        -- from globals.lua: CHIC.CENTERS.boss_joker_dict
    -- local jkr = G.P_CENTERS[ boss_joker_dict[boss_key] ] or G.P_CENTERS["j_joker"]  -- or (random boss joker among beaten) or (random boss joker)
    local jkr = G.P_CENTERS[ CHIC.CENTERS.boss_joker_dict[boss_key] ] or G.P_CENTERS["j_joker"]
    return jkr

end

-- custom mod optional feature to enable retriggering jokers, necessary for j_chic_amber_acorn
CHIC.mod.optional_features = {
  retrigger_joker = true,
}
-- reset the beaten boss blinds, still far too early to know if this is proper
CHIC.mod.reset_game_globals = function(run_start)
    if run_start then
        CHIC.funcs.reset_beaten_boss_blinds()
    end
end
