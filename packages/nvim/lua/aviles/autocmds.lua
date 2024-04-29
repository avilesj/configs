local Aviles = vim.api.nvim_create_augroup("Aviles", { clear = true })
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = Aviles,
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = Aviles,
  pattern = "*.templ",
  callback = function()
    vim.fn.system("templ generate")
    vim.cmd("LspRestart")
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = Aviles,
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
