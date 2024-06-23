local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- FileTypes

augroup("SetFileTypes", { clear = true })
autocmd({'Bufread', 'Bufnewfile'}, {
  group = 'SetFileTypes',
  pattern = {'*.h', '*.cpp', '*.CC', '*.c++', '*.def'},
  command = 'setlocal ft=cpp',
})

autocmd({'Bufread', 'Bufnewfile'}, {
  group = 'SetFileTypes',
  pattern = '*.ll',
  command = 'setlocal ft=llvm tw=0',
})

autocmd({'Bufread', 'Bufnewfile'}, {
  group = 'SetFileTypes',
  pattern = '*.td',
  command = 'setlocal ft=tablegen',
})

autocmd({'Bufread', 'Bufnewfile'}, {
  group = 'SetFileTypes',
  pattern = {'*.mm'},
  command = 'setlocal ft=objcpp',
})

autocmd({'Bufread', 'Bufnewfile'}, {
  group = 'SetFileTypes',
  pattern = '*.sil',
  command = 'setlocal ft=sil',
})

autocmd({'Bufread', 'Bufnewfile'}, {
  group = 'SetFileTypes',
  pattern = '*.modulemap',
  command = 'setlocal ft=modulemap',
})

autocmd({'FileType'}, {
  group = 'SetFileTypes',
  pattern = "cmake",
  command = "setlocal commentstring=#\\ %s"
})

autocmd({'Bufread', 'Bufnewfile'}, {
  group = 'SetFileTypes',
  pattern = {'*.swiftinterface'},
  command = 'setlocal ft=swift tw=0',
})

autocmd({'Bufread', 'Bufnewfile'}, {
  group = 'SetFileTypes',
  pattern = { 'lit.cfg', 'lit.site.cfg' },
  command = 'setlocal ft=python',
})

autocmd({'Bufread', 'Bufnewfile'}, {
  group = 'SetFileTypes',
  pattern = {'consoleText', '*.log'},
  command = 'setlocal ft=BuildLog tw=0',
})

autocmd({'Bufread', 'Bufnewfile'}, {
  group = 'SetFileTypes',
  pattern = '*.snippets',
  command = 'setlocal ft=snippets',
})

-- Resize Window

augroup('ResizeWindow', { clear = true })
autocmd('VimResized', {
    group = 'ResizeWindow',
    command = 'wincmd =',
})

-- Buffer Behaviours

augroup('BufferBehaviour', { clear = true })
autocmd({'BufWritePost'}, {
  group = 'BufferBehaviour',
  pattern = '*.snippets',
  command = ":call UltiSnips#RefreshSnippets()",
})
