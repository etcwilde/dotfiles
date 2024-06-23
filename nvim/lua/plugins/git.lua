return {
  { "tpope/vim-fugitive", lazy = false },
  { "lewis6991/gitsigns.nvim",
    event="BufWrite",
    opts = {
      signs = {
        add     = { text = require('config.ui').icons.git.added },
        delete  = { text = require('config.ui').icons.git.removed },
        change  = { text = require('config.ui').icons.git.modified },
        changedelete = { text = require('config.ui').icons.git.modified },
        topdelete    = { text = '‾' },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = true,
      current_line_blame_opts = {
        cirt_text = true,
        virt_text_pos = 'right_align',
        delay = 500,
        ignore_whitespace = false,
        virt_text_priority = 100
      }
    }
  },
}
