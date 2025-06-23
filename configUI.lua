-- copying extra credit
local CHICconfig = CHIC.mod.config

SMODS.current_mod.config_tab = function() --Config tab
    return {
      n = G.UIT.ROOT,
      config = {
        align = "cm",
        padding = 0.05,
        colour = G.C.CLEAR,
      },
      nodes = {
        create_toggle({
            label = "Add Boss Jokers to base pools (shops, packs, etc) (requires reload)",
            ref_table = CHICconfig,
            ref_value = "add_to_base_pool",
        }),
        create_toggle({
            label = "Load testing challenges (requires reload)",
            ref_table = CHICconfig,
            ref_value = "load_challenges",
        }),
      },
    }
end
