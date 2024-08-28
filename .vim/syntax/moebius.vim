" Vim syntax file
" Language: Klister
" Last Change: 2023-12-17
" Maintainer: Samuel Gélineau <gelisam@gmail.com>

" based on the racket syntax file

" Initializing:
if exists("b:current_syntax")
  finish
endif

" Highlight unmatched parens
syntax match racketError ,[]})],

if version < 800
  set iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
else
  " syntax iskeyword 33,35-39,42-58,60-90,94,95,97-122,126,_
  " converted from decimal to char
  " :s/\d\+/\=submatch(0)->str2nr()->nr2char()/g
  " but corrected to remove duplicate _, move ^ to end
  syntax iskeyword @,!,#-',*-:,<-Z,a-z,~,_,^
  " expanded
  " syntax iskeyword !,#,$,%,&,',*,+,,,-,.,/,0-9,:,<,=,>,?,@,A-Z,_,a-z,~,^
endif

syntax keyword racketSyntax if then else let box with in
syntax match racketSyntax ":"
syntax match racketSyntax "→"
syntax match racketSyntax "⌈"
syntax match racketSyntax "⊢"
syntax match racketSyntax "⌉"


syntax match racketDelimiter !\<\.\>!

syntax cluster racketTop contains=racketSyntax,racketFunc,racketDelimiter

syntax match racketConstant  ,\<\*\k\+\*\>,
syntax match racketConstant  ,\<<\k\+>\>,

" Non-quoted lists, and strings
syntax region racketStruc matchgroup=racketParen start="("rs=s+1 end=")"re=e-1 contains=@racketTop
syntax region racketStruc matchgroup=racketParen start="#("rs=s+2 end=")"re=e-1 contains=@racketTop
syntax region racketStruc matchgroup=racketParen start="{"rs=s+1 end="}"re=e-1 contains=@racketTop
syntax region racketStruc matchgroup=racketParen start="#{"rs=s+2 end="}"re=e-1 contains=@racketTop
syntax region racketStruc matchgroup=racketParen start="\["rs=s+1 end="\]"re=e-1 contains=@racketTop
syntax region racketStruc matchgroup=racketParen start="#\["rs=s+2 end="\]"re=e-1 contains=@racketTop

for lit in ['hash', 'hasheq', 'hasheqv']
  execute printf('syntax match racketLit "\<%s\>" nextgroup=@racketParen containedin=ALLBUT,.*String,.*Comment', '#'.lit)
endfor

for lit in ['rx', 'rx#', 'px', 'px#']
  execute printf('syntax match racketRe "\<%s\>" nextgroup=@racketString containedin=ALLBUT,.*String,.*Comment,', '#'.lit)
endfor

unlet lit

" Simple literals

" Strings

syntax match racketStringEscapeError "\\." contained display

syntax match racketStringEscape "\\[abtnvfre'"\\]"        contained display
syntax match racketStringEscape "\\$"                     contained display
syntax match racketStringEscape "\\\o\{1,3}\|\\x\x\{1,2}" contained display

syntax match racketUStringEscape "\\u\x\{1,4}\|\\U\x\{1,8}" contained display
syntax match racketUStringEscape "\\u\x\{4}\\u\x\{4}"       contained display

syntax region racketString start=/\%(\\\)\@<!"/ skip=/\\[\\"]/ end=/"/ contains=racketStringEscapeError,racketStringEscape,racketUStringEscape
syntax region racketString start=/#"/           skip=/\\[\\"]/ end=/"/ contains=racketStringEscapeError,racketStringEscape

if exists("racket_no_string_fold")
  syn region racketString start=/#<<\z(.*\)$/ end=/^\z1$/
else
  syn region racketString start=/#<<\z(.*\)$/ end=/^\z1$/ fold
endif


syntax cluster racketTop  add=racketError,racketConstant,racketStruc,racketString

" Numbers

" anything which doesn't match the below rules, but starts with a #d, #b, #o,
" #x, #i, or #e, is an error
syntax match racketNumberError         "\<#[xdobie]\k*"

syntax match racketContainedNumberError   "\<#o\k*[^-+0-7delfinas#./@]\>"
syntax match racketContainedNumberError   "\<#b\k*[^-+01delfinas#./@]\>"
syntax match racketContainedNumberError   "\<#[ei]#[ei]"
syntax match racketContainedNumberError   "\<#[xdob]#[xdob]"

" start with the simpler sorts
syntax match racketNumber    "\<\(#[dobie]\)\{0,2}[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?\>" contains=racketContainedNumberError
syntax match racketNumber    "\<\(#[dobie]\)\{0,2}[-+]\?\d\+/\d\+\>" contains=racketContainedNumberError
syntax match racketNumber    "\<\(#[dobie]\)\{0,2}[-+]\?\d\+/\d\+[-+]\d\+\(/\d\+\)\?i\>" contains=racketContainedNumberError

" different possible ways of expressing complex values
syntax match racketNumber    "\<\(#[dobie]\)\{0,2}[-+]\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?i\>" contains=racketContainedNumberError
syntax match racketNumber    "\<\(#[dobie]\)\{0,2}[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?[-+]\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?i\>" contains=racketContainedNumberError
syntax match racketNumber    "\<\(#[dobie]\)\{0,2}[-+]\(inf\|nan\)\.[0f][-+]\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?i\>" contains=racketContainedNumberError
syntax match racketNumber    "\<\(#[dobie]\)\{0,2}[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?[-+]\(inf\|nan\)\.[0f]i\>" contains=racketContainedNumberError
syntax match racketNumber    "\<\(#[dobie]\)\{0,2}[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?@[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?\>" contains=racketContainedNumberError
syntax match racketNumber    "\<\(#[dobie]\)\{0,2}[-+]\(inf\|nan\)\.[0f]@[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?\>" contains=racketContainedNumberError
syntax match racketNumber    "\<\(#[dobie]\)\{0,2}[-+]\?\(\d\+\|\d\+#*\.\|\d*\.\d\+\)#*\(/\d\+#*\)\?\([sdlef][-+]\?\d\+#*\)\?@[-+]\(inf\|nan\)\.[0f]\>" contains=racketContainedNumberError

" hex versions of the above (separate because of the different possible exponent markers)
syntax match racketNumber    "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?\>"
syntax match racketNumber    "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\x\+/\x\+\>"
syntax match racketNumber    "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\x\+/\x\+[-+]\x\+\(/\x\+\)\?i\>"

syntax match racketNumber    "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?i\>"
syntax match racketNumber    "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?[-+]\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?i\>"
syntax match racketNumber    "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\(inf\|nan\)\.[0f][-+]\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?i\>"
syntax match racketNumber    "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?[-+]\(inf\|nan\)\.[0f]i\>"
syntax match racketNumber    "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?@[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?\>"
syntax match racketNumber    "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\(inf\|nan\)\.[0f]@[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?\>"
syntax match racketNumber    "\<\(#x\|#[ei]#x\|#x#[ei]\)[-+]\?\(\x\+\|\x\+#*\.\|\x*\.\x\+\)#*\(/\x\+#*\)\?\([sl][-+]\?\x\+#*\)\?@[-+]\(inf\|nan\)\.[0f]\>"

" these work for any radix
syntax match racketNumber    "\<\(#[xdobie]\)\{0,2}[-+]\(inf\|nan\)\.[0f]i\?\>" contains=racketContainedNumberError
syntax match racketNumber    "\<\(#[xdobie]\)\{0,2}[-+]\(inf\|nan\)\.[0f][-+]\(inf\|nan\)\.[0f]i\>" contains=racketContainedNumberError
syntax match racketNumber    "\<\(#[xdobie]\)\{0,2}[-+]\(inf\|nan\)\.[0f]@[-+]\(inf\|nan\)\.[0f]\>" contains=racketContainedNumberError

syntax keyword racketBoolean  #t #f #true #false #T #F

syntax match racketError   "\<#\\\k*\>"

syntax match racketChar    "\<#\\.\w\@!"
syntax match racketChar    "\<#\\space\>"
syntax match racketChar    "\<#\\newline\>"
syntax match racketChar    "\<#\\return\>"
syntax match racketChar    "\<#\\null\?\>"
syntax match racketChar    "\<#\\backspace\>"
syntax match racketChar    "\<#\\tab\>"
syntax match racketChar    "\<#\\linefeed\>"
syntax match racketChar    "\<#\\vtab\>"
syntax match racketChar    "\<#\\page\>"
syntax match racketChar    "\<#\\rubout\>"
syntax match racketChar    "\<#\\\o\{1,3}\>"
syntax match racketChar    "\<#\\x\x\{1,2}\>"
syntax match racketChar    "\<#\\u\x\{1,6}\>"

syntax cluster racketTop  add=racketNumber,racketBoolean,racketChar

" Command-line parsing
syntax keyword racketExtFunc command-line current-command-line-arguments once-any help-labels multi once-each

syntax match racketSyntax    "#lang "
syntax match racketExtSyntax "#:\k\+"

syntax cluster racketTop  add=racketExtFunc,racketExtSyntax

" syntax quoting, unquoting and quasiquotation
syntax match racketQuote "#\?['`]"

syntax match racketUnquote "#,"
syntax match racketUnquote "#,@"
syntax match racketUnquote ","
syntax match racketUnquote ",@"

" Comments
syntax match racketSharpBang "\%^#![ /].*" display
syntax match racketComment /--.*$/ contains=racketTodo,racketNote,@Spell
syntax region racketMultilineComment start=/#|/ end=/|#/ contains=racketMultilineComment,racketTodo,racketNote,@Spell
syntax match racketFormComment "#;" nextgroup=@racketTop

syntax match racketTodo /\C\<\(FIXME\|TODO\|XXX\)\ze:\?\>/ contained
syntax match racketNote /\CNOTE\ze:\?/ contained

syntax cluster racketTop  add=racketQuote,racketUnquote,racketComment,racketMultilineComment,racketFormComment

" Synchronization and the wrapping up...
syntax sync match matchPlace grouphere NONE "^[^ \t]"
" ... i.e. synchronize on a line that starts at the left margin

" Define the default highlighting.
highlight default link racketSyntax Statement
highlight default link racketFunc Function

highlight default link racketString String
highlight default link racketStringEscape Special
highlight default link racketUStringEscape Special
highlight default link racketStringEscapeError Error
highlight default link racketChar Character
highlight default link racketBoolean Boolean

highlight default link racketNumber Number
highlight default link racketNumberError Error
highlight default link racketContainedNumberError Error

highlight default link racketQuote SpecialChar
highlight default link racketUnquote SpecialChar

highlight default link racketDelimiter Delimiter
highlight default link racketParen Delimiter
highlight default link racketConstant Constant

highlight default link racketLit Type
highlight default link racketRe Type

highlight default link racketComment Comment
highlight default link racketMultilineComment Comment
highlight default link racketFormComment SpecialChar
highlight default link racketSharpBang Comment
highlight default link racketTodo Todo
highlight default link racketNote SpecialComment
highlight default link racketError Error

highlight default link racketExtSyntax Type
highlight default link racketExtFunc PreProc

let b:current_syntax = "racket"
