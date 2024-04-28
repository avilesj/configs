return {
  {
    "tpope/vim-fugitive",
    name = "fugitive",
    keys = {

      {
        "<leader>gg",
        function()
          vim.cmd.Git()
          vim.cmd("only")
        end,
        desc = "Git",
      },
      {
        "<leader>gp",
        function()
          vim.cmd.Git("pull")
        end,
        desc = "pull",
      },
      {
        "<leader>gP",
        function()
          vim.cmd.Git("push")
        end,
        desc = "Push",
      },
      {
        "<leader>gf",
        function()
          vim.cmd.Git("fetch")
        end,
        desc = "Fetch",
      },
      {
        "<leader>gcc",
        function()
          require("telescope.builtin").git_commits()
        end,
        desc = "Checkout at commit",
      },
      {
        "<leader>gcr",
        function()
          local cursorPosition = vim.api.nvim_win_get_cursor(0)
          cursorPosition[2] = 0
          vim.api.nvim_win_set_cursor(0, cursorPosition)
          local hash = vim.fn.expand("<cword>")
          vim.cmd.Git(string.format("revert %s", hash))
        end,
        desc = "Revert commit",
      },
      {
        "<leader>gll",
        function()
          vim.cmd.Git('log --oneline --format="%h %s"')
        end,
        desc = "Log",
      },
      {
        "<leader>gld",
        function()
          vim.cmd.Git("log")
        end,
        desc = "Log - default",
      },
      {
        "<leader>gls",
        function()
          local query = vim.fn.input("Git grep search: ")
          vim.cmd.Ggrep(query)
        end,
        desc = "Search",
      },
      {
        "<leader>gbn",
        function()
          local branch_name = vim.fn.input("New branch name: ")
          if string.len(branch_name) == 0 then
            vim.cmd.echo({ args = { "Invalid branch name" } })
            return
          end
          vim.cmd.Git({ args = { "checkout -b " .. branch_name } })
        end,
        desc = "New branch",
      },
      {
        "<leader>gbc",
        function()
          require("telescope.builtin").git_branches()
          vim.cmd.Git()
        end,
        desc = "Checkout",
      },
      {
        "<leader>gaa",
        function()
          vim.cmd.Git("add .")
        end,
        desc = "Add all",
      },
      {
        "<leader>gB",
        function()
          vim.cmd.Git("blame")
        end,
        desc = "Blame",
      },
      {
        "<leader>gsP",
        function()
          local stash_message = vim.fn.input("Stash message: ")
          if stash_message == "" then
            stash_message = "No message"
          end
          vim.cmd.Git(string.format('stash push -m "%s"', stash_message))
        end,
        desc = "Stash push",
      },
      {
        "<leader>gsp",
        function()
          require("telescope.builtin").git_stash()
          vim.cmd.Git()
        end,
        desc = "Stash pop",
      },
    },
  },
}
