return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob",
        "!{**/.git/*,**/node_modules/*,**/pkg/mod/*,**/yarn.lock,**/.local/*}",
      },
    },
    pickers = {
      find_files = {
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
    },
  },
}
