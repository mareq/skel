" Vim color file
"
" Maintainer: Marek Balint <mareq@balint.eu>
" Last change: 2021 Apr 12

"if !has("gui_running") && &t_Co < 256
"  finish
"endif

" Define individual colors
" TODO: See the Neon theme for Airline
let s:Black =
  \{
    \ 'base_dark':  { 'cterm': 'black',        'gui': '#000000' },
    \ 'base_light': { 'cterm': 'darkgray',     'gui': '#000000' },
    \ 'dark':       { 'cterm': 232,            'gui': '#000000' },
    \ 'medium':     { 'cterm': 236,            'gui': '#000000' },
    \ 'light':      { 'cterm': 240,            'gui': '#000000' },
  \}
let s:Blue =
  \{
    \ 'base_dark':  { 'cterm': 'darkblue',     'gui': '#000000' },
    \ 'base_light': { 'cterm': 'blue',         'gui': '#000000' },
    \ 'dark':       { 'cterm':  63,            'gui': '#000000' },
    \ 'medium':     { 'cterm':  69,            'gui': '#000000' },
    \ 'light':      { 'cterm':  75,            'gui': '#000000' },
  \}
let s:Red =
  \{
    \ 'base_dark':  { 'cterm': 'darkred',      'gui': '#000000' },
    \ 'base_light': { 'cterm': 'red',          'gui': '#000000' },
    \ 'dark':       { 'cterm': 124,            'gui': '#000000' },
    \ 'medium':     { 'cterm': 160,            'gui': '#000000' },
    \ 'light':      { 'cterm': 196,            'gui': '#000000' },
  \}
let s:Green =
  \{
    \ 'base_dark':  { 'cterm': 'darkgreen',    'gui': '#000000' },
    \ 'base_light': { 'cterm': 'green',        'gui': '#000000' },
    \ 'dark':       { 'cterm':  34,            'gui': '#000000' },
    \ 'medium':     { 'cterm':  40,            'gui': '#000000' },
    \ 'light':      { 'cterm':  46,            'gui': '#000000' },
  \}
let s:Lime =
  \{
    \ 'base_dark':  { 'cterm': '!darklime!',   'gui': '#000000' },
    \ 'base_light': { 'cterm': '!lime!',       'gui': '#000000' },
    \ 'dark':       { 'cterm': 118,            'gui': '#000000' },
    \ 'medium':     { 'cterm': 154,            'gui': '#000000' },
    \ 'light':      { 'cterm': 190,            'gui': '#000000' },
  \}
let s:Yellow =
  \{
    \ 'base_dark':  { 'cterm': 'brown',        'gui': '#000000' },
    \ 'base_light': { 'cterm': 'yellow',       'gui': '#000000' },
    \ 'dark':       { 'cterm': 214,            'gui': '#000000' },
    \ 'medium':     { 'cterm': 220,            'gui': '#000000' },
    \ 'light':      { 'cterm': 226,            'gui': '#000000' },
  \}
let s:Magenta =
  \{
    \ 'base_dark':  { 'cterm': 'darkmagenta',  'gui': '#000000' },
    \ 'base_light': { 'cterm': 'magenta',      'gui': '#000000' },
    \ 'dark':       { 'cterm': 129,            'gui': '#000000' },
    \ 'medium':     { 'cterm': 135,            'gui': '#000000' },
    \ 'light':      { 'cterm': 141,            'gui': '#000000' },
  \}
let s:Pink =
  \{
    \ 'base_dark':  { 'cterm': '!darkpink!',   'gui': '#000000' },
    \ 'base_light': { 'cterm': '!pink!',       'gui': '#000000' },
    \ 'dark':       { 'cterm': 201,            'gui': '#000000' },
    \ 'medium':     { 'cterm': 207,            'gui': '#000000' },
    \ 'light':      { 'cterm': 213,            'gui': '#000000' },
  \}
let s:Violet =
  \{
    \ 'base_dark':  { 'cterm': '!darkviolet!', 'gui': '#000000' },
    \ 'base_light': { 'cterm': '!violet!',     'gui': '#000000' },
    \ 'dark':       { 'cterm':  93,            'gui': '#000000' },
    \ 'medium':     { 'cterm':  99,            'gui': '#000000' },
    \ 'light':      { 'cterm': 105,            'gui': '#000000' },
  \}
let s:Cyan =
  \{
    \ 'base_dark':  { 'cterm': 'darkcyan',     'gui': '#000000' },
    \ 'base_light': { 'cterm': 'cyan',         'gui': '#000000' },
    \ 'dark':       { 'cterm':  39,            'gui': '#000000' },
    \ 'medium':     { 'cterm':  45,            'gui': '#000000' },
    \ 'light':      { 'cterm':  51,            'gui': '#000000' },
  \}
let s:White =
  \{
    \ 'base_dark':  { 'cterm': 'lightgray',    'gui': '#000000' },
    \ 'base_light': { 'cterm': 'white',        'gui': '#000000' },
    \ 'dark':       { 'cterm': 246,            'gui': '#000000' },
    \ 'medium':     { 'cterm': 249,            'gui': '#000000' },
    \ 'light':      { 'cterm': 254,            'gui': '#000000' },
  \}

" First remove all existing highlighting.
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

" Set colorscheme name
let colors_name = "neon"

" Normal text
hi Normal ctermbg=black ctermfg=white guibg=black guifg=white

" Auxiliary color values/placeholders for the color scheme
let s:DefaultColor = { 'null': 'This is placeholder default value to be used to express "use default color" idea.' }
let s:DarkerBlack = { 'cterm': 234, 'gui': '#000000' }

" Built-in highlight groups
let s:BuiltInHighlightGroups = [
  \{
    \ 'group': 'ColorColumn',
    \ 'descr': 'For the columns set with `colorcolumn`',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:DefaultColor, 'bg': s:Black.base_dark,
  \},
  \{
    \ 'group': 'Conceal',
    \ 'descr': 'Placeholder characters substituted for concealed text (see `conceallevel`) [TODO]',
    \ 'term': '',        'cterm': '',        'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Cursor',
    \ 'descr': 'Character under the cursor',
    \ 'term': 'reverse', 'cterm': 'reverse', 'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'CursorIM',
    \ 'descr': 'Like Cursor, but used when in IME mode |CursorIM|',
    \ 'term': 'reverse', 'cterm': 'reverse', 'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'CursorColumn',
    \ 'descr': 'Screen-column at the cursor, when `cursorcolumn` is set.',
    \ 'term': 'reverse', 'cterm': 'none',    'fg': s:DefaultColor, 'bg': s:Black.medium
  \},
  \{
    \ 'group': 'CursorLine',
    \ 'descr': 'Screen-line at the cursor, when `cursorline` is set. Low-priority if foreground (ctermfg OR guifg) is not set.',
    \ 'term': 'reverse', 'cterm': 'none',    'fg': s:DefaultColor, 'bg': s:DarkerBlack
  \},
  \{
    \ 'group': 'Directory',
    \ 'descr': 'Directory names (and other special names in listings)',
    \ 'term': '',        'cterm': '',        'fg': s:Blue.medium,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'DiffAdd',
    \ 'descr': 'Diff mode: Added line |diff.txt|',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Black.dark, 'bg': s:Green.light,
  \},
  \{
    \ 'group': 'DiffDelete',
    \ 'descr': 'Diff mode: Deleted line |diff.txt|',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Red.light,    'bg': s:Red.dark,
  \},
  \{
    \ 'group': 'DiffChange',
    \ 'descr': 'Diff mode: Changed line |diff.txt|',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Black.dark, 'bg': s:Yellow.dark,
  \},
  \{
    \ 'group': 'DiffText',
    \ 'descr': 'Diff mode: Changed text within a changed line |diff.txt|',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:White.light, 'bg': s:Red.dark,
  \},
  \{
    \ 'group': 'EndOfBuffer',
    \ 'descr': 'Filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.',
    \ 'term': '',        'cterm': '',        'fg': s:Black.light,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'TermCursor',
    \ 'descr': 'Cursor in a focused terminal',
    \ 'term': '',        'cterm': '',        'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'TermCursorNC',
    \ 'descr': 'Cursor in an unfocused terminal',
    \ 'term': '',        'cterm': '',        'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'ErrorMsg',
    \ 'descr': 'Error messages on the command line',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:White.light, 'bg': s:Red.dark,
  \},
  \{
    \ 'group': 'VertSplit',
    \ 'descr': 'The column separating vertically split windows [TODO: Change color with mode]',
    \ 'term': '',        'cterm': 'bold',    'fg': s:White.dark, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'Folded',
    \ 'descr': 'Line used for closed folds',
    \ 'term': '',        'cterm': 'bold',    'fg': s:Blue.light, 'bg': s:Black.base_dark,
  \},
  \{
    \ 'group': 'FoldColumn',
    \ 'descr': '`foldcolumn`',
    \ 'term': '',        'cterm': 'bold',    'fg': s:Blue.medium, 'bg': s:DarkerBlack,
  \},
  \{
    \ 'group': 'SignColumn',
    \ 'descr': 'Column where |signs| are displayed',
    \ 'term': '',        'cterm': 'bold',    'fg': s:Yellow.light, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'IncSearch',
    \ 'descr': '`incsearch` highlighting; also used for the text replaced with ":s///c"',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:White.light, 'bg': s:Blue.dark,
  \},
  \{
    \ 'group': 'Substitute',
    \ 'descr': '|:substitute| replacement text highlighting [TODO]',
    \ 'term': 'bold',    'cterm': '',        'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'LineNr',
    \ 'descr': 'Line number for ":number" and ":#" commands, and when `number` or `relativenumber` option is set.',
    \ 'term': '',        'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DarkerBlack,
  \},
  \{
    \ 'group': 'CursorLineNr',
    \ 'descr': 'Like LineNr when `cursorline` or `relativenumber` is set for the cursor line.',
    \ 'term': '',        'cterm': 'bold',    'fg': s:Yellow.medium, 'bg': s:DarkerBlack,
  \},
  \{
    \ 'group': 'MatchParen',
    \ 'descr': 'The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|',
    \ 'term': '',        'cterm': 'bold',    'fg': s:White.base_light, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'ModeMsg',
    \ 'descr': '`showmode` message (e.g., "-- INSERT --")',
    \ 'term': '',        'cterm': '',        'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'MsgSeparator',
    \ 'descr': 'Separator for scrolled messages, `msgsep` flag of `display`',
    \ 'term': '',        'cterm': '',        'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'MoreMsg',
    \ 'descr': '|more-prompt|',
    \ 'term': '',        'cterm': 'bold',    'fg': s:Blue.medium, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'NonText',
    \ 'descr': '`@` at the end of the window, characters from `showbreak` and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesnt fit at the end of the line). See also |hl-EndOfBuffer|.',
    \ 'term': '',        'cterm': '',        'fg': s:Black.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Normal',
    \ 'descr': 'normal text',
    \ 'term': '',        'cterm': '',        'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'NormalNC',
    \ 'descr': 'normal text in non-current windows',
    \ 'term': '',        'cterm': '',        'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Pmenu',
    \ 'descr': 'Popup menu: normal item.',
    \ 'term': '',        'cterm': '',        'fg': s:Blue.medium, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'PmenuSel',
    \ 'descr': 'Popup menu: selected item.',
    \ 'term': '',        'cterm': '',        'fg': s:Black.dark, 'bg': s:Blue.medium,
  \},
  \{
    \ 'group': 'PmenuSbar',
    \ 'descr': 'Popup menu: scrollbar.',
    \ 'term': 'bold',    'cterm': 'none',    'fg': s:White.light, 'bg': s:Black.light,
  \},
  \{
    \ 'group': 'PmenuThumb',
    \ 'descr': 'Popup menu: Thumb of the scrollbar.',
    \ 'term': 'bold',    'cterm': 'none',    'fg': s:Blue.light, 'bg': s:Blue.dark,
  \},
  \{
    \ 'group': 'Question',
    \ 'descr': '|hit-enter| prompt and yes/no questions',
    \ 'term': '',        'cterm': '',        'fg': s:Violet.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'QuickFixLine',
    \ 'descr': 'Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Black.dark, 'bg': s:Blue.medium,
  \},
  \{
    \ 'group': 'Search',
    \ 'descr': 'Last search pattern highlighting (see `hlsearch`).  Also used for similar items that need to stand out.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Black.dark, 'bg': s:Blue.dark,
  \},
  \{
    \ 'group': 'SpecialKey',
    \ 'descr': 'Unprintable characters: text displayed differently from what it really is. But not `listchars` whitespace. |hl-Whitespace|',
    \ 'term': '',        'cterm': '',        'fg': s:White.dark, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'SpellBad',
    \ 'descr': 'Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.',
    \ 'term': '',        'cterm': '',        'fg': s:Black.dark, 'bg': s:Red.light,
  \},
  \{
    \ 'group': 'SpellCap',
    \ 'descr': 'Word that should start with a capital. |spell| Combined with the highlighting used otherwise.',
    \ 'term': '',        'cterm': '',        'fg': s:Black.dark, 'bg': s:Blue.light,
  \},
  \{
    \ 'group': 'SpellLocal',
    \ 'descr': 'Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.',
    \ 'term': '',        'cterm': '',        'fg': s:Black.dark, 'bg': s:Green.medium,
  \},
  \{
    \ 'group': 'SpellRare',
    \ 'descr': 'Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.',
    \ 'term': '',        'cterm': '',        'fg': s:White.light, 'bg': s:Black.light,
  \},
  \{
    \ 'group': 'StatusLine',
    \ 'descr': 'status line of current window',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Blue.medium, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'StatusLineNC',
    \ 'descr': 'status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:White.medium, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'StatusLineTerm',
    \ 'descr': 'Status line of current window, if it is a |terminal| window.',
    \ 'term': '',        'cterm': '',        'fg': s:Yellow.medium, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'StatusLineTermNC',
    \ 'descr': 'status lines of not-current windows that is a |terminal| window.',
    \ 'term': '',        'cterm': '',        'fg': s:White.light, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'TabLine',
    \ 'descr': 'tab pages line, not active tab page label',
    \ 'term': '',        'cterm': '',        'fg': s:Black.dark, 'bg': s:White.medium,
  \},
  \{
    \ 'group': 'TabLineFill',
    \ 'descr': 'tab pages line, where there are no labels',
    \ 'term': '',        'cterm': '',        'fg': s:Black.medium, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'TabLineSel',
    \ 'descr': 'tab pages line, active tab page label',
    \ 'term': '',        'cterm': '',        'fg': s:Black.dark, 'bg': s:Blue.dark,
  \},
  \{
    \ 'group': 'Title',
    \ 'descr': 'titles for output from ":set all", ":autocmd" etc.',
    \ 'term': '',        'cterm': 'bold',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Visual',
    \ 'descr': 'Visual mode selection',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:DefaultColor, 'bg': s:Black.light,
  \},
  \{
    \ 'group': 'VisualNOS',
    \ 'descr': 'Visual mode selection when vim is "Not Owning the Selection".',
    \ 'term': '',        'cterm': '',        'fg': s:White.light, 'bg': s:Blue.dark,
  \},
  \{
    \ 'group': 'WarningMsg',
    \ 'descr': 'warning messages',
    \ 'term': '',        'cterm': '',        'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Whitespace',
    \ 'descr': '"nbsp", "space", "tab" and "trail" in `listchars`',
    \ 'term': '',        'cterm': '',        'fg': s:DefaultColor, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'WildMenu',
    \ 'descr': 'current match in `wildmenu` completion',
    \ 'term': 'bold',    'cterm': 'none',    'fg': s:Black.dark, 'bg': s:Blue.medium,
  \},
  \]

" Highlight groups for syntax highlighting
let s:SyntaxHighlightGroups = [
  \{
    \ 'group': 'Comment',
    \ 'descr': 'any comment',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Green.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Constant',
    \ 'descr': 'Any constant',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'String',
    \ 'descr': 'A string constant: "this is a string"',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Red.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Character',
    \ 'descr': 'A character constant: `c`, `\n`',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Magenta.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Number',
    \ 'descr': 'A number constant: 234, 0xff',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Boolean',
    \ 'descr': 'A number constant: 234, 0xff',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Float',
    \ 'descr': 'A floating point constant: 2.3e10',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Identifier',
    \ 'descr': 'Any variable name',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Violet.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Function',
    \ 'descr': 'Function name (also: methods for classes)',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Violet.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Statement',
    \ 'descr': 'Any statement',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Magenta.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Conditional',
    \ 'descr': 'if, then, else, endif, switch, etc.',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Repeat',
    \ 'descr': 'for, do, while, etc.',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Label',
    \ 'descr': 'case, default, etc.',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Magenta.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Operator',
    \ 'descr': '"sizeof", "+", "*", etc.',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Keyword',
    \ 'descr': 'Any other keyword',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Magenta.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Exception',
    \ 'descr': 'try, catch, throw',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Magenta.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'PreProc',
    \ 'descr': 'generic Preprocessor',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Cyan.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Include',
    \ 'descr': 'Preprocessor #include',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Cyan.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Define',
    \ 'descr': 'Preprocessor #define',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Cyan.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Macro',
    \ 'descr': 'Same as Define',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Cyan.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'PreCondit',
    \ 'descr': 'Preprocessor #if, #else, #endif, etc.',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Cyan.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Type',
    \ 'descr': 'int, long, char, etc.',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'StorageClass',
    \ 'descr': 'static, register, volatile, etc.',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Structure',
    \ 'descr': 'struct, union, enum, etc.',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Magenta.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Typedef',
    \ 'descr': 'A typedef',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Cyan.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Special',
    \ 'descr': 'Any special symbol',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'SpecialChar',
    \ 'descr': 'Special character in a constant',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Red.base_dark, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Tag',
    \ 'descr': 'You can use CTRL-] on this',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Blue.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Delimeter',
    \ 'descr': 'Character that needs attention',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Debug',
    \ 'descr': 'Debugging statements',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:White.base_light, 'bg': s:Black.base_light,
  \},
  \{
    \ 'group': 'Underlined',
    \ 'descr': 'Text that stands out, HTML links',
    \ 'term': 'bold,underline', 'cterm': 'bold,underline', 'fg': s:Blue.medium, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Ignore',
    \ 'descr': 'Debugging statements',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:White.base_dark, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'Error',
    \ 'descr': 'Debugging statements',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:White.base_light, 'bg': s:Red.base_dark,
  \},
  \{
    \ 'group': 'Todo',
    \ 'descr': 'Debugging statements',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Yellow.base_light, 'bg': s:Black.base_dark,
  \},
\]

" Highlight groups for language-specific syntax highlighting
" TODO:
" - Doxygen
"   - hi doxygenComment ctermfg=Green guifg=#00FF00  " Doxygen comment
"   - hi doxygenBriefWord ctermfg=Magenta guifg=#FF00FF
"   - hi doxygenParam ctermfg=Magenta guifg=#FF00FF
"   - hi doxygenOther ctermfg=Magenta guifg=#FF00FF
"   - hi doxygenBOther ctermfg=Magenta guifg=#FF00FF
"   - hi doxygenSpecialCodeWord ctermfg=Magenta guifg=#FF00FF
"   - hi doxygenParamName ctermfg=Yellow guifg=#FFFF00
"   - hi doxygenBriefLine ctermfg=Red guifg=#FF0000
"   - hi doxygenCodeWord ctermfg=Red guifg=#FF0000
"   - hi doxygenBriefL ctermfg=Green guifg=#00FF00
"   - hi doxygenHeaderLine ctermfg=Green guifg=#00FF00
"   - hi doxygenSpecialOnelineDesc ctermfg=Green guifg=#00FF00
"   - hi doxygenSpecialMultilineDesc ctermfg=Green guifg=#00FF00
"   - hi doxygenSpecialTypeOnelineDesc ctermfg=Green guifg=#00FF00
"   - hi doxygenHtmlCh ctermfg=Cyan guifg=#00FFFF
"   - hi doxygenHtmlCmd ctermfg=Cyan guifg=#00FFFF
"   - hi doxygenHtmlCode ctermfg=Green guifg=#00FF00
let s:LangSyntaxHighlightGroups = [
  \{
    \ 'group': 'rustCommentLineDoc',
    \ 'descr': 'Rust: Documentation comment',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Green.light, 'bg': s:DefaultColor,
  \},
\]

" Highlight groups for NerdTree plugin
let s:PluginNerdTreeHighlightGroups = [
  \{
    \ 'group': 'NERDTreeGitStatusIgnored',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Blue.medium,  'bg': s:DefaultColor,
  \},
\]

" Highlight groups for NerdTree plugin
let s:PluginBufExplorerHighlightGroups = [
  \{
    \ 'group': 'bufExplorerCurBuf',
    \ 'descr': 'current buffer',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Yellow.medium,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'bufExplorerAltBuf',
    \ 'descr': 'current buffer',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.dark,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'bufExplorerActBuf',
    \ 'descr': 'active buffer',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Violet.light,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'bufExplorerHidBuf',
    \ 'descr': 'hidden buffer',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Red.light,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'bufExplorerInactBuf',
    \ 'descr': 'inactive buffer',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Green.light,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'bufExplorerUnlBuf',
    \ 'descr': 'unlisted buffer',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:White.dark,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'bufExplorerSortBy',
    \ 'descr': 'help footer displaying current configuration',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Yellow.light,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'bufExplorerSortType',
    \ 'descr': 'sort-by keyword',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:White.dark,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'bufExplorerTitle',
    \ 'descr': 'help header',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:White.light,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'bufExplorerHelp',
    \ 'descr': 'help text',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:White.medium,  'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'bufExplorerMapping',
    \ 'descr': 'hotkey',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Violet.light,  'bg': s:DefaultColor,
  \},
\]

" Highlight groups for GitGutter plugin
let s:PluginGitGutterHighlightGroups = [
  \{
    \ 'group': 'GitGutterAdd',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Green.base_light, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'GitGutterChange',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Yellow.medium, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'GitGutterDelete',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Red.base_light, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'GitGutterChangeDelete',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Yellow.base_light, 'bg': s:Black.medium,
  \},
\]

" Highlight groups for ALE plugin
let s:PluginALEHighlightGroups = [
  \{
    \ 'group': 'ALEErrorSign',
    \ 'descr': 'The highlight for error signs.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Red.light, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'ALEError',
    \ 'descr': 'The highlight for highlighted errors.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Red.light, 'bg': s:Black.dark,
  \},
  \{
    \ 'group': 'ALEVirtualTextError',
    \ 'descr': 'The highlight for virtualtext errors.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Red.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'ALEWarningSign',
    \ 'descr': 'The highlight for style warning signs.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Yellow.medium, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'ALEWarning',
    \ 'descr': 'The highlight for highlighted info messages.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Yellow.medium, 'bg': s:Black.dark,
  \},
  \{
    \ 'group': 'ALEVirtualTextWarning',
    \ 'descr': 'The highlight for virtualtext warnings.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Yellow.medium, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'ALEInfoSign',
    \ 'descr': 'The highlight for info message signs.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Blue.light, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'ALEInfo',
    \ 'descr': 'The highlight for info message signs.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Blue.light, 'bg': s:Black.dark,
  \},
  \{
    \ 'group': 'ALEVirtualTextInfo',
    \ 'descr': 'The highlight for virtualtext info.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Blue.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'ALEStyleErrorSign',
    \ 'descr': 'The highlight for style error signs.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Red.light, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'ALEStyleError',
    \ 'descr': 'The highlight for highlighted style errors.',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Red.dark, 'bg': s:Black.dark,
  \},
  \{
    \ 'group': 'ALEVirtualTextStyleError',
    \ 'descr': 'The highlight for virtualtext style errors.',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Red.dark, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'ALEStyleWarningSign',
    \ 'descr': 'The highlight for style warning signs.',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Yellow.medium, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'ALEStyleWarning',
    \ 'descr': 'The highlight for highlighted style warnings.',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.dark, 'bg': s:Black.dark,
  \},
  \{
    \ 'group': 'ALEVirtualTextStyleWarning',
    \ 'descr': 'The highlight for virtualtext style warnings.',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.dark, 'bg': s:DefaultColor,
  \},
\]

" Highlight groups for CoC plugin
let s:PluginCoCHighlightGroups = [
  \{
    \ 'group': 'CoCErrorHighlight',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Red.light, 'bg': s:Black.dark,
  \},
  \{
    \ 'group': 'CoCErrorVirtualText',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Red.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'CoCErrorSign',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Red.light, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'CoCWarningHighlight',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Yellow.medium, 'bg': s:Black.dark,
  \},
  \{
    \ 'group': 'CoCWarningVirtualText',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Yellow.medium, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'CoCWarningSign',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Yellow.medium, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'CoCInfoHighlight',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Blue.medium, 'bg': s:Black.dark,
  \},
  \{
    \ 'group': 'CoCInfoVirtualText',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Blue.medium, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'CoCInfoSign',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Blue.medium, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'CoCHintHighlight',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Green.light, 'bg': s:Black.dark,
  \},
  \{
    \ 'group': 'CoCHintVirtualText',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Green.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'CoCHintSign',
    \ 'descr': 'XXX: This is used not only for hint sign, but also for virtual-text with type hints: need s:DefaultColor for background for those hints, but should have s:Black.medium for hint sign (breaking background color of hint sign is lesser evil as that icon is just one character and is not as abundant as type hints).',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Black.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'CoCCodeLens',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Black.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'CoCHighlightText',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:DefaultColor, 'bg': s:Black.medium,
  \},
  \{
    \ 'group': 'CoCMarkdownCode',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:White.dark, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'CoCMarkdownHeader',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Yellow.medium, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'CoCMarkdownCodeLink',
    \ 'descr': '',
    \ 'term': 'bold',    'cterm': 'bold',    'fg': s:Blue.light, 'bg': s:DefaultColor,
  \},
\]

" Highlight groups for VimWiki plugin
let s:PluginVimWikiHighlightGroups = [
  \{
    \ 'group': 'VimwikiBold',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Red.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiItalic',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Violet.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiBoldItalic',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Red.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiItalicBold',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Violet.medium, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiDelText',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Black.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiCode',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Green.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiPre',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Green.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiSuperScript',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Cyan.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiSubScript',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Cyan.base_dark, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiLink',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold,underline', 'fg': s:Blue.medium, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiNoExistsLink',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold,underline', 'fg': s:Red.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiHeaderChar',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiHeader1',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiHeader2',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiHeader3',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiHeader4',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiHeader5',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiHeader6',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'bold',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiListTodo',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiCheckBoxDone',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Green.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiTag',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Magenta.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'VimwikiComment',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:White.base_dark, 'bg': s:DefaultColor,
  \},
\]

" Highlight groups for TaskWiki plugin
let s:PluginTaskWikiHighlightGroups = [
  \{
    \ 'group': 'TaskWikiTask',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Violet.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'TaskWikiTaskRecurring',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Blue.light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'TaskWikiTaskWaiting',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Violet.dark, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'TaskWikiTaskActive',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Yellow.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'TaskWikiTaskCompleted',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Green.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'TaskWikiTaskDeleted',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:Red.base_light, 'bg': s:DefaultColor,
  \},
  \{
    \ 'group': 'TaskWikiTaskUuid',
    \ 'descr': '',
    \ 'term': 'none',    'cterm': 'none',    'fg': s:White.dark, 'bg': s:DefaultColor,
  \},
\]

" Apply color scheme
function! ApplyColorScheme(color_scheme)
  for hg in a:color_scheme
    let hicmd = 'highlight ' . hg.group
    let has_args = 0
    if has_key(hg, 'term') && (hg.term != '')
      let hicmd .= ' term=' . hg.term
      let has_args = 1
    endif
    if has_key(hg, 'cterm') && (hg.cterm != '')
      let hicmd .= ' cterm=' . hg.cterm
      let has_args = 1
    endif
    if has_key(hg, 'fg') && (hg.fg != s:DefaultColor)
      let hicmd .= ' ctermfg=' . hg.fg.cterm
      let hicmd .= ' guifg=' . hg.fg.gui
      let has_args = 1
    endif
    if has_key(hg, 'bg') && (hg.bg != s:DefaultColor)
      let hicmd .= ' ctermbg=' . hg.bg.cterm
      let hicmd .= ' guibg=' . hg.bg.gui
      let has_args = 1
    endif
    if has_args != 0
      execute hicmd
    endif
  endfor
endfunction
call ApplyColorScheme(s:BuiltInHighlightGroups)
call ApplyColorScheme(s:SyntaxHighlightGroups)
call ApplyColorScheme(s:LangSyntaxHighlightGroups)
call ApplyColorScheme(s:PluginNerdTreeHighlightGroups)
call ApplyColorScheme(s:PluginBufExplorerHighlightGroups)
call ApplyColorScheme(s:PluginGitGutterHighlightGroups)
call ApplyColorScheme(s:PluginALEHighlightGroups)
call ApplyColorScheme(s:PluginCoCHighlightGroups)
call ApplyColorScheme(s:PluginVimWikiHighlightGroups)
call ApplyColorScheme(s:PluginTaskWikiHighlightGroups)


" vim: ts=2 sw=2 et


