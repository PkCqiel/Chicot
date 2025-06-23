-- I'd prefer the deck to be more of a sword crest
    -- but since I can't draw, I'm fine with a base recolor, 
    -- based on the palette  of a spanish suit cup
        -- credit: @Gracosef - https://www.reddit.com/r/balatro/comments/1cbym1p/spanishsuited_deck_of_cards_texture_pack/
SMODS.Atlas {
	key = "backs_atlas",
	path = "backs.png",
	px = 71,
	py = 95
}

-- champion's Deck
SMODS.Back {
    key = "champion",
    atlas = "backs_atlas", -- pos = {x=0, y=0},
    unlocked = true,

    loc_txt = {
        ['name'] = "Champion's Deck",
        ['text'] = {
            [1] = "After defeating each",
            [2] = "{C:attention}Boss Blind{}, gain",
            [3] = "that Boss' {C:attention,T:tag_chic_loot}#1#",
        }
    },

    loc_vars = function(self, info_queue, back)
        return { vars = { localize { type = 'name_text', key = 'tag_chic_loot', set = 'Tag' } } }
    end,
    calculate = function(self, back, context)
        -- context and trigger from vremade anaglyph deck
        if context.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then

            local tag = Tag("tag_chic_loot")
            if not tag.ability then
                tag.ability = {}
            end

            local jkr = get_loot_bossjoker(G.GAME.blind.config.blind.key)
            
            if jkr.config.center and jkr.config.center.key == "c_base" then -- I'm not sure what this does, i think its just a check into a default
			    jkr.config.center.key = "j_joker"
		    end
            
            tag.ability.loot_key = jkr.key or jkr.config.center.key

            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(tag)
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    return true
                end
            }))
        end
        
        --[[ Just for debugging, plasma balancing to win faster
        if context.final_scoring_step then
            return {
                balance = true
            }
        end
        ]]
    end,
}

-- Basing all this heavily on cryptid rework tag
SMODS.Tag{
    key = "loot",
    atlas = "chic_tag_atlas", pos = {x=0,y=0},
    discovered = true,
    config = { type = "store_joker_create" },
    ability = { loot_key = nil },
    loc_txt = {
        ['name'] = "Loot Tag",
        ['text'] = {
            [1] = "Shop has a",
            [2] = "{C:attention}Boss Joker{}: {C:enhanced}#1#",
            [3] = "{C:inactive}Exclusive to: {C:attention}#2#{}"
        }
    },
    loc_vars = function(self, info_queue, tag)
        return {
			vars = {
                safe_get(tag, "ability","loot_key") and
				localize({ type = "name_text", set = "Joker", key = tag.ability.loot_key })
                    or localize({ type = "name_text", set = "Joker", key = "j_chic_chiquito" }),
                G.P_CENTERS["b_chic_champion"].loc_txt['name']
			},
		}
    end,
    apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = create_card("BossJ", context.area, nil, nil, nil, nil, (tag.ability.loot_key )) -- or "j_chic_chiquito", unnecessary cuz its default
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.FILTER, function()
				card:start_materialize()
                card.ability.couponed = true
                card:set_cost()
				return true
			end)
			tag.triggered = true

            -- from cryptid, appereantly useful to prevent bugs
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.5,
				func = function()
					save_run() --fixes savescum bugs hopefully?
					return true
				end,
			}))
			return card
		end
	end,

    -- If I can manage to make it activated after beating the boss joker while held then maybe add to pool, otherwise nah
	in_pool = function()
		return false
	end,
    --- Either find out how to properly duplicate or prevent duplications,
    --- for preventing, its in tag.lua, line 355 if self.name == 'Double Tag' and _context.tag.key ~= 'tag_double' then
    --- Otherwise, one way to fix duplicates would be to save the last beaten boss blind as a global and make the tag read from there, 
        --- though that may cause timing issues cuz the deck adds the tag before cashout, while beaten boss is registered after
}
