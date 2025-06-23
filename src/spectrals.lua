-- Summon, create boss Joker through spectral
    -- I wanted a way to somewhat reliably obtain legendary boss jokers, 
    -- I think this is balanced enough, even if not really cuz legendaries are absurd
SMODS.Consumable {
    key = 'chic_summon',
    set = 'Spectral',
    pos = { x = 5, y = 4 }, -- wraith sprite

    discovered = true,
    unlocked = true,

    config = { extra = { rarity = {'Common', 'Uncommon', 'Rare', 'Legendary'} }, }, -- sadly I cant set the legendary text motion as variable text styling
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.rarity[CHIC.GAME.summon_rarity],
            colours = { G.C.RARITY[ CHIC.GAME.summon_rarity ] }
        } }
    end,

    loc_txt = {
        ['name'] = "Summon",
        ['text'] = {
            [1] = "Create a {C:attention}Boss Joker{},",
            [2] = "{C:enhanced}rarity{} increasing each use",
            [3] = "{C:inactive}(Currently: {V:1}#1#{}{C:inactive})",
            [4] = "Destroy a {C:attention}highest rarity{} Joker",
        }
    },

    use = function(self, card, area, copier)

        --- First obtain deletable_jokers
        local deletable_jokers = {}
        local max_rarity = 1
        for _, joker in pairs(G.jokers.cards) do
            if not joker.ability.eternal then 
                deletable_jokers[#deletable_jokers + 1] = joker

                --- Find max rarity among deletable
                if max_rarity < joker.config.center.rarity then max_rarity = joker.config.center.rarity end
            end
        end

        --- Filter deletable_jokers list only with matching max rarity
        local filtered_deletable_jokers = {}
        for _, joker in pairs(deletable_jokers) do
            if joker.config.center.rarity == max_rarity then filtered_deletable_jokers[#filtered_deletable_jokers + 1] = joker end
        end

        --- Delete random from filtered list
        local chosen_joker = pseudorandom_element(filtered_deletable_jokers, pseudoseed('summon_choice'))
        local _first_dissolve = nil
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                for _, joker in pairs(deletable_jokers) do
                    if joker == chosen_joker then
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                end
                return true
            end
        }))
        delay(0.6)

        -- Create bossJoker, depending on global variable
        local rarity = CHIC.GAME.summon_rarity -- save to local so it won't desync cuz of the delayed event
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'BossJ', rarity = rarity, key_append = "BossJokerPack" })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)

        -- Manage global variable
        if CHIC.GAME.summon_rarity < 4 then
            CHIC.GAME.summon_rarity = CHIC.GAME.summon_rarity+1
        else
            CHIC.GAME.summon_rarity = 1
        end
        
    end,

    -- Only usable if there are deletable jokers, but works even at max jokers (not overflowing) without having to sell any
    can_use = function(self, card)
        local deletable_jokers = {}
        for _, joker in pairs(G.jokers.cards) do
            if not joker.ability.eternal then deletable_jokers[#deletable_jokers + 1] = joker end
        end
        -- jokers.cards-1 to be able to use even at max jokers
        return #deletable_jokers>0 and ( (#G.jokers.cards-1) < G.jokers.config.card_limit or card.area == G.jokers )
    end
}