return {

  -- add typescript to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        denols = {
          ---@type lspconfig.options.denols
          setup = {
            settings = {
              root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
              deno = {
                enable = true,
                suggest = {
                  autoImports = true,
                  names = true,
                  paths = true,
                  completeFunctionCalls = true,
                  imports = {
                    autoDiscover = true,
                    hosts = {
                      ["https://crux.land"] = true,
                      ["https://deno.land"] = true,
                      ["https://x.nest.land"] = true,
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
