-- Status line setup

local fn = vim.fn
local api = vim.api

local M = {}

M.trunc_width = setmetatable({
  mode       = 80,
  git_status = 90,
  filename   = 140,
  line_col   = 60
}, {
  __index = function()
    return 80
  end
})

M.is_truncated = function(_, width)
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

M.get_current_mode = function(self)
  local current_mode = api.nvim_get_mode().mode
  if self:is_truncated(self.trunc_width.mode) then
    return string.format(' %s ', self.modes[current_mode][2]):upper()
  end
  return string.format(' %s ', self.modes[current_mode][1]):upper()
end

-- FileType

M.get_filetype = function(self)
  local ft = vim.bo.filetype
  if ft == nil or ft == '' then
    ft = 'none'
  end
  return ft
end

-- Git status line

M.get_gitstatus = function(self)
  require('gitsigns')
  local signs = vim.b.gitsigns_status
  if signs == nil then
    return 'none'
  end
  return string.format('%s', signs)
end

-- Formatting

M.set_active = function(self)
  local mode = self:get_current_mode()
  local ft = self:get_filetype()
  local git = self:get_gitstatus()
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
