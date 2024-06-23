return {
{"junegunn/fzf", lazy=false},
{"junegunn/fzf.vim",
  lazy=false,
  config = function()
    local wk = require('which-key')
    wk.register({
      ["<tab>"] = {"<cmd>FZF<cr>", "Fuzzy File Search"},
      ["<C-R>"] = {"<cmd>Rg<cr>", "Fuzzy Text Search"},
    }, {
      mode = "n",
      noremap = true,
      silent = true,
    })
  end,
  },
}
