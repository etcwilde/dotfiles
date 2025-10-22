" CMake settings
" --------------------------------------

if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim


let b:undo_ftplugin = "setl inc< sua< commentstring<"

if exists('loaded_matchit')
  let b:match_words = '\<if\>:\<elseif\>\|\<else\>:\<endif\>'
        \ . ',\<foreach\>\|\<while\>:\<break\>:\<endforeach\>\|\<endwhile\>'
        \ . ',\<macro\>:\<endmacro\>'
        \ . ',\<function\>:\<endfunction\>'
        \ . ',\<block\>:\<endblock\>'
  let b:match_ignorecase = 1

  let b:undo_ftplugin .= "| unlet b:match_words"
endif

setlocal include=\s*include
setlocal suffixesadd=.cmake,-config.cmake
setlocal commentstring=#\ %s

function CMakeGetIndent()
  " I don't like the behaviour of vims' indenting, so I'm overriding the
  " function here. It's better than having to fight the indent mechanism
  " /usr/share/nvim/runtime/indent/cmake.vim forces setting
  " indentexpr and indentkeys, so I can't override that behaviour.
  " This makes it slightly more tolerable
  return 0
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
