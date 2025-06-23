SMODS.Atlas {
	-- Key for code to find it with
	key = "bossj_atlas",
	-- The name of the file, for the code to pull the atlas from
	path = "bossj.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

-- Boss joker pool
SMODS.ObjectType({
	key = "BossJ",
	default = "j_chic_chiquito",
	cards = {},

    -- fixes mess from booster packs rarity polling, legendaries no longer appear on packs
    -- Unsure about the rates but everything seems to work properly
    rarities = {
        {
 		    key = 'Common',
 		    rate = 0,
 	    },
        {
 		    key = 'Uncommon',
 		    rate = 0.75,
 	    },
        {
 		    key = 'Rare',
 		    rate = 0.95,
 	    },
        {
 		    key = 'Legendary',
 		    rate = 1, -- idk if its right, seems to work but maybe it doesn't matter and its already cutting legendaries out
 	    },
    },

	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- if warranted, insert base game jokers here
	end,
    
})


-- dealing with not spawning this jokers in the shop
    -- in_pools can detect the source and choose wether or not to insert that way
local CHICconfig = SMODS.current_mod.config
local base_pool = (CHICconfig and CHICconfig.add_to_base_pool) -- Check the config then save it as a local

--[[
-- Boss joker template
SMODS.Joker {
    key = "",
    pos = { x = 0, y = 0 },
    rarity = 1,
    -- blueprint_compat = true,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = {  }, },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,

    loc_txt = {
        ['name'] = '',
        ['text'] = {
            [1] = "",
        }
    },

    calculate = function(self, card, context)
        if context.joker_main then 
            return {
                mult = 4
            }
        end
    end

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}
]]

-- Default, can be in default pools
SMODS.Joker {
    key = "chiquito",
    atlas = "bossj_atlas", pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 3,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = { mult = 15 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    loc_txt = {
        ['name'] = 'Chiquito',
        ['text'] = {
            [1] = "{C:red}+#1#{} Mult",
            [2] = "during {C:attention}Boss Blinds{}"
        }
    },

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.blind and G.GAME.blind.boss then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    in_pool = function(self, args)
        return false
    end
}

--- Suits, boring versions
-- Window, basic diamonds
SMODS.Joker {
    key = "window",
    pos = { x = 6, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    config = { extra = { suit = 'Diamonds' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.suit, 'suits_singular') } }
    end,

    loc_txt = {
        ['name'] = 'The Window',
        ['text'] = {
            [1] = "Turn scored cards into {C:diamonds}#1#{}",
        }
    },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then 
            if not context.other_card:is_suit(card.ability.extra.suit) then
                -- SMODS.change_base(context.other_card, card.ability.suit)
                context.other_card:change_suit(card.ability.extra.suit)
                return {
                    true
                }
            end
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Head, basic hearts
SMODS.Joker {
    key = "head",
    pos = { x = 7, y = 1 },
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    config = { extra = { suit = 'Hearts' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.suit, 'suits_singular') } }
    end,

    loc_txt = {
        ['name'] = 'The Head',
        ['text'] = {
            [1] = "Turn scored cards into {C:hearts}#1#{}",
        }
    },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then 
            if not context.other_card:is_suit(card.ability.extra.suit) then
                context.other_card:change_suit(card.ability.extra.suit)
            end
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Goad, basic spades
SMODS.Joker {
    key = "goad",
    pos = { x = 8, y = 1 },
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    config = { extra = { suit = 'Spades' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.suit, 'suits_singular') } }
    end,

    loc_txt = {
        ['name'] = 'The Club',
        ['text'] = {
            [1] = "Turn scored cards into {C:spades}#1#{}",
        }
    },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then 
            if not context.other_card:is_suit(card.ability.extra.suit) then
                context.other_card:change_suit(card.ability.extra.suit)
            end
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Club, basic clubs
SMODS.Joker {
    key = "club",
    pos = { x = 9, y = 1 },
    rarity = 1,
    blueprint_compat = false,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    config = { extra = { suit = 'Clubs' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.suit, 'suits_singular') } }
    end,

    loc_txt = {
        ['name'] = 'The Club',
        ['text'] = {
            [1] = "Turn scored cards into {C:clubs}#1#{}",
        }
    },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then 
            if not context.other_card:is_suit(card.ability.extra.suit) then
                context.other_card:change_suit(card.ability.extra.suit)
            end
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}
--

-- nonboss blinds joker, meant to represent normal blinds somehow
-- I'd like to make it uncommon, but its tough to keep it thematic
    -- Current idea, after 2 rounds get an economy tag upon selling self
        -- seems silly but $40 are a lot
SMODS.Joker {
    key = "blind_joker",
    atlas = "bossj_atlas", pos = { x = 1, y = 0 },
    rarity = 2,
    blueprint_compat = true, -- If joker is active, works just like copying cola
    cost = 6,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = { current_rounds = 0, total_rounds = 3 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_economy', set = 'Tag', specific_vars= { 40 } }
        return { vars = { card.ability.extra.current_rounds, card.ability.extra.total_rounds, localize { type = 'name_text', set = 'Tag', key = 'tag_economy' } } }
    end,

    loc_txt = {
        ['name'] = 'Blind Joker',
        ['text'] = {
            [1] = "After {C:attention}#2#{} rounds,",
            [2] = "sell this card to",
            [3] = "create a free",
            [4] = "{C:attention}#3#{}",
            [5] = "{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)",
        }
    },

    calculate = function(self, card, context)
        if context.selling_self and card.ability.extra.current_rounds >= card.ability.extra.total_rounds then
            return {
                func = function()
                    -- This is for retrigger purposes, Jokers need to return something to retrigger
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            add_tag(Tag('tag_economy'))
                            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4) -- money sounds?
                            return true
                        end)
                    }))
                end
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.current_rounds = card.ability.extra.current_rounds + 1
            if card.ability.extra.current_rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.current_rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.current_rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end,

    in_pool = function(self, args)
        return true
    end
}

-- Pillar, +mult per card played, round reset
    -- Could be every ante to be closer to blind but idk
SMODS.Joker {
    key = "pillar",
    pos = { x = 7, y = 3 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    config = { extra = { mult = 0, mult_gain = 2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    loc_txt = {
        ['name'] = 'The Pillar',
        ['text'] = {
            [1] = "{C:red}+#2#{} Mult for each",
            [2] = "card played this round,",
            [3] = "resets after each {C:attention}round",
            [4] = "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)"
        }
    },

    calculate = function(self, card, context)

        if context.before and context.main_eval and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + (card.ability.extra.mult_gain * #context.full_hand)
            -- No need to bother with upgrade message, prob more annoying than anything
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.mult = 0
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Hook, returns a played card
SMODS.Joker {
    key = "hook",
    pos = { x = 5, y = 10 }, -- dna sprite
    rarity = 2, -- uncommon fits
    blueprint_compat = false,
    cost = 6,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    config = { extra = { hooked_card = nil }, },
    -- maybe doesnt need loc_vars but whatever
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hooked } }
    end,

    loc_txt = {
        ['name'] = 'The Hook',
        ['text'] = {
            [1] = "Returns {C:attention}last{} played",
            [2] = "card used in scoring",
            [3] = "to your hand",
        }
    },

    -- Discovered context.drawing_cards
    calculate = function(self, card, context)
        if context.drawing_cards and card.ability.extra.hooked_card then
            draw_card(G.discard, G.hand, nil, nil, false, card.ability.extra.hooked_card)
            card.ability.extra.hooked_card = nil
        end
        if context.final_scoring_step then
            card.ability.extra.hooked_card = context.scoring_hand[#context.scoring_hand] -- should get the last scoring card
            print(card.ability.extra.hooked_card.base.value .. " of " .. card.ability.extra.hooked_card.base.suit)
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Manacle, +2 hand size at 0 discards
SMODS.Joker {
    key = "manacle",
    pos = { x = 2, y = 2 },
    rarity = 1,
    blueprint_compat = false; -- Having to consider blueprint is reaaally annoying
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    config = { extra = { h_size = 2, d_remaining = 0, applied = false }, },
    loc_vars = function(self, info_queue, card)
        -- I don't see a reason to return extra.applied but i guess it should always be done?
        return { vars = { card.ability.extra.h_size, card.ability.extra.d_remaining, card.ability.extra.applied } }
    end,

    loc_txt = {
        ['name'] = 'The Manacle',
        ['text'] = {
            [1] = "{C:attention}+#1#{} hand size when",
            [2] = "{C:attention}#2#{} discards",
            [3] = "remaining",
        }
    },

    calculate = function(self, card, context)
        if context.pre_discard and not context.blueprint then
            -- because pre_discard, check discards_left-1
            if (G.GAME.current_round.discards_left-1) == card.ability.extra.d_remaining then
                G.hand:change_size(card.ability.extra.h_size)
                card.ability.extra.applied = true
            -- I think this is an edge case exclusive to like very specific "gain discards during round" mods so irrelevant but also doesnt hurt
            elseif card.ability.extra.applied then
                G.hand:change_size(-card.ability.extra.h_size)
                card.ability.extra.applied = false
            end
        end

        -- the standard way to make sure to reset the extra hand size
        if context.end_of_round and not context.blueprint then
            if card.ability.extra.applied then
                G.hand:change_size(-card.ability.extra.h_size)
                card.ability.extra.applied = false
            end
        end
    end,

    -- this can stay, important edge case
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.applied then
            G.hand:change_size(-card.ability.extra.h_size)
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Psychic, grimbo but 5 cards
SMODS.Joker{
    key="psychic",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 1,
    cost = 4,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    pos = { x = 2, y = 11 }, -- position for grimbo
    config = { extra = { add = 1, sub = 1, mult = 0, size=5 } },

    loc_txt = {
        ['name'] = 'The Psychic',
        ['text'] = {
            [1] = "{C:mult}+#1#{} Mult per {C:attention}#4#{}-card hand played",
            [2] = "{C:mult}-#2#{} Mult otherwise",
            [3] = "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add, card.ability.extra.sub, card.ability.extra.mult, card.ability.extra.size } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            if #context.full_hand == card.ability.extra.size then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.add } }
                }
            else
                local prev_mult = card.ability.extra.mult
                card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.sub)
                if card.ability.extra.mult ~= prev_mult then
                    return {
                        message = localize { type = 'variable', key = 'a_mult_minus', vars = { card.ability.extra.sub } },
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- The Ox, times hand played as cashout
    -- somewhat interesting but perhaps too low scaling
SMODS.Joker {
    key = "ox",
    pos = { x = 7, y = 14 }, -- bull
    rarity = 2,
    blueprint_compat = false,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    config = { extra = { tally_dollars = 0, poker_hand = 'High Card' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.tally_dollars, card.ability.extra.poker_hand } }
    end,

    loc_txt = {
        ['name'] = 'The Ox',
        ['text'] = {
            [1] = "Earn {C:money}half{} the number of times",
            [2] = "the {C:attention}most played poker hand{} has",
            [3] = "been played this run",
            [4] = "at the end of round",
            [5] = "{C:inactive}(Currently {C:attention}#2#{C:inactive}: {C:money}$#1#{C:inactive} )",
        }
    },

    calculate = function(self, card, context)
        if context.joker_main then
            local _hand, _tally = nil, 0
            for k, v in ipairs(G.handlist) do
                if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                    _hand = v
                    _tally = G.GAME.hands[v].played
                end
            end
            card.ability.extra.poker_hand = _hand or "High Card"
            card.ability.extra.tally_dollars =  math.floor(_tally/2)
        end
    end,

    -- alternative to having to put this in loc_vars, should be enough
    set_ability = function(self, card, initial, delay_sprites)
        local _hand, _tally = nil, 0
        for k, v in ipairs(G.handlist) do
            if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                _hand = v
                _tally = G.GAME.hands[v].played
            end
        end
        card.ability.extra.poker_hand = _hand or "High Card"
        card.ability.extra.tally_dollars =  math.floor(_tally/2)
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.tally_dollars
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- House
    -- held cards gain chips on first hand drawn (actually extremely uninteractive)
    -- cards drawn on the first hand give +mult when scored (hard to keep track of)
    -- +mult until you discard (lets settle with this one for now)
SMODS.Joker {
    key = "house",
    pos = { x = 9, y = 15 }, -- castle sprite
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    config = { extra = { mult = 13 }, }, --this is where you have to find a funny reference of a house adress thats also balanced
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    loc_txt = {
        ['name'] = 'The House',
        ['text'] = {
            [1] = "{C:mult}+#1#{} Mult while",
            [2] = "no discards are used",
        }
    },

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.discards_used == 0 then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Wall, xmult -handsize, boring but simple xmult stuntman
SMODS.Joker {
    key = "wall",
    pos = { x = 9, y = 12 }, -- obelisk sprite
    rarity = 3,
    blueprint_compat = true,
    cost = 7,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    -- i'd make it x3 but x4 is the blind's scoring base increase soooo its justified
    config = { extra = { xmult = 4, h_size = 2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.h_size } }
    end,

    loc_txt = {
        ['name'] = 'The Wall',
        ['text'] = {
            [1] = "{X:mult,C:white} X#1# {} Mult,",
            [2] = "{C:attention}-#2#{} hand size",
        }
    },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Wheel, fortune wheel on drawn cards
    -- Pretty happy with it, its funny
SMODS.Joker {
    key = "wheel",
    pos = { x = 9, y = 13 }, -- hallucination sprite
    rarity = 2, -- seems best, too special for common, not good enough for rare I feel like
    blueprint_compat = true, -- perfectly compatible without considering it 
    cost = 6,
    pools = { ["BossJ"] = true },
    unlocked=true,
    discovered = true,

    -- its funny to keep the blind's odds
    config = { extra = { odds = 7, held_cards = {}, cards_drawn = {}}, },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
    end,

    loc_txt = {
        ['name'] = 'The Wheel',
        ['text'] = {
            [1] = "{C:green}#1# in #2#{} chance to add",
            [2] = "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
            [3] = "{C:dark_edition}Polychrome{} edition",
            [4] = "to a drawn {C:attention}playing card{}",
        }
    },

    -- there isnt an easily available table of newly drawn cards, the boss blind does a different thing specifically for flipping cards
    -- so gotta do it myself
    calculate = function(self, card, context)
        -- create a list of cards held before drawing new ones on all contexts that will draw cards
        if context.first_hand_drawn or context.after or context.pre_discard then
            -- remember to reset the lists
            card.ability.extra.held_cards = {}
            for k, v in pairs(G.hand.cards) do
                card.ability.extra.held_cards[k] = v
            end
        end

        -- Upon drawing a new hand, compare the previous and current cards held and apply
        if context.hand_drawn then
            -- remember to reset the lists
            card.ability.extra.cards_drawn = {}
            for k, v in ipairs(G.hand.cards) do
                local already_held = false
                for _k, _v in ipairs(card.ability.extra.held_cards) do
                    if v == _v then
                        already_held = true
                        -- break
                    end
                end
                if not already_held then
                    card.ability.extra.cards_drawn[#card.ability.extra.cards_drawn+1] = v
                end
            end

            -- Operate on the list of only the newly drawn cards
            for k,v in ipairs(card.ability.extra.cards_drawn) do
                -- print(v.base.value .. " of " .. v.base.suit)
                -- pseudorandom of the wheel blind, ig can be used
                if pseudorandom(pseudoseed("ObsidianOrb")) < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
                    -- gathered from vremade wheel tarot 
                    if not v.edition then -- only applies to editionless cards
                        local edition = poll_edition('chic_wheel', nil, true, true, { 'e_polychrome', 'e_holo', 'e_foil' })
                        v:set_edition(edition, true)
                        return -- could maybe be cool for the joker to shake upon adding edition, but idk if its necessary
                    end
                end
            end
            
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- The Arm, retrigger hand upgrades
    -- made a custom context through a toml patch, probably can and should be a hook tho
SMODS.Joker {
    key = "arm",
    pos = { x = 3, y = 5 }, -- space joker sprite
    rarity = 3, -- def rare
    blueprint_compat = true, -- calculate is compatible, not sure if it should be
    cost = 7,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    -- the simplest way I can think of to avoid infinite recursive function
    config = { extra = { active = true }, },
    -- doesn't need loc_vars

    loc_txt = {
        ['name'] = 'The Arm',
        ['text'] = {
            [1] = "Retrigger {C:attention}poker hand{}",
            [2] = "level upgrades"
        }
    },

    calculate = function(self, card, context)
        -- custom context
        if context.chic_leveled_up and card.ability.extra.active then 
            -- scrappy infinite recursion prevention
            card.ability.extra.active = false
            level_up_hand(context.card, context.hand, context.instant, context.amount)
            card.ability.extra.active = true
            
            -- I think its cool to see the message, more funny than annoying with black hole too
            return {
                message = localize('k_level_up_ex')
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Fish, +mult if discard used before hand played
SMODS.Joker {
    key = "fish",
    pos = { x = 1, y = 2 }, -- banner sprite
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    -- idk if there's a smarter way of doing this without relying on a flag but idc
    config = { extra = { mult = 10, active = false }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult } }
    end,

    loc_txt = {
        ['name'] = 'The Fish',
        ['text'] = {
            [1] = "{C:mult}+#1#{} Mult if a discard",
            [2] = "was used before playing the hand"
        }
    },

    calculate = function(self, card, context)
        if (context.setting_blind or context.after) and card.ability.extra.active then
            card.ability.extra.active = false
        end
        if context.pre_discard and not card.ability.extra.active then
            card.ability.extra.active = true
        end
        if context.joker_main and card.ability.extra.active then 
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Water, increase hands or discards to highest count
SMODS.Joker {
    key = "water",
    pos = { x = 6, y = 10 }, -- splash sprite
    rarity = 2,
    blueprint_compat = false, -- It just wouldn't do anything
    cost = 6,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = { hands = 0, discards = 0 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,

    loc_txt = {
        ['name'] = 'The Water',
        ['text'] = {
            [1] = "When {C:attention}Blind{} is selected,",
            [2] = "increase the lowest between {C:blue}Hands{} or {C:red}Discards{}",
            [3] = "to the highest one's value",
        }
    },

    -- doesn't combo, for better or worse, with burglar, which I'm not sure I want
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.cardarea == G.jokers then
            local ret_msg = {}
            if (G.GAME.current_round.hands_left > G.GAME.current_round.discards_left) then
                card.ability.extra.hands = 0
                card.ability.extra.discards = G.GAME.current_round.hands_left - G.GAME.current_round.discards_left
                ret_msg = { message = "+" .. card.ability.extra.discards  .. " Discards!"}
            elseif G.GAME.current_round.hands_left < G.GAME.current_round.discards_left then
                card.ability.extra.hands = G.GAME.current_round.discards_left - G.GAME.current_round.hands_left
                card.ability.extra.discards = 0
                ret_msg = { message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } } }
            end

            ease_discard(card.ability.extra.discards)
            ease_hands_played(card.ability.extra.hands)
            SMODS.calculate_effect(ret_msg, card)
            return {
                true
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Eye, round obelisk, or mult obelisk, lets try just +mult
SMODS.Joker {
    key = "eye",
    pos = { x = 8, y = 10 }, -- sixth sense since the wall alr has obelisk
    rarity = 2, -- its 'consecutive' mechanic could be for a rare but +mult instead of xmult fits more as uncommon
    blueprint_compat = true,
    perishable_compat = false,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = { mult_gain = 3, mult = 0, hands_played = {} }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
    end,

    loc_txt = {
        ['name'] = 'The Eye',
        ['text'] = {
            [1] = "This Joker gains {C:mult}+#1#{} Mult",
            [2] = "for every {C:attention}consecutive{} {C:enhanced}unrepeated{} {C:attention}poker hand{}",
            [3] = "played each round",
            [4] = "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)"
        }
    },

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.hands_played = {}
        end
        if context.before and context.main_eval and not context.blueprint then
            local reset = false
            for k, v in pairs(card.ability.extra.hands_played) do
                if v == context.scoring_name then
                    reset = true
                    break
                end
            end
            
            if reset then
                if card.ability.extra.mult > 0 then
                    card.ability.extra.mult = 0
                    return {
                        message = localize('k_reset')
                    }
                end
            else
                card.ability.extra.hands_played[#card.ability.extra.hands_played+1] = context.scoring_name
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            end
        end
        if context.joker_main then 
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- The Mouth, just make it the eye but same
SMODS.Joker {
    key = "mouth",
    pos = { x = 6, y = 7 }, -- idol sprite, has the biggest mouth
    rarity = 2,
    blueprint_compat = true,
    perishable_compat = false,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = { mult_gain = 3, mult = 0, hand_played = nil }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
    end,

    loc_txt = {
        ['name'] = 'The Mouth',
        ['text'] = {
            [1] = "This Joker gains {C:mult}+#1#{} Mult",
            [2] = "for every {C:attention}consecutive{} {C:enhanced}repeated{} {C:attention}poker hand{}",
            [3] = "played each round",
            [4] = "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)"
        }
    },

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.hand_played = nil
        end
        if context.before and context.main_eval and not context.blueprint then
            local reset = false 
            if card.ability.extra.hand_played then
                if card.ability.extra.hand_played ~= context.scoring_name then
                    reset = true
                end
            else
                -- if i want to be annoying and not increase on first hand, do reset=true here
                card.ability.extra.hand_played = context.scoring_name
            end
            
            if reset then
                if card.ability.extra.mult > 0 then
                    card.ability.extra.hand_played = nil
                    card.ability.extra.mult = 0
                    return {
                        message = localize('k_reset')
                    }
                end
            else
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            end
        end

        if context.joker_main then 
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Plant, smth about face cards, lets get silly and make it sockbuskin + mime lol
SMODS.Joker {
    key = "plant",
    pos = { x = 6, y = 3 }, -- pareidolia sprite
    rarity = 3,
    blueprint_compat = true,
    cost = 6,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = { repetitions = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,

    loc_txt = {
        ['name'] = 'The Plant',
        ['text'] = {
            [1] = "Retrigger all {C:attention}played{}",
            [2] = "and {C:attention}held in hand{} abilities",
            [3] = "of {C:attention}face cards{}"
        }
    },

    calculate = function(self, card, context)
        if context.repetition and (context.cardarea == G.play or (context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) )) and context.other_card:is_face() then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end

    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Serpent, draw additional cards
    -- Rare may be a bit too much but the effect is unique enough to warrant it I think?
    -- Just for the baron synergy should be enough
    -- But outside of that, it can be useful for digging for bigger hands, 
        -- like discarding only a few cards because you're holding many useful cards or for different hands
SMODS.Joker {
    key = "serpent",
    pos = { x = 9, y = 8 }, -- bootstraps sprite, haha get it
    rarity = 3,
    blueprint_compat = false, -- uncompatible without trying, not context.blueprint seems to not do anything, sucks to not have the option but ig its better
    cost = 7,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    -- max_draw=4 fits my original idea better but may be too much, besides 3 is also blind reference 
    config = { extra = { max_draw = 3, draw = 0}, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_draw, card.ability.extra.draw } }
    end,

    loc_txt = {
        ['name'] = 'The Serpent',
        ['text'] = {
            [1] = "Draw up to {C:attention}#1#{} additional",
            [2] = "{C:attention}playing cards{} the less cards",
            [3] = "you've played or discarded"
        }
    },

    calculate = function(self, card, context)
        if not context.first_hand_drawn and (context.discard or context.after) and not context.blueprint and #context.full_hand<= card.ability.extra.max_draw then 
            print(#context.full_hand)
            card.ability.extra.draw = card.ability.extra.max_draw - (#context.full_hand-1)            
        end
        -- context.drawing_cards my saviour
        if not context.first_hand_drawn and context.drawing_cards then 
            for i = 1, card.ability.extra.draw do
                print(i)
                draw_card(G.deck, G.hand,nil, nil, true)
            end
            card.ability.extra.draw = 0
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Needle, scaling if one shot
SMODS.Joker{
    key="needle",
    blueprint_compat = true,
    perishable_compat = false, -- scaling jokers use this ig
    rarity = 2,
    cost = 6,
    pools = { ["BossJ"] = true },

    unlocked=true,
    discovered = true,

    pos = { x = 1, y = 3 }, -- glass joker sprite

    config = { extra = { Xmult_gain = 0.25, Xmult = 1 } },

    loc_txt = {
        ['name'] = 'The Needle',
        ['text'] = {
            [1] = "This Joker gains {X:mult,C:white} X#1# {} Mult",
            [2] = "after beating a round in {C:attention}1{} hand",
            [3] = "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint
        and G.GAME.current_round.hands_left == G.GAME.round_resets.hands-1 then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Tooth, 1$ per scoring card played, not for each score just played as scoring
SMODS.Joker {
    key = "tooth",
    pos = { x = 9, y = 7 }, -- rough gem sprite
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = { dollars = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    loc_txt = {
        ['name'] = 'The Tooth',
        ['text'] = {
            [1] = "Earn {C:money}$#1#{} per",
            [2] = "scoring card played",
        }
    },

    calculate = function(self, card, context)
        if context.before and context.main_eval and context.scoring_hand and #context.scoring_hand > 0 then
            local ret_dollars = (card.ability.extra.dollars * #context.scoring_hand)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + ret_dollars
            return {
                dollars = ret_dollars,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Flint, smth about adding chips and mult as the hand base values
SMODS.Joker {
    key = "flint",
    pos = { x = 8, y = 2 }, -- raised fist, no real reason other than the "twice" tbh
    rarity = 1, -- seems too good for common but too lame for uncommon
    blueprint_compat = true,
    cost = 5,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    --doesn't need config nor loc_vars

    loc_txt = {
        ['name'] = 'The Flint',
        ['text'] = {
            [1] = "Add {C:attention}double{} the base {C:blue}chips{} and {C:mult}Mult{}",
            [2] = "of played {C:attention}poker hand{}"
        }
    },

    calculate = function(self, card, context)
        if context.joker_main then 
            return {
                mult = G.GAME.hands[context.scoring_name].mult * 2,
                chips = G.GAME.hands[context.scoring_name].chips *2
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Mark, just make it +mult if all played cards are face cards, whatever
    -- if want to make it xmult then has to be rare like the poker hand ones, duo tribe etc
SMODS.Joker {
    key = "mark",
    pos = { x = 2, y = 3 }, -- scary face sprite
    rarity = 1, 
    blueprint_compat = true,
    cost = 4,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = { mult = 10 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    loc_txt = {
        ['name'] = 'The Mark',
        ['text'] = {
            [1] = "{C:mult}+#1#{} Mult if all cards",
            [2] = "played are {C:attention}face cards{}"
        }
    },

    calculate = function(self, card, context)
        if context.joker_main then 
            local all_face = true
            for k, v in ipairs(context.scoring_hand) do
                if not v:is_face() then
                    all_face = false
                    break
                end
            end
            if all_face then
                return {
                    mult = card.ability.extra.mult
                }
            end 
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Amber Acorn, copy both sides
    -- I'm uncapable of finding out how to execute multiple blueprint effects, so instead it now retriggers left joker
SMODS.Joker {
    key = "amber_acorn",
    pos = { x = 5, y = 8 }, -- yoric bg sprite
    rarity = 4,
    blueprint_compat = true, -- Needs to be revisited for bugs or to reconsider the effects
    cost = 20,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = { retriggers = 1 } }, 
    loc_vars = function(self, info_queue, card)
        -- ig its not the same to retrigger so idk if i should keep the "compatible" on the left joker
        local right_joker
        if G.jokers and G.jokers.cards then -- idk why vanilla remade doesn't need this
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then right_joker = G.jokers.cards[i + 1] end
            end
        end
        
        local compatible_r = right_joker and right_joker ~= card and right_joker.config.center.blueprint_compat

        main_end = (card.area and card.area == G.jokers) and {
            {
                n = G.UIT.C,
                config = { align = "bm", minh = 0.4 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { ref_table = card, align = "m", colour = compatible_r and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                        nodes = {
                            { n = G.UIT.T, config = { text = 'R: ' .. localize('k_' .. (compatible_r and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                        }
                    }
                }
            },
        } or nil
        return { main_end = main_end }
    end,

    loc_txt = {
        ['name'] = 'Amber Acorn',
        ['text'] = {
            [1] = "Copies ability of ",
            [2] = "{C:attention}Joker{} to the right",
            [3] = "Retriggers",
            [4] = "{C:attention}Joker{} to the left"

        }
    },

    -- Needs to enable retrigger_joker as a mod option in the main file, chicot.lua
    calculate = function(self, card, context)
        local left_joker, right_joker
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then left_joker = G.jokers.cards[i - 1] end
            if G.jokers.cards[i] == card then right_joker = G.jokers.cards[i + 1] end
        end
        -- I'm not sure how the combination of retrigger_joker_check and retrigger_joker works, im just not going to touch this since it works
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
            if left_joker and context.other_card == left_joker 
            and not context.blueprint -- To prevent blueprint from copying itself, since it doesnt check anything, it just retriggers the denominated `left_joker
            then
				return {
					message = localize("k_again_ex"),
					repetitions = card.ability.extra.retriggers,
					card = card,
				}
			else
				return nil, true
			end
        else
            return SMODS.blueprint_effect(card, right_joker, context)
        end
        
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Verdant Leaf, buff cards when selling jokers
    -- maybe go crazy and buff all cards in deck
SMODS.Joker {
    key = "verdant_leaf",
    pos = { x = 7, y = 8 }, -- perkeo bg sprite
    rarity = 4,
    blueprint_compat = true, -- like hiker
    cost = 20,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = { base_chips = 5, base_mult = 1, base_Xmult = 0.5 }, }, -- maybe base * math.floor(rarity * 1.5)
    loc_vars = function(self, info_queue, card)
        -- probably unnecesary to bother but w/e
        local common_chips = card.ability.extra.base_chips * 1 * 2
        local common_mult = card.ability.extra.base_mult * 1 * 2
        local uncommon_chips = card.ability.extra.base_chips * 2 * 2
        local uncommon_mult = card.ability.extra.base_mult * 2 * 2
        local rare_chips = card.ability.extra.base_chips * 3 * 2
        local rare_mult = card.ability.extra.base_mult * 3 * 2
        local rare_Xmult = card.ability.extra.base_Xmult * (3-2)
        local legendary_chips = card.ability.extra.base_chips * 4 * 2
        local legendary_mult = card.ability.extra.base_mult * 4 * 2
        local legendary_Xmult = card.ability.extra.base_Xmult * (4-2)
        return { vars = { common_chips, common_mult, uncommon_chips, uncommon_mult, rare_chips, rare_mult, rare_Xmult, legendary_chips, legendary_mult, legendary_Xmult } }
    end,

    loc_txt = {
        ['name'] = 'Verdant Leaf',
        ['text'] = {
            [1] = "{C:attention}Upgrade{} cards held in hand",
            [2] = "after selling a joker,",
            [3] = "depending on its rarity",
            [4] = "{C:innactive}{C:common}Common{}{C:innactive}: {C:chips}+#1#{}, {C:mult}+#2#{}",
            [5] = "{C:innactive}{C:uncommon}Uncommon{}{C:innactive}: {C:chips}+#3#{}, {C:mult}+#4#{}",
            [6] = "{C:innactive}{C:rare}Rare{}{C:innactive}: {C:chips}+#5#{}, {C:mult}+#6#{}, {X:mult,C:white}X#7# ",
            [7] = "{C:innactive}{C:legendary}Legendary{}{C:innactive}: {C:chips}+#8#{}, {C:mult}+#9#{}, {X:mult,C:white}X#10# ",
        }
    },

    calculate = function(self, card, context)
        -- if I want to keep it as only cards held in hand, make sure its during a blind
        if context.selling_card and G.GAME.blind
        and context.card.config and context.card.config.center and context.card.config.center.rarity then
            local sold_rarity = context.card.config.center.rarity
            local rarity_mod = math.floor(sold_rarity * 2) -- yeah floor is not needed now whatever
            local mod_chips = card.ability.extra.base_chips * rarity_mod
            local mod_mult = card.ability.extra.base_mult * rarity_mod
            local mod_Xmult = nil
            if sold_rarity > 2 then
                -- maybe make base_Xmult = 0.25, but who cares about balance
                mod_Xmult = card.ability.extra.base_Xmult * (sold_rarity-2) -- ugly formula but idc
            end

            -- print(sold_rarity)
            -- print(rarity_mod)
            -- print(mod_Xmult)

            for k, v in ipairs(G.hand.cards) do
                v.ability.perma_bonus = (v.ability.perma_bonus or 0) + (mod_chips or 0)
                v.ability.perma_mult = (v.ability.perma_mult or 0) + (mod_mult or 0)
                v.ability.perma_x_mult = (v.ability.perma_x_mult or 1) + (mod_Xmult or 0)
            end
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RARITY[sold_rarity] -- cheeky
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Violet Vessel, 2x for each joker on the right
SMODS.Joker{
    key="violet_vessel",
    blueprint_compat = true,
    rarity = 4,
    cost = 20,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    pos = { x = 3, y = 8 }, -- canio bg sprite, not purple but process of elimination
    config = { extra = { Xmult=2} },

    loc_txt = {
        ['name'] = 'Violet Vessel',
        ['text'] = {
            [1] = "{X:mult,C:white} X#1# {} Mult for each joker",
            [2] = "to the right of this one",
            [3] = "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        }
    },

    loc_vars = function(self, info_queue, card)
        -- just repeating the calculate here, idk what would be better
            -- balatro modding dev discord agrees repeating the function is pretty much the only option
        local joker_count = 0
        if G.jokers then -- gotta add this or it explodes when looking at this from collection and challenge preview
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    for j=i, #G.jokers.cards do -- counts this card as well, otherwise j=i+1
                        joker_count = joker_count + 1
                    end 
                end
                
            end
        end
        
        return { vars = { card.ability.extra.Xmult, (card.ability.extra.Xmult * joker_count) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local joker_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    for j=i, #G.jokers.cards do -- counts this card as well
                        joker_count = joker_count + 1
                    end 
                end
            end
            return {
                xmult = card.ability.extra.Xmult * joker_count
            }
        end
    end,
    -- blueprint seems to only copy the returning xmult instead of calculating it on their own, 
        -- i guess good enough for now

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Crimson Heart, idk my original idea "prevent all debuffs and destructions" is far too ambitious and tbh not that good outside of full glass or smth
    -- uhhh create a random joker every hand, whatever
SMODS.Joker {
    key = "crimson_heart",
    pos = { x = 6, y = 8 }, -- chicot bg sprite
    rarity = 4,
    -- blueprint_compat = true,
    cost = 20,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    config = { extra = {  }, },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,

    loc_txt = {
        ['name'] = 'Crimson Heart',
        ['text'] = {
            [1] = "When {C:attention}hand{} is played,",
            [2] = "fill remaining Joker Slots with",
            [3] = "random {C:attention}Jokers{}",
        }
    },

    calculate = function(self, card, context)
        if context.after and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer)
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            key_append = 'chic_crimson_heart' -- Maybe change it to "BossJokerPack", or just rework the joker altogether
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.RARITY.Legendary,
            }
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}

-- Cerulean Bell
    -- scaling xmult, increase when played hand contains specific card, selected from held in hand on hand drawn/ after hand played
        -- comes with custom sticker to signal selected card
SMODS.Joker {
    key = "cerulean_bell",
    pos = { x = 4, y = 8 }, -- triboulet bg sprite
    rarity = 4,
    blueprint_compat = true,
    cost = 20,
    pools = { ["BossJ"] = true },

    unlocked = true,
    discovered = true,

    -- maybe lower xmult_gain to 0.25 if I care about balance
    config = { extra = { Xmult_gain = 0.5, Xmult = 1, selected_card = nil, sticker_key = "chic_chime_sticker"}, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = card.ability.extra.sticker_key, set = 'Other'}
        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,

    loc_txt = {
        ['name'] = 'Cerulean Bell',
        ['text'] = {
            [1] = "Selects a held card upon drawing hand,",
            [2] = "gain {X:mult,C:white} X#1# {} Mult ",
            [3] = "when that card is played in scoring",
            [4] = "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        }
    },

    calculate = function(self, card, context)
        -- Can't find a context for not just after scoring but after finishing drawing cards, like how the blind does it
            --Decided to use custom context, implemented in `drawn_to_hand_context.toml`
        if context.chic_drawn_to_hand and not context.blueprint then

            -- unsure but to keep it consistent, always reset the sticker even if the selected card was left held in hand
            if card.ability.extra.selected_card and card.ability.extra.selected_card.ability[card.ability.extra.sticker_key] then
                card.ability.extra.selected_card:remove_sticker(card.ability.extra.sticker_key)
                card.ability.extra.selected_card = nil
            end

            local random_index = pseudorandom('chic_cerulean_bell', 1, #G.hand.cards)
            card.ability.extra.selected_card = G.hand.cards[random_index]
            card.ability.extra.selected_card:add_sticker(card.ability.extra.sticker_key, true)

            return{
                    message = "Chime!",
                    colour = G.C.blue,
                    card = card.ability.extra.selected_card -- its cool to see the chime card shake
                }
        end

        if context.discard and card.ability.extra.selected_card and not context.blueprint then
            if context.other_card == card.ability.extra.selected_card and context.other_card.ability[card.ability.extra.sticker_key] then
                card.ability.extra.selected_card:remove_sticker(card.ability.extra.sticker_key)
                card.ability.extra.selected_card = nil
            end
        end

        if context.before and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                if v == card.ability.extra.selected_card and v.ability[card.ability.extra.sticker_key] then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                    return{
                        message = localize('k_upgrade_ex'),
                        colour = G.C.MULT, 
                        card = card.ability.extra.selected_card -- its cool to see the chime card shake
                    }
                    
                end
            end
        end

        if (context.setting_blind or context.end_of_round) and card.ability.extra.selected_card and not context.blueprint then
            -- since the sticker doesn't seem to remove itself, has to be done through this joker
            if card.ability.extra.selected_card.ability[ card.ability.extra.sticker_key ] then
                card.ability.extra.selected_card:remove_sticker( card.ability.extra.sticker_key )
            end
            card.ability.extra.selected_card = nil
        end

        if context.joker_main then
            return{
                xmult = card.ability.extra.Xmult
            }
        end
    end,

    -- edge case to guarantee now irrelevant sticker is removed when selling joker
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.selected_card then
            card.ability.extra.selected_card:remove_sticker("chic_chime_sticker")
        end
    end,

    in_pool = function(self, args)
        local ret_bool= base_pool
        if not ret_bool then
            if args.source == 'BossJokerPack' or CHIC.funcs.is_bossJ_available(self.key) then
                ret_bool = true
            end
        end
        return ret_bool
    end
}
-- Atlas for sticker sprite
SMODS.Atlas {
	key = "chic_chime_sticker_atlas",
	path = "chime_sticker.png",
	px = 71,
	py = 95
}
-- Chime sticker for Cerulean Bell
SMODS.Sticker({
    key="chime_sticker",
    badge_colour=G.C.BLUE,
    atlas='chic_chime_sticker_atlas', -- pos 0,0
    default_compat=false, -- should never apply normally except when forced through :add_sticker("sticker_key", true)
    rate=0, -- just to make sure it never naturally appears
    loc_txt = {
        ['name'] = 'Chime',
        ['text'] = {
            [1] = "Play this card in {C:attention}scoring{}",
            [2] = "to upgrade {C:blue}Cerulean Bell{}",
        },
        ['label'] = "Chime"
    },

    --Setting the sticker's position:
        -- "Yeah just make a 71x95 sprite the same way a joker would be but just put the sticker where it should go"
            -- done but the shader is a bit too shiny, noticeable nitpick

    calculate = function(self, card, context)
        -- thought delegating removal here was smart but appereantly this doesn't work
        if context.setting_blind or context.end_of_round then
            for k, v in pairs(G.playing_cards.cards) do
                if v.ability["chic_chime_sticker"] then 
                    v:remove_sticker("chic_chime_sticker")
                end
            end
        end
    end,
})
