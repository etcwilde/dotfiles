local wk = require("which-key")
wk.setup()

-- Modes
--  normal-mode       "n"
--  insert-mode       "i"
--  visual-mode       "v"
--  visual_block_mode "x"
--  term-mode         "t"
--  command-mode      "c"

wk.add({
  { -- Normal mode
    mode = { "n" },
    { "<C-Down>", "<cmd>resize +2<cr>", desc = "Push Window Down", remap = false },
    { "<C-Up>", "<cmd>resize -2<cr>", desc = "Push Window Up", remap = false },
    { "<C-d>", "<cmd>tabclose<cr>", desc = "Close Tab", remap = false },
    { "<C-s>", "<cmd>setlocal spell! spelllang=en<cr>", desc = "Toggle SpellCheck", remap = false },
    { "<c-a>", "<Home>", desc = "Jump to the first character of the line", remap = false },
    { "<c-e>", "<End>", desc = "Jump to the last character of the line", remap = false },
    { "<leader>t", group = "Tab", remap = false },
    { "<leader>tc", "<cmd>tabnew<cr>", desc = "New tab", remap = false },
    { "<leader>th", "<cmd>tabprev<cr>", desc = "Previous Tab", remap = false },
    { "<leader>tj", "<cmd>tabfirst<cr>", desc = "First Tab", remap = false },
    { "<leader>tk", "<cmd>tablast<cr>", desc = "Last Tab", remap = false },
    { "<leader>tl", "<cmd>tabnext<cr>", desc = "Next Tab", remap = false },
    { "<leader>tm", group = "Tab Move", remap = false },
    { "<leader>tmh", "<cmd>tabmove -<cr>", desc = "Move Tab Backward", remap = false },
    { "<leader>tml", "<cmd>tabmove +<cr>", desc = "Move Tab Forward", remap = false },
  },
  { -- Insert mode
    mode = { "i" },
    { "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", desc = "Correct last spelling mistake", remap = false },
    { "jk", "<ESC>", desc = "Escape", remap = false },
  },
  { -- Visual mode
    mode = { "v" },
    { "<", "<gv", desc = "Outdent One Level", remap = false },
    { ">", ">gv", desc = "Indent One Level", remap = false },
  },
  { -- Visual Block Mode
    mode = { "x" },
    { "<C-j>", ":move '>+1<CR>gv-gv", desc = "Slide Text Up", remap = false },
    { "<C-k>", ":move '<-2<CR>gv-gv", desc = "Slide Text Down", remap = false },
  }
})
