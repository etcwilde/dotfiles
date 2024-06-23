return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    registers = true,
    marks = true,
  }
}
