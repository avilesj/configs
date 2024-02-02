return {
  {
    "jparise/vim-graphql",
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "graphql-language-service-cli",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "graphql",
      },
    },
  },
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {},
    opts = {
      -- make sure mason installs the server
      servers = {
        graphql = {
          filetypes = { "graphql", "typescript", "typescriptreact" },
        },
      },
    },
  },
}
