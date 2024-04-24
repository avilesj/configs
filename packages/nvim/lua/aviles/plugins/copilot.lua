-- return {
--   {
--     "zbirenbaum/copilot.lua",
--     cmd = "Copilot",
--     build = ":Copilot auth",
--     opts = {
--       suggestion = { enabled = false },
--       panel = { enabled = false },
--       filetypes = {
--         markdown = true,
--         help = true,
--       },
--     },
--   },
--   {
--     "zbirenbaum/copilot-cmp",
--     dependencies = "copilot.lua",
--     opts = {},
--     config = function(_, opts)
--       local copilot_cmp = require("copilot_cmp")
--       copilot_cmp.setup(opts)
--       -- attach cmp source whenever copilot attaches
--       -- fixes lazy-loading issues with the copilot cmp source
--     end,
--   },
--   {
--     "nvim-cmp",
--     dependencies = {
--       {
--         "zbirenbaum/copilot-cmp",
--         dependencies = "copilot.lua",
--         opts = {},
--         config = function(_, opts)
--           local copilot_cmp = require("copilot_cmp")
--           copilot_cmp.setup(opts)
--           -- attach cmp source whenever copilot attaches
--         end,
--       },
--     },
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--       table.insert(opts.sources, 1, {
--         name = "copilot",
--         group_index = 1,
--         priority = 100,
--       })
--     end,
--   },
-- }
