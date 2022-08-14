local api = vim.api
local opts = { noremap = true, silent = true }
local mapkey = api.nvim_set_keymap
local unmapkey = api.nvim_del_keymap

-- Modes
--  normal-mode       "n"
--  insert-mode       "i"
--  visual-mode       "v"
--  visual_block_mode "x"
--  term-mode         "t"
--  command-mode      "c"

-- Normal Mode --
  -- misc mappings
mapkey("n", "<C-n>", ":call ToggleNumbers()<CR>", opts)

  -- tab mappings
mapkey("n", "<leader>tj",   ":tabfirst<CR>", opts)
mapkey("n", "<leader>th",   ":tabprev<CR>", opts)
mapkey("n", "<leader>tl",   ":tabnext<CR>", opts)
mapkey("n", "<leader>tk",   ":tablast<CR>", opts)
mapkey("n", "<leader>tc",   ":tabnew<CR>", opts)
mapkey("n", "<leader>tml", ":tabmove +<CR>", opts)
mapkey("n", "<leader>tmh", ":tabmove -<CR>", opts)
mapkey("n", "<C-d>",       ":tabclose<CR>", opts)

  -- Window mappings
mapkey("n", "<C-Up>", ":resize -2<CR>", opts)
mapkey("n", "<C-Down>", ":resize +2<CR>", opts)
mapkey("n", "<C-Left>", ":vertical resize -2<CR>", opts)
mapkey("n", "<C-Right>", ":vertical resize +2<CR>", opts)

  -- Spelling
mapkey("n", "<C-s>", ":setlocal spell! spelllang=en<CR>", opts)


-- Insert Mode --
mapkey("i", "jk", "<ESC>", opts)
mapkey("i", "<C-n>", "<Plug>(asyncomplete_force_refresh)", opts)

-- Visual mode --
mapkey("v", "<", "<gv", opts)
mapkey("v", ">", ">gv", opts)

-- Visual Block mode --
mapkey("x", "J", ":move '>+1<CR>gv-gv", opts)
mapkey("x", "K", ":move '<-2<CR>gv-gv", opts)
