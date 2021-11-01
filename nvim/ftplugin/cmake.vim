" CMake settings
" --------------------------------------
function CMakeGetIndent()
  " I don't like the behaviour of vims' indenting, so I'm overriding the
  " function here. It's better than having to fight the indent mechanism
  " /usr/share/nvim/runtime/indent/cmake.vim forces setting
  " indentexpr and indentkeys, so I can't override that behaviour.
  " This makes it slightly more tolerable
  return 0
endfunction
