-- Booster Atlas
SMODS.Atlas{
    key = 'boosteratlas',
    path = 'boosteratlas.png',
    px = 71,
    py = 95,
}

-- Normal
SMODS.Booster{
    key = 'booster_chicot1',
    atlas = 'boosteratlas', pos = { x = 0, y = 0 },
    discovered = true,
    loc_txt= {
        name = 'BOSS JOKER BOOSTER PACK',
        group_name = "Boss Pack",
        text = { 
            "Pick {C:attention}#1#{} card out",
            "{C:attention}#2#{} Boss jokers!",
        },
    },
    
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 1, -- testing
    cost = 5,
    kind = "BossJokerPack",
    
    create_card = function(self, card, i)
        ease_background_colour(HEX("ffac00"))
        return SMODS.create_card({
            set = "BossJ",
            area = G.pack_cards,
            skip_materialize = true,
            key_append = 'BossJokerPack' -- for checking the source of creation, letting me control availability
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}

-- Jumbo
SMODS.Booster{
    key = 'booster_chicot2',
    atlas = 'boosteratlas', pos = { x = 1, y = 0 },
    discovered = true,
    loc_txt= {
        name = "BOSS JOKER PACK",
        group_name = "Boss Pack",
        text = { 
            "Pick {C:attention}#1#{} card out of",
            "{C:attention}#2#{} Boss jokers!",
        },
    },
    
    draw_hand = false,
    config = {
        extra = 4,
        choose = 1,
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    weight = 0.66,
    cost = 7,
    kind = "BossJokerPack",
    
    create_card = function(self, card, i)
        ease_background_colour(HEX("ffac00"))
        return SMODS.create_card({
            set = "BossJ",
            area = G.pack_cards,
            skip_materialize = true,
            key_append = 'BossJokerPack' -- for checking the source of creation, letting me control availability
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}