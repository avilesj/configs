-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader><tab>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>byp", function()
  -- Get the full path of the current file
  local current_file = vim.fn.expand("%:p")

  -- Get the relative path of the current file
  local relative_path = vim.fn.fnamemodify(current_file, ":.")

  -- Copy the relative path to the system clipboard
  vim.fn.setreg("+", relative_path)

  -- Display a message confirming the copy
  vim.api.nvim_out_write("Relative path copied to clipboard: " .. relative_path .. "\n")
end, { desc = "Copy path" })

map("n", "<leader>byP", function()
  -- Get the full path of the current file
  local current_file = vim.fn.expand("%:p")
  -- Copy the full path to the system clipboard
  vim.fn.setreg("+", current_file)
  -- Display a message confirming the copy
  vim.api.nvim_out_write("Relative path copied to clipboard: " .. current_file .. "\n")
end, { desc = "Relative path" })

map("n", "<leader>byf", function()
  -- Get the full path of the current file
  local current_file = vim.fn.expand("%:p")

  -- Get only the file name from the full path
  local file_name = vim.fn.fnamemodify(current_file, ":t")

  -- Copy the file name to the system clipboard
  vim.fn.setreg("+", file_name)

  -- Display a message confirming the copy
  vim.api.nvim_out_write("File name copied to clipboard: " .. file_name .. "\n")
end, { desc = "Copy full path" })
-- Lazy
map("n", "<leader>la", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- Git
-- map("n", "<leader>gg", function()
--   vim.cmd("Git")
--   vim.cmd("only")
-- end, { desc = "Git" })
-- map("n", "<leader>gp", vim.cmd.Git({ args = { "pull" } }), { desc = "Git pull" })
-- map("n", "<leader>gP", vim.cmd.Git({ args = { "push" } }), { desc = "Git push" })
-- map("n", "<leader>gf", vim.cmd.Git({ args = { "fetch" } }), { desc = "Git fetch" })
-- map("n", "<leader>gbn", function()
--   local branch_name = vim.fn.input("New branch name: ")
--   if string.len(branch_name) == 0 then
--     vim.cmd.echo({ args = { "Invalid branch name" } })
--     return
--   end
--   vim.cmd.Git({ args = { "checkout -b " .. branch_name } })
-- end, { desc = "New branch" })
-- Windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>wm", function()
  vim.cmd.only()
end, { desc = "Maximize Window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- UI
-- Disable word wrap
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle Word Wrap" })
