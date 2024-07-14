" wal.vim - custom colorscheme based on pywal output

highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "wal"

" Special
let g:wal_wallpaper  = "/home/chase/Pictures/wallpapers/background.png"
let g:wal_background = "#0C101E"
let g:wal_foreground = "#d1b9b9"
let g:wal_cursor     = "#d1b9b9"

" Colors
let g:color0  = "#0C101E"
let g:color1  = "#374969"
let g:color2  = "#48425D"
let g:color3  = "#4C506D"
let g:color4  = "#605C73"
let g:color5  = "#A86674"
let g:color6  = "#BD7E7F"
let g:color7  = "#d1b9b9"
let g:color8  = "#928181"
let g:color9  = "#374969"
let g:color10 = "#48425D"
let g:color11 = "#4C506D"
let g:color12 = "#605C73"
let g:color13 = "#A86674"
let g:color14 = "#BD7E7F"
let g:color15 = "#d1b9b9"

" Set Normal highlight
highlight Normal guifg=g:wal_foreground guibg=g:wal_background

" Define other highlights based on the provided colors
highlight Cursor guifg=g:wal_background guibg=g:wal_cursor
highlight LineNr guifg=g:color8 guibg=g:wal_background
highlight Comment guifg=g:color3 guibg=g:wal_background
highlight Constant guifg=g:color5 guibg=g:wal_background
highlight Identifier guifg=g:color6 guibg=g:wal_background
highlight Statement guifg=g:color9 guibg=g:wal_background
highlight PreProc guifg=g:color10 guibg=g:wal_background
highlight Type guifg=g:color12 guibg=g:wal_background
highlight Special guifg=g:color13 guibg=g:wal_background
highlight Underlined guifg=g:color14 guibg=g:wal_background

" Add more highlight groups as needed based on your preferences

