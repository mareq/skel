" RainbowParenthesis plugin based on plugin by John Gilmore.
" Maintainer:	Marek Balint <mareq@balint.eu>
" Last Change:	2011 Feb 07

syn region r12Paren matchgroup=lvl12Paren start=/(/ end=/)/ contains=TOP,r01Paren,r02Paren,r03Paren,r04Paren,r05Paren,r06Paren,r07Paren,r08Paren,r09Paren,r10Paren,r11Paren,r12Paren,NoInParens
syn region r11Paren matchgroup=lvl11Paren start=/(/ end=/)/ contains=TOP,r01Paren,r02Paren,r03Paren,r04Paren,r05Paren,r06Paren,r07Paren,r08Paren,r09Paren,r10Paren,r11Paren,NoInParens
syn region r10Paren matchgroup=lvl10Paren start=/(/ end=/)/ contains=TOP,r01Paren,r02Paren,r03Paren,r04Paren,r05Paren,r06Paren,r07Paren,r08Paren,r09Paren,r10Paren,NoInParens
syn region r09Paren matchgroup=lvl09Paren start=/(/ end=/)/ contains=TOP,r01Paren,r02Paren,r03Paren,r04Paren,r05Paren,r06Paren,r07Paren,r08Paren,r09Paren,NoInParens
syn region r08Paren matchgroup=lvl08Paren start=/(/ end=/)/ contains=TOP,r01Paren,r02Paren,r03Paren,r04Paren,r05Paren,r06Paren,r07Paren,r08Paren,NoInParens
syn region r07Paren matchgroup=lvl07Paren start=/(/ end=/)/ contains=TOP,r01Paren,r02Paren,r03Paren,r04Paren,r05Paren,r06Paren,r07Paren,NoInParens
syn region r06Paren matchgroup=lvl06Paren start=/(/ end=/)/ contains=TOP,r01Paren,r02Paren,r03Paren,r04Paren,r05Paren,r06Paren,NoInParens
syn region r05Paren matchgroup=lvl05Paren start=/(/ end=/)/ contains=TOP,r01Paren,r02Paren,r03Paren,r04Paren,r05Paren,NoInParens
syn region r04Paren matchgroup=lvl04Paren start=/(/ end=/)/ contains=TOP,r01Paren,r02Paren,r03Paren,r04Paren,NoInParens
syn region r03Paren matchgroup=lvl03Paren start=/(/ end=/)/ contains=TOP,r01Paren,r02Paren,r03Paren,NoInParens
syn region r02Paren matchgroup=lvl02Paren start=/(/ end=/)/ contains=TOP,r01Paren,r02Paren,NoInParens
syn region r01Paren matchgroup=lvl01Paren start=/(/ end=/)/ contains=TOP,r01Paren,NoInParens

syn region r12Bracket matchgroup=lvl12Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,r02Bracket,r03Bracket,r04Bracket,r05Bracket,r06Bracket,r07Bracket,r08Bracket,r09Bracket,r10Bracket,r11Bracket,r12Bracket,NoInParens
syn region r11Bracket matchgroup=lvl11Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,r02Bracket,r03Bracket,r04Bracket,r05Bracket,r06Bracket,r07Bracket,r08Bracket,r09Bracket,r10Bracket,r11Bracket,NoInParens
syn region r10Bracket matchgroup=lvl10Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,r02Bracket,r03Bracket,r04Bracket,r05Bracket,r06Bracket,r07Bracket,r08Bracket,r09Bracket,r10Bracket,NoInParens
syn region r09Bracket matchgroup=lvl09Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,r02Bracket,r03Bracket,r04Bracket,r05Bracket,r06Bracket,r07Bracket,r08Bracket,r09Bracket,NoInParens
syn region r08Bracket matchgroup=lvl08Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,r02Bracket,r03Bracket,r04Bracket,r05Bracket,r06Bracket,r07Bracket,r08Bracket,NoInParens
syn region r07Bracket matchgroup=lvl07Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,r02Bracket,r03Bracket,r04Bracket,r05Bracket,r06Bracket,r07Bracket,NoInParens
syn region r06Bracket matchgroup=lvl06Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,r02Bracket,r03Bracket,r04Bracket,r05Bracket,r06Bracket,NoInParens
syn region r05Bracket matchgroup=lvl05Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,r02Bracket,r03Bracket,r04Bracket,r05Bracket,NoInParens
syn region r04Bracket matchgroup=lvl04Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,r02Bracket,r03Bracket,r04Bracket,NoInParens
syn region r03Bracket matchgroup=lvl03Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,r02Bracket,r03Bracket,NoInParens
syn region r02Bracket matchgroup=lvl02Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,r02Bracket,NoInParens
syn region r01Bracket matchgroup=lvl01Paren start=/\[/ end=/]/ contains=TOP,r01Bracket,NoInParens

syn region r12Brace matchgroup=lvl12Paren start=/{/ end=/}/ contains=TOP,r01Brace,r02Brace,r03Brace,r04Brace,r05Brace,r06Brace,r07Brace,r08Brace,r09Brace,r10Brace,r11Brace,r12Brace,NoInParens
syn region r11Brace matchgroup=lvl11Paren start=/{/ end=/}/ contains=TOP,r01Brace,r02Brace,r03Brace,r04Brace,r05Brace,r06Brace,r07Brace,r08Brace,r09Brace,r10Brace,r11Brace,NoInParens
syn region r10Brace matchgroup=lvl10Paren start=/{/ end=/}/ contains=TOP,r01Brace,r02Brace,r03Brace,r04Brace,r05Brace,r06Brace,r07Brace,r08Brace,r09Brace,r10Brace,NoInParens
syn region r09Brace matchgroup=lvl09Paren start=/{/ end=/}/ contains=TOP,r01Brace,r02Brace,r03Brace,r04Brace,r05Brace,r06Brace,r07Brace,r08Brace,r09Brace,NoInParens
syn region r08Brace matchgroup=lvl08Paren start=/{/ end=/}/ contains=TOP,r01Brace,r02Brace,r03Brace,r04Brace,r05Brace,r06Brace,r07Brace,r08Brace,NoInParens
syn region r07Brace matchgroup=lvl07Paren start=/{/ end=/}/ contains=TOP,r01Brace,r02Brace,r03Brace,r04Brace,r05Brace,r06Brace,r07Brace,NoInParens
syn region r06Brace matchgroup=lvl06Paren start=/{/ end=/}/ contains=TOP,r01Brace,r02Brace,r03Brace,r04Brace,r05Brace,r06Brace,NoInParens
syn region r05Brace matchgroup=lvl05Paren start=/{/ end=/}/ contains=TOP,r01Brace,r02Brace,r03Brace,r04Brace,r05Brace,NoInParens
syn region r04Brace matchgroup=lvl04Paren start=/{/ end=/}/ contains=TOP,r01Brace,r02Brace,r03Brace,r04Brace,NoInParens
syn region r03Brace matchgroup=lvl03Paren start=/{/ end=/}/ contains=TOP,r01Brace,r02Brace,r03Brace,NoInParens
syn region r02Brace matchgroup=lvl02Paren start=/{/ end=/}/ contains=TOP,r01Brace,r02Brace,NoInParens
syn region r01Brace matchgroup=lvl01Paren start=/{/ end=/}/ contains=TOP,r01Brace,NoInParens
