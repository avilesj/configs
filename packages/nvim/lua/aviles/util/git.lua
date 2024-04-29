---@class aviles.util.git
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.open(...)
  end,
})

---@return string | nil
function M.find_git_dir()
  local cwd = vim.loop.cwd()
  local git_dir = cwd .. "/.git"

  while not vim.loop.fs_stat(git_dir) do
    local parent_dir = vim.fn.fnamemodify(cwd, ":h")
    if parent_dir == cwd then
      return nil
    end
    cwd = parent_dir
    git_dir = cwd .. "/.git"
  end

  return git_dir
end

return M
