return {
  "ahmedkhalf/project.nvim",
  lazy = false,
  keys = {
    {
      "<leader>pr",
      function()
        require("lazy").load({ plugins = { "project_nvim" } })
        vim.schedule(function()
          vim.cmd("Telescope projects")
        end)
      end,
    },
  },
  config = function()
    require("project_nvim").setup({})
    require("telescope").load_extension("projects")
  end,
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
}
