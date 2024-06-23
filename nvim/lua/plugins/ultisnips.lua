-- UltiSnip info:
-- snippet options:
-- - !: overwrite previously defined snippets
-- - b: beginning of a line
-- - i: InWord expansion (does not require whitespace before expansion)
-- - w: Word boundary
-- - r: regular expression
-- - t: Don't expand tabs

return {
  {"sirver/ultisnips",
    event="InsertEnter",
    ft="snippets",
    init = function()
      vim.g.UltiSnipsSnippetsDir = vim.env.HOME .. "/.config/nvim/ulti-snippets"
      vim.g.UltiSnipsSnippetDirectories = { vim.env.HOME .. "/.config/nvim/ulti-snippets", }
      vim.g.UltiSnipsExpandTrigger = "<tab>"
      vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
    end,
  },
}
