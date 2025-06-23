-- Atlas for tags
SMODS.Atlas {
	key = "chic_tag_atlas",
	path = "tags.png",
	px = 34,
	py = 34
}

-- The first tag, loot tag, is declared alongside its associated deck "champion's deck"

-- Tag for boss joker pack, for testing but probably good to make, 
SMODS.Tag{
    key = "bossj_pack", -- maybe change key to match name
    atlas = "chic_tag_atlas", pos = {x=1,y=0},
    discovered = true,
    config = { type = "store_joker_create" },
    ability = { loot_key = nil },
    loc_txt = {
        ['name'] = "Trophy Tag",
        ['text'] = {
            [1] = "Gives a free",
            [2] = "{C:attention}Jumbo Boss Joker Pack{}",
        }
    },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = {key = "p_chic_booster_chicot2", set = 'Other', specific_vars = {1, 4}}
        return {}
    end,
    apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			tag:yep("+", G.C.SECONDARY_SET.Code, function()
				local key = "p_chic_booster_chicot2"
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = card } })
				card:start_materialize()
				return true
			end)
			tag.triggered = true
			return true
		end
	end,

	in_pool = function()
		return true
	end,
}