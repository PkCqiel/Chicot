CHIC = {
    mod = SMODS.current_mod,

    CENTERS = {
        boss_joker_dict ={
            ["bl_ox"] = "j_chic_ox",
            ["bl_hook"] = "j_chic_hook",
            ["bl_mouth"] = "j_chic_mouth",
            ["bl_fish"] = "j_chic_fish",
            ["bl_club"] = "j_chic_club",
            ["bl_manacle"] = "j_chic_manacle",
            ["bl_tooth"] = "j_chic_tooth",
            ["bl_wall"] = "j_chic_wall",
            ["bl_house"] = "j_chic_house",
            ["bl_mark"] = "j_chic_mark",

            ["bl_final_bell"] = "j_chic_cerulean_bell", -- final!
            ["bl_wheel"] = "j_chic_wheel",
            ["bl_arm"] = "j_chic_arm",
            ["bl_psychic"] = "j_chic_psychic",
            ["bl_goad"] = "j_chic_goad",
            ["bl_water"] = "j_chic_water",
            ["bl_eye"] = "j_chic_eye",
            ["bl_plant"] = "j_chic_plant",
            ["bl_needle"] = "j_chic_needle",
            ["bl_head"] = "j_chic_head",
            ["bl_final_leaf"] = "j_chic_verdant_leaf", -- final!
            ["bl_final_vessel"] = "j_chic_violet_vessel",
            ["bl_window"] = "j_chic_window",
            ["bl_serpent"] = "j_chic_serpent",
            ["bl_pillar"] = "j_chic_pillar",
            ["bl_flint"] = "j_chic_flint",
            ["bl_final_acorn"] = "j_chic_amber_acorn", -- final!
            ["bl_final_heart"] = "j_chic_crimson_heart", -- final!
        }
    },
    GAME = {
        -- initialized with `["blind_key"] == false` on run reset
        beaten_boss_blinds = {},
        
        -- for c_chic_summon, increases on each use then cycles back
        summon_rarity = 1
    },

    funcs = {
        --- Reset beaten boss list
        reset_beaten_boss_blinds = function ()
            local bosses_list = {}
            for k, v in pairs(G.P_BLINDS) do 
                if v.boss then bosses_list[k] = false end
            end
            CHIC.GAME.beaten_boss_blinds = bosses_list
        end,

        --- Add beaten boss to list
        --- @param boss_blind_key string
        add_beaten_boss_blind = function (boss_blind_key)
            for k, v in pairs(CHIC.GAME.beaten_boss_blinds) do 
                if k==boss_blind_key and not v then 
                    -- v=true doesn't work
                    CHIC.GAME.beaten_boss_blinds[k] = true
                    -- print(CHIC.GAME.beaten_boss_blinds[k])
                    break
                end
            end
        end,

        --- Check if the given joker's associated boss blind has been defeated,
        --- therefore making it available through normal means (shop, bufoon, etc)
        --- @param joker_key string
        is_bossJ_available = function (joker_key)
            -- print("attempting: " .. joker_key)
            -- print(#CHIC.GAME.beaten_boss_blinds) -- why is this 0
            local available = false
            for k, v in pairs(CHIC.GAME.beaten_boss_blinds) do
                if CHIC.CENTERS.boss_joker_dict[ k ] == joker_key -- finds and compares boss_blind with boss joker
                and v -- boss_blind is beaten
                then
                    -- print(joker_key .. " available")
                    available = true
                    break
                end
            end
            return available
        end
    }
}

