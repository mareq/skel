" VIMWIKI (#NA; https://github.com/vimwiki/vimwiki/tree/dev)
" TODO: https://github.com/vimwiki/vimwiki/issues/1113

" Enable temporary wikis
let g:vimwiki_global_ext = 1
" Automatically save wiki buffers when switching wiki pages
let g:vimwiki_autowriteall = 1
" Use local mouse mappings
let g:vimwiki_use_mouse = 1
"" Registered file extensions
let g:vimwiki_ext2syntax = { }
let g:vimwiki_ext2syntax[".md"] = "markdown"
let g:vimwiki_ext2syntax[".mkd"] = "markdown"
let g:vimwiki_ext2syntax[".wiki"] = "default"
" Directory handling
let g:vimwiki_dir_link = "index"
" Default settings for wiki
let s:vimwiki_defaults = { }
let s:vimwiki_defaults["index"] = "index"
let s:vimwiki_defaults["ext"] = "wiki"
let s:vimwiki_defaults["syntax"] = "default"
let s:vimwiki_defaults["exclude_files"] = []
let s:vimwiki_defaults["automatic_nested_syntaxes"] = 1
let s:vimwiki_defaults["diary_rel_path"] = "/journal"
let s:vimwiki_defaults["diary_index"] = "journal"
let s:vimwiki_defaults["diary_header"] = "Journal"
let s:vimwiki_defaults["diary_sort"] = "desc"
let s:vimwiki_defaults["maxhi"] = 1
let s:vimwiki_defaults["auto_diary_index"] = 1
let s:vimwiki_defaults["auto_export"] = 1
let s:vimwiki_defaults["auto_toc"] = 1
let s:vimwiki_defaults["auto_tags"] = 1
let s:vimwiki_defaults["auto_generate_links"] = 1
" Registered wikis
let g:vimwiki_list = [ ]
let g:vimwiki_wiki_main_base_path = $HOME."/work"
let g:vimwiki_wiki_main = deepcopy(s:vimwiki_defaults)
let g:vimwiki_wiki_main["name"] = "Work"
let g:vimwiki_wiki_main["path"] = g:vimwiki_wiki_main_base_path."/wiki"
let g:vimwiki_wiki_main["path_html"] = g:vimwiki_wiki_main_base_path."/.wiki_html"
let g:vimwiki_wiki_main["diary_rel_path"] = "journal"
let g:vimwiki_list += [ g:vimwiki_wiki_main     ]  " #0
let g:vimwiki_wiki_tutor_base_path = $HOME."/work/tutor"
let g:vimwiki_wiki_tutor = deepcopy(s:vimwiki_defaults)
let g:vimwiki_wiki_tutor["name"] = "Tutorials & HowTos"
let g:vimwiki_wiki_tutor["path"] = g:vimwiki_wiki_tutor_base_path."/wiki"
let g:vimwiki_wiki_tutor["path_html"] = g:vimwiki_wiki_tutor_base_path."/.wiki_html"
let g:vimwiki_list += [ g:vimwiki_wiki_tutor    ]  " #1
let g:vimwiki_wiki_projects_base_path = $HOME."/work/projects"
let g:vimwiki_wiki_projects = deepcopy(s:vimwiki_defaults)
let g:vimwiki_wiki_projects["name"] = "Projects"
let g:vimwiki_wiki_projects["path"] = g:vimwiki_wiki_projects_base_path."/wiki"
let g:vimwiki_wiki_projects["path_html"] = g:vimwiki_wiki_projects_base_path."/.wiki_html"
let g:vimwiki_list += [ g:vimwiki_wiki_projects ]  " #2
let g:vimwiki_wiki_tbio_base_path = $HOME."/work/transition-bio"
let g:vimwiki_wiki_tbio = deepcopy(s:vimwiki_defaults)
let g:vimwiki_wiki_tbio["name"] = "Transition Bio"
let g:vimwiki_wiki_tbio["path"] = g:vimwiki_wiki_tbio_base_path."/wiki"
let g:vimwiki_wiki_tbio["path_html"] = g:vimwiki_wiki_tbio_base_path."/.wiki_html"
let g:vimwiki_list += [ g:vimwiki_wiki_tbio  ]  " #3
let g:vimwiki_wiki_fluidic_base_path = $HOME."/work/fluidic-analytics"
let g:vimwiki_wiki_fluidic = deepcopy(s:vimwiki_defaults)
let g:vimwiki_wiki_fluidic["name"] = "Fluidic Analytics"
let g:vimwiki_wiki_fluidic["path"] = g:vimwiki_wiki_fluidic_base_path."/wiki"
let g:vimwiki_wiki_fluidic["path_html"] = g:vimwiki_wiki_fluidic_base_path."/.wiki_html"
let g:vimwiki_list += [ g:vimwiki_wiki_fluidic  ]  " #4
let g:vimwiki_wiki_sandbox_base_path = $HOME."/work/sandbox"
let g:vimwiki_wiki_sandbox = deepcopy(s:vimwiki_defaults)
let g:vimwiki_wiki_sandbox["name"] = "Sandbox"
let g:vimwiki_wiki_sandbox["path"] = g:vimwiki_wiki_sandbox_base_path."/wiki"
let g:vimwiki_wiki_sandbox["path_html"] = g:vimwiki_wiki_sandbox_base_path."/.wiki_html"
let g:vimwiki_list += [ g:vimwiki_wiki_sandbox  ]  " #5
let g:vimwiki_list += [ g:vimwiki_wiki_sandbox  ]  " #6
let g:vimwiki_list += [ g:vimwiki_wiki_sandbox  ]  " #7
let g:vimwiki_list += [ g:vimwiki_wiki_sandbox  ]  " #8
let g:vimwiki_list += [ g:vimwiki_wiki_sandbox  ]  " #9
" Folding
let g:vimwiki_folding = "syntax"
" Task completion level symbols
"let g:vimwiki_listsyms = " .oOX"
"let g:vimwiki_listsyms = " /X"
let g:vimwiki_listsyms = " SX"
"let g:vimwiki_listsyms = " ○◐●"
"let g:vimwiki_listsyms = " "
" Rejected task symbol
"let g:vimwiki_listsym_rejected = "-"
let g:vimwiki_listsym_rejected = "D"
"let g:vimwiki_listsym_rejected = ""
"let g:vimwiki_listsym_rejected = ""
" Highlight completed tasks
let g:vimwiki_hl_cb_checked = 2
" Set conceallevel of vimwiki buffers
let g:vimwiki_conceallevel = 2
" Generate <br /> tags for new-lines in text
let g:vimwiki_text_ignore_newline = 0
" Keyboard mappings prefix
let g:vimwiki_map_prefix = ",,w"
nmap <silent>,,w,w <Plug>VimwikiMakeDiaryNote
nmap <silent>,,w,t <Plug>VimwikiTabMakeDiaryNote
nmap <silent>,,w,y <Plug>VimwikiMakeYesterdayDiaryNote
nmap <silent>,,w,m <Plug>VimwikiMakeTomorrowDiaryNote
nmap <silent>,,w,i <Plug>VimwikiDiaryGenerateLinks
" ,,wi: open journal index
" Prevent VimWiki from hijacking C-i (forward in jumplist)
nmap <silent>,,wn <Plug>VimwikiNextLink


" TASKWIKI (#NA; https://github.com/tbabej/taskwiki)
" TODO: https://pypi.org/project/bugwarrior/
" TODO: https://github.com/ogarcia/trellowarrior
" dependency: apt install taskwarrior python3-tasklib

" Uncomment the following line to disable the plugin
"let g:taskwiki_disable = "disable"
" Taskwarrior RC file
let g:taskwiki_taskrc_location = g:vimwiki_wiki_main["path"]."/tasks/taskrc"
" Taskwarrior data directory
let g:taskwiki_data_location = g:vimwiki_wiki_main["path"]."/tasks/data"
" Alternative taskwarrior instances
let g:taskwiki_extra_warriors = { }
let g:taskwiki_wiki_tutor = { }
let g:taskwiki_wiki_tutor["taskrc_location"] = g:vimwiki_wiki_tutor["path"]."/tasks/taskrc"
let g:taskwiki_wiki_tutor["data_location"] = g:vimwiki_wiki_tutor["path"]."/tasks/data"
let g:taskwiki_extra_warriors["T"] = g:taskwiki_wiki_tutor
let g:taskwiki_wiki_projects = { }
let g:taskwiki_wiki_projects["taskrc_location"] = g:vimwiki_wiki_projects["path"]."/tasks/taskrc"
let g:taskwiki_wiki_projects["data_location"] = g:vimwiki_wiki_projects["path"]."/tasks/data"
let g:taskwiki_extra_warriors["P"] = g:taskwiki_wiki_projects
let g:taskwiki_wiki_tbio = { }
let g:taskwiki_wiki_tbio["taskrc_location"] = g:vimwiki_wiki_tbio["path"]."/tasks/taskrc"
let g:taskwiki_wiki_tbio["data_location"] = g:vimwiki_wiki_tbio["path"]."/tasks/data"
let g:taskwiki_extra_warriors["C"] = g:taskwiki_wiki_tbio
let g:taskwiki_wiki_fluidic = { }
let g:taskwiki_wiki_fluidic["taskrc_location"] = g:vimwiki_wiki_fluidic["path"]."/tasks/taskrc"
let g:taskwiki_wiki_fluidic["data_location"] = g:vimwiki_wiki_fluidic["path"]."/tasks/data"
let g:taskwiki_extra_warriors["F"] = g:taskwiki_wiki_fluidic
let g:taskwiki_wiki_sandbox = { }
let g:taskwiki_wiki_sandbox["taskrc_location"] = g:vimwiki_wiki_sandbox["path"]."/tasks/taskrc"
let g:taskwiki_wiki_sandbox["data_location"] = g:vimwiki_wiki_sandbox["path"]."/tasks/data"
let g:taskwiki_extra_warriors["S"] = g:taskwiki_wiki_sandbox
" Markup syntax
let g:taskwiki_markup_syntax = s:vimwiki_defaults["syntax"]
" Disable conceal (do not touch `concealcursor` vim-option)
let g:taskwiki_disable_concealcursor = "yes"
" Keyboard mappings prefix
let g:taskwiki_maplocalleader = ",,o"


" vim: ts=2 sw=2 et


