return {
  {
    "stevearc/oil.nvim",
    event = "Syntax",
    opts = {
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["<BS>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    },
    keys = {
      {
        "<leader>ee",
        function()
          local oil = require("oil")
          local git = require("aviles.util.git")

          local cwd = vim.fn.getcwd()
          local git_dir = git.find_git_dir()
          local file_path = vim.fn.expand("%:p:h")

          if git_dir ~= nil then
            return oil.open(git_dir)
          end

          local file_path_length = string.len(file_path)
          local cwd_length = string.len(cwd)
          if cwd_length > file_path_length then
            return oil.open(file_path)
          else
            return oil.open(cwd)
          end
        end,
        desc = "Oil",
      },
      {
        "<leader>er",
        function()
          local oil = require("oil")
          local file_path = vim.fn.expand("%:p:h")
          oil.open(file_path)
        end,
        desc = "Explore current file directory",
      },
      {
        "<leader>ep",
        function()
          local oil = require("oil")
          local git_dir = require("aviles.util.git").find_git_dir()

          if git_dir ~= nil then
            return oil.open(git_dir)
          end

          print("No git directory found")
        end,
        desc = "Explore project",
      },
      {
        "<leader>ec",
        function()
          local oil = require("oil")
          oil.open(vim.fn.getcwd())
        end,
        desc = "Explore current directory",
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
