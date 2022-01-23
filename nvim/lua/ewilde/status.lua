-- Setup for my status line

local fn = vim.fn
local api = vim.api

local M = {}

M.trunc_width = setmetatable({
  mode        = 80,
  git_status  = 90,
  filename    = 140,
  line_col    = 60,
}, {
  __index = function()
    return 80
  end
})

function M.is_truncated(_, width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

-- Mode

M.modes = setmetatable({
  ['n']  = {'Normal', 'N'};
  ['no'] = {'N·Pending', 'N·P'} ;
  ['v']  = {'Visual', 'V' };
  ['V']  = {'V·Line', 'V·L' };
  [''] = {'V·Block', 'V·B'}; -- ^V
  ['s']  = {'Select', 'S'};
  ['S']  = {'S·Line', 'S·L'};
  [''] = {'S·Block', 'S·B'}; -- ^S
  ['i']  = {'Insert', 'I'};
  ['ic'] = {'Insert', 'I'};
  ['R']  = {'Replace', 'R'};
  ['Rv'] = {'V·Replace', 'V·R'};
  ['c']  = {'Command', 'C'};
  ['cv'] = {'Vim·Ex ', 'V·E'};
  ['ce'] = {'Ex ', 'E'};
  ['r']  = {'Prompt ', 'P'};
  ['rm'] = {'More ', 'M'};
  ['r?'] = {'Confirm ', 'C'};
  ['!']  = {'Shell ', 'S'};
  ['t']  = {'Terminal ', 'T'};
}, {
  __index = function()
      return {'Unknown', 'U'}
  end
})

function M.get_current_mode(self)
  local current_mode = api.nvim_get_mode().mode
  if self:is_truncated(self.trunc_width.mode) then
    return string.format(' %s ', self.modes[current_mode][2]):upper()
  end
  return string.format(' %s ', self.modes[current_mode][1]):upper()
end

-- Git stuff

M.get_git_status = function(self)
  local signs = vim.b.gitstats
  local isTruncated = self:is_truncated(self.trunc_width.git_status)

  local head = fn['FugitiveHead'](0) or nil
  local gitString = ""
  if not isTruncated and head ~= nil then
    gitString = "| "..gitString..string.format('%s ', head)
  end

  if not isTruncated and signs ~= nil then
    gitString = gitString .. string.format('| +%s ~%s -%s ', signs[1], signs[2], signs[3])
  end

  return gitString or ''
end

-- Filetype

M.get_filetype = function(self)
  local ft = vim.bo.filetype
  if ft == nil or ft == '' then
    ft = 'none'
  end
  return ft
end

-- Final Formatting

function M.set_active(self)
  local mode = self:get_current_mode()
  local git = self:get_git_status()
  local ft = self:get_filetype()
  local filestr = "%<%f %h%w%m%r["..ft.."] "
  return table.concat({ filestr, git, "%=", mode, "(%l,%c%V %P)" })
end


Statusline = setmetatable(M, {
  __call = function(statusline, mode)
    if mode == "active" then return statusline:set_active() end
    return "%= %<%F %h%w%m%r %= (%l,%c%V %P)"
  end
})

api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline('explorer')
  augroup END
]], false)
