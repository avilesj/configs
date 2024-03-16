-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local wk = require("which-key")

wk.register({
  ["<leader>by"] = { name = "+yank" },
  ["<leader>l"] = { name = "+lazy/leetcode" },
  ["<leader>lc"] = { name = "+Leet" },
})

map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })

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
  vim.api.nvim_out_write("Full path copied to clipboard: " .. current_file .. "\n")
end, { desc = "Copy full path" })

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
