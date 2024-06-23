-- Global Config
local opt = vim.opt

opt.exrc = true
opt.secure = true
opt.autoread = true
opt.backspace = {"start", "indent", "eol"}
opt.confirm = true
opt.cursorline = true
opt.foldmethod = "syntax"
opt.hidden = true
opt.hlsearch = true
opt.infercase = true
opt.laststatus = 2
opt.lazyredraw = true
opt.wildmenu = true
opt.wildmode = "list:longest,list:full"

opt.list = true
opt.listchars = {
  tab = "»·",
  trail = "·",
  nbsp = "·",
  extends = "◀",
  precedes = "▶"
}

opt.modeline = true
opt.mouse = "a"
opt.mousefocus = true
opt.mousehide = true
opt.sol = false
opt.relativenumber = true
opt.number = true
opt.ruler = true
opt.spell = true
opt.tw = 80
opt.ts = 2
opt.sts = 2
opt.sw = 2
opt.expandtab = true
opt.showmode = false
opt.background = "dark"
opt.encoding = "utf-8"
opt.joinspaces = false
opt.colorcolumn = "+1"
opt.cmdheight = 2

vim.o.scrolloff = 5

vim.cmd.background = "dark"
vim.cmd.colorscheme('tokyo256')
