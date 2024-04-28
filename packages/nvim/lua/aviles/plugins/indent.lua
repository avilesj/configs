return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufEnter",
    config = function()
      local highlight = {
        "RainbowYellow",
        "RainbowCyan",
      }

      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
          highlight = { "RainbowYellow" },
        },
        scope = {
          char = "│",
          highlight = { "RainbowCyan" },
        },
      })
    end,
    opts = {},
  },
}
