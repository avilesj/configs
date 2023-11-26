return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "attach",
            name = "Auto attach to NodeJS process",
            processId = function()
              require("dap.utils").pick_process({
                filter = "--inspect",
              })
            end,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to NodeJS process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
