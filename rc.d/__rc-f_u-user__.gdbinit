# Customized vimrc file.
#
# Maintainer:  Marek Balint <mareq@balint.eu>
# Last change: 2021 Dec 28


set history save
set history filename ~/.gdb_history

set listsize 24
set print pretty on
set print array-indexes on
set print asm-demangle on
set style sources off

#layout split
tui new-layout mq src 2 {-horizontal asm 1 regs 1} 1 status 1 cmd 1
layout mq

catch throw


# vim: ts=2 sw=2 et


