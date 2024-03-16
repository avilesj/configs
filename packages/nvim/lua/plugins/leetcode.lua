return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  lazy = true,
  cmd = "Leet",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- configuration goes here
    lang = "golang",
    ---@type table<lc.lang, lc.inject>
    injector = {
      ["golang"] = {
        before = "package main",
      },
    },
    hooks = {
      ---@type fun()[]
      ["enter"] = {
        function()
          vim.cmd([[Copilot disable]])
        end,
      },
    },
  },
  keys = {
    {
      "<leader>lcl",
      function()
        vim.cmd([[Leet]])
      end,
      desc = "Launch Leet",
    },
    {
      "<leader>lct",
      function()
        vim.cmd([[Leet test]])
      end,
      desc = "Run test",
    },
    {
      "<leader>lcm",
      function()
        vim.cmd([[Leet menu]])
      end,
      desc = "Menu",
    },
    {
      "<leader>lcr",
      function()
        vim.cmd([[Leet reset]])
      end,
      desc = "Reset",
    },
    {
      "<leader>lcs",
      function()
        vim.cmd([[Leet submit]])
      end,
      desc = "Submit",
    },
  },
}
