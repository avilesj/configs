-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
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
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- Lazy
map("n", "<leader>la", "<cmd>Lazy<cr>", { desc = "Lazy" })
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
