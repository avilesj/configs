return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>p"] = { name = "+projects" },
      },
    },
  },
  {

    "ahmedkhalf/project.nvim",
    lazy = false,
    keys = {
      {
        "<leader>pr",
        function()
          vim.schedule(function()
            vim.cmd("Telescope projects")
          end)
        end,
        desc = "recent projects",
      },
    },
    config = function()
      require("project_nvim").setup({})
      require("telescope").load_extension("projects")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
}
