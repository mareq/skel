" Vim syntax file
" Language:	C
" Maintainer:	Marek Balint <mareq@balint.eu>
" Last Change:	2011 Feb 14

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Add C operators not present in default syntax file
" C math operators
syn match         cMathOperator     display "[-+\*/%=]"
" C pointer operators - address of and dereference are context sensitive
syn match         cPointerOperator  display "->\|\."
" C logical   operators - boolean results
syn match         cLogicalOperator  display "[!<>]=\="
syn match         cLogicalOperator  display "=="
" C bit operators
syn match         cBinaryOperator   display "\(&\||\|\^\|<<\|>>\)=\="
syn match         cBinaryOperator   display "\~"
" More C logical operators - highlight in preference to binary
syn match         cLogicalOperator  display "&&\|||"
" Link additional operators with cOperator defined in default syntax file 
hi def link       cMathOperator     cOperator
hi def link       cPointerOperator  cOperator
hi def link       cLogicalOperator  cOperator
hi def link       cBinaryOperator   cOperator
hi def link       cSpecialOperator  cOperator

" Add all kinds of brackets
syn match         cAllBrackets      display "[()\[\]{}]"
" Link all kinds of brackets to Operator
hi def link       cAllBrackets      Operator

" Add identifiers - variables and functions
syn match         cIdentifier       display "\<\h\w*\>"
syn match         cFunction         display "\<\h\w*\>\s*("me=e-1
" Link identifiers with Identifier
hi def link       cIdentifier       Identifier
hi def link       cFunction         Identifier


" Source default syntax file
source $VIMRUNTIME/syntax/c.vim


" C additional operators - ternary operator, comma operator
syn match         cSpecialOperator  display "[,;?:]"

" Fix Preprocessor
" TODO: Fix multiline preprocessor code
syn match         cPreProcFix       display "#.*$"
hi def link       cPreProcFix       cPreProc

" Fix C++ style comments
syn match         cCppCommentFix    display "//.*$"
hi def link       cCppCommentFix    cComment

" Use RainbowParenthesis plugin
runtime plugin/RainbowParenthsis.vim

let b:current_syntax = "c"

" vim: sw=2

