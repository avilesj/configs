return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      local workspace = os.getenv("HOME") .. "/notes"
      require("orgmode").setup({
        -- Custom property
        org_meetings_dir = workspace .. "/meetings",
        org_templates_dir = workspace .. "/templates",
        org_agenda_files = workspace .. "/**/*",
        org_default_notes_file = "~/notes/refile.org",
      })
    end,
    keys = {
      {
        "<leader>omn",
        function()
          local meetings_dir = require("orgmode.config")["org_meetings_dir"]
          local meeting_template_file = require("orgmode.config")["org_templates_dir"] .. "/meeting.org"
          print(meeting_template_file)
          local file = io.open(meeting_template_file, "r")

          -- Check if the file was opened successfully
          local content
          if file then
            -- Read the entire file content into a string
            -- Set the name of the buffer (filename)
            local current_time = os.date("%Y-%m-%d-%H%M%S")
            local filename = meetings_dir .. "/" .. current_time .. ".org"

            local bufnr = vim.api.nvim_create_buf(true, false)
            local lines = {}
            for line in file:lines() do
              table.insert(lines, line)
            end

            -- Close the file
            file:close()

            vim.api.nvim_buf_set_name(bufnr, filename)
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

            -- Open the buffer in a new window
            vim.bo[bufnr].filetype = "org"
            vim.api.nvim_command("edit " .. filename)
            vim.cmd.only()
          else
            print("File not found: " .. meeting_template_file)
          end

          -- Create a new buffer
        end,
        desc = "New meeting file",
      },
    },
  },
}
