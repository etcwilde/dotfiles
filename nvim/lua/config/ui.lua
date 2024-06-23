local M = {}

M.icons = {
  git = {
    added = "+",
    modified = "~",
    removed = "-",
    untracked = " ",
    ignored = "i",
    unstaged = " ",
    staged = " ",
    conflict = "!",
  }
}

M.borders = 'rounded'

return M
