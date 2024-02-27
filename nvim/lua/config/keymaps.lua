local wk = require("which-key")
wk.setup()

-- Modes
--  normal-mode       "n"
--  insert-mode       "i"
--  visual-mode       "v"
--  visual_block_mode "x"
--  term-mode         "t"
--  command-mode      "c"

-- Normal Mode

wk.register({
  ["<C-d>"] = {"<cmd>tabclose<cr>", "Close Tab"},
  ["<leader>"] = {
    t = {
      name = "Tab",
      j = {"<cmd>tabfirst<cr>", "First Tab"},
      h = {"<cmd>tabprev<cr>", "Previous Tab"},
      l = { "<cmd>tabnext<cr>", "Next Tab"},
      k = { "<cmd>tablast<cr>", "Last Tab"},
      c = { "<cmd>tabnew<cr>", "New tab"},
      m = {
        name = "Tab Move",
        l = { "<cmd>tabmove +<cr>", "Move Tab Forward"},
        h = { "<cmd>tabmove -<cr>", "Move Tab Backward"},
      }
    },
    ["buf"] = { "<cmd>Buffers<cr>", "Buffer Search"},
  },
  ["<C-Up>"] = {"<cmd>resize -2<cr>", "Push Window Up"},
  ["<C-Down>"] = {"<cmd>resize +2<cr>", "Push Window Down"},
  ["<C-s>"] = {"<cmd>setlocal spell! spelllang=en<cr>", "Toggle SpellCheck"},

  ["<tab>"] = {"<cmd>FZF<cr>", "Fuzzy File Search"},
  ["<C-R>"] = {"<cmd>Rg<cr>", "Fuzzy Text Search"},
  ["<c-a>"] = {"<Home>", "Jump to the first character of the line"},
  ["<c-e>"] = {"<End>", "Jump to the last character of the line"},
}, {
  mode = "n",
  noremap = true,
  silent = true,
})

-- Insert mode
wk.register({
  ["jk"] = { "<ESC>", "Escape" },
  ["<C-l>"] = { "<c-g>u<Esc>[s1z=`]a<c-g>u", "Correct last spelling mistake" },
}, {
  mode = "i",
  noremap = true,
  silent = true
})

-- Visual mode
wk.register({
  [">"] = { ">gv", "Indent One Level" },
  ["<"] = { "<gv", "Outdent One Level" },
}, {
  mode = "v",
  noremap = true,
  silent = true,
})

-- Visual Block Mode
wk.register({
  ["<C-j>"] = {":move '>+1<CR>gv-gv", "Slide Text Up"},
  ["<C-k>"] = {":move '<-2<CR>gv-gv", "Slide Text Down"},
}, {
  mode = "x",
  noremap = true,
  silent = true,
})
