local function has_truecolor()
  if vim.o.termguicolors then
    return true
  end
  local colorterm = os.getenv("COLORTERM")
  if colorterm and (colorterm == "truecolor" or colorterm == "24bit") then
    return true
  end
  return false
end

if has_truecolor() then
  return {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = { style = "storm" },
      config = function(_, opts)
        local theme = require("tokyonight")
        theme.setup(opts)
        theme.load()
      end
  }
else
  vim.cmd.background = "dark"
  vim.cmd.colorscheme("tokyo256")
  return { }
end
