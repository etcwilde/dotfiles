return {
{"junegunn/fzf", lazy=false},
{"junegunn/fzf.vim",
  lazy=false,
  config = function()
    local wk = require('which-key')
    wk.add({
      { "<C-R>", "<cmd>RG<cr>", desc = "Fuzzy Text Search", remap = false },
      { "<leader>buf", "<cmd>Buffers<cr>", desc = "Buffer Search", remap = false },
      { "<tab>", "<cmd>FZF<cr>", desc = "Fuzzy File Search", remap = false, silent=true},
    })
  end,
  },
}
