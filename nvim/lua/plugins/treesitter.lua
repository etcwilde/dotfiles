return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = { mode = "cursor" },
    enabled = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    version = false,
    cmd = { "TSUpdateSync" },
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "ninja",
        "make",
        "llvm",
        "json",
      },
      matchup = { enable = true, },
      highlight = { enable = true, },
      sync_install = false,
      auto_install = true,
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold" },
      },
    }
  }
}
