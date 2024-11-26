" set runtimepath=~/.config/nvim
" set packpath=~/.config/nvim
set noautochdir

call plug#begin('~/.local/share/nvim/plugged')
" Plugins
Plug 'mbbill/undotree'
Plug 'rmagatti/auto-session'

Plug 'folke/trouble.nvim'
Plug 'nvim-tree/nvim-web-devicons' " Optional: Adds file icons
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'mhinz/vim-signify'
Plug 'preservim/tagbar'
Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-fugitive'
Plug 'github/copilot.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'yegappan/mru'
" Plug 'neovim/nvim-lspconfig'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'yggdroot/indentline'
Plug 'tpope/vim-sensible'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'  " Optional, for icons
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'


" Autocomplete engine
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'  " Completion for LSP
Plug 'hrsh7th/cmp-buffer'    " Completion from open buffers
Plug 'hrsh7th/cmp-path'      " Path completion
Plug 'hrsh7th/cmp-cmdline'   " Command-line completion

" Snippet support (optional)
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" LSP Config (optional, for language server integration)
Plug 'neovim/nvim-lspconfig'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

call plug#end()

" General Settings
set number                     " Show line numbers
syntax on                      " Enable syntax highlighting
filetype plugin indent on

" Disable automatic comment continuation
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Indentation for JSON (example for filetype-specific behavior)
autocmd FileType json setlocal shiftwidth=2 tabstop=2 expandtab

" Nerdtree Configuration
let g:NERDTreeShowIcons = 1
nnoremap <C-x> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeFind<CR>

" Buffer Navigation
"let mapleader = " "
nnoremap <leader>q :bprevious<CR>
nnoremap <leader>w :bnext<CR>

" Telescope Configuration
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <C-t> :Telescope live_grep<CR>

" Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme = 'powerlineish'

" IndentLine Configuration
let g:indentLine_enabled = 1
let g:indentLine_char = '|'

" Toggle spaces/tabs visibility
nnoremap <leader>l :IndentLinesToggle<CR>

" Startify Configuration
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   Recently opened files'] },
      \ { 'type': 'dir',       'header': ['   MRU in current directory '. getcwd()] },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
      \ ]
let g:startify_bookmarks = ['~/.config/nvim/init.vim', '~/projects']
let g:startify_session_persistence = 1

" Autocompletion and Indentation
set completeopt=menu,menuone,noselect

lua << EOF

require('nvim-web-devicons').setup {
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    }
  },
  color_icons = true,
  default = true,
  strict = true,
  override_by_filename = {
    [".gitignore"] = {
      icon = "",
      color = "#f1502f",
      name = "Gitignore"
    }
  },
  override_by_extension = {
    ["log"] = {
      icon = "",
      color = "#81e043",
      name = "Log"
    }
  }
}

require("trouble").setup {
  position = "bottom", -- Position of the list: "bottom", "top", "left", or "right"
  height = 10,         -- Height of the trouble list when position is "bottom" or "top"
  width = 50,          -- Width of the list when position is "left" or "right"
  icons = {
        error = "❌",
        warning = "⚠️",
        hint = "💡",
        info = "ℹ️"
    },
  mode = "workspace_diagnostics", -- Modes: "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references"
  auto_open = false,   -- Automatically open Trouble when there are diagnostics
  auto_close = true,   -- Automatically close Trouble when no diagnostics are present
  use_diagnostic_signs = true -- Use signs defined in the LSP client
}

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        preview_width = 0.5,
      },
    },
    file_ignore_patterns = {"node_modules"},

    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {



    live_grep = {
      theme = "dropdown",
    },

    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,  -- Enable syntax highlighting
  },
  indent = {
    enable = true,  -- Enable Treesitter-based indentation
  },
}

require('Comment').setup()

require('treesitter-context').setup({
  enable = true,           -- Enable this plugin
  max_lines = 1,           -- How many lines of context to show
  trim_scope = 'outer',    -- Show the outer context (e.g., parent function/class)
  mode = 'cursor',         -- Line the context at the cursor (can be "topline")
  separator = '-',         -- Add a separator line (e.g., '-' or '=') or set it to nil
})

-- Load Mason and Mason-LSPConfig
require("mason").setup({
    ui = {
        border = "rounded", -- Nice borders for the UI
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "lua_ls" }, -- Add your desired servers here
    automatic_installation = true, -- Automatically install missing servers
})

require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "cpp", "lua", "python" }, -- List of parsers to install
    highlight = {
        enable = true, -- Enable syntax highlighting
    },
    incremental_selection = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})


-- Set up LSP servers with `lspconfig`
local lspconfig = require("lspconfig")


-- Example: TSServer for JavaScript/TypeScript
lspconfig.ts_ls.setup {}

-- Example: Lua language server
lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" }, -- Recognize `vim` as a global
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}


-- Setup nvim-cmp
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)  -- For LuaSnip users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- LSP completion
    { name = 'luasnip' },   -- Snippet completion
  }, {
    { name = 'buffer' },    -- Buffer completion
  }),
})

-- Use nvim-cmp in command-line mode
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


require("luasnip.loaders.from_vscode").lazy_load()


-- Example: Pyright for Python
lspconfig.pyright.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
})

local null_ls = require('null-ls')

local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black, -- Python formatter
  },
})

vim.api.nvim_set_keymap('n', '<leader>ss', ':SessionSave<CR>', { noremap = true, silent = true }) -- Save session
vim.api.nvim_set_keymap('n', '<leader>sr', ':SessionRestore<CR>', { noremap = true, silent = true }) -- Restore session
vim.api.nvim_set_keymap('n', '<leader>sd', ':SessionDelete<CR>', { noremap = true, silent = true }) -- Delete session
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

require('auto-session').setup({
    log_level = 'info', -- Log level: 'debug', 'info', 'warn', 'error'
    auto_session_enable_last_session = true, -- Automatically load the last session
    auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/", -- Session storage directory
    auto_session_enabled = true, -- Enable auto-session
    auto_save_enabled = true, -- Save sessions automatically
    auto_restore_enabled = false, -- Restore sessions automatically
    auto_session_suppress_dirs = { '~/', '~/Downloads', '/tmp' }, -- Skip these directories
})


EOF

" Move to the split in the specified direction using Alt + Arrow keys"

nnoremap <M-Left>  :wincmd h<CR>
nnoremap <M-Down>  :wincmd j<CR>
nnoremap <M-Up>    :wincmd k<CR>
nnoremap <M-Right> :wincmd l<CR>


autocmd BufWritePost,FileWritePost * if exists(":NERDTreeFind") | execute "NERDTreeRefreshRoot" | endif
" Automatically refresh NERDTree when opening it
autocmd BufEnter * if &buftype == 'terminal' | let g:NERDTreeHijackNetrw = 1 | endif

" Show Git status in NERDTree
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✗",
    \ "Staged"    : "✓",
    \ "Untracked" : "?",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Ignored"   : "◌"
\ }


let g:airline_themes = ['powerlineish', 'dark', 'light', 'molokai', 'lucius', 'solarized']

function! CycleAirlineTheme()
  let g:current_theme_index = get(g:, 'current_theme_index', 0) + 1
  if g:current_theme_index >= len(g:airline_themes)
    let g:current_theme_index = 0
  endif
  let g:airline_theme = g:airline_themes[g:current_theme_index]
  AirlineRefresh
endfunction

nnoremap <leader>at :call CycleAirlineTheme()<CR>

let g:colorschemes = getcompletion('', 'color') " Get all available colorschemes
let g:current_colorscheme_index = 0

function! CycleColorschemes()
  let g:current_colorscheme_index = (g:current_colorscheme_index + 1) % len(g:colorschemes)
  let colorscheme = g:colorschemes[g:current_colorscheme_index]
  execute 'colorscheme ' . colorscheme
  echo 'Switched to ' . colorscheme
endfunction

nnoremap <leader>cs :call CycleColorschemes()<CR>
" colorscheme Chasing_Logic
colorscheme xoria256
nmap <leader>l :set list!<CR>



let g:MRU_Max_Entries = 50
let g:MRU_Exclude_Files = '*.tmp,*.swp,.git*'
let g:MRU_Exclude_Directories = '~/Downloads,~/.cache'


autocmd CmdlineLeave / :nohlsearch


imap <silent><script><expr> <Tab> copilot#Accept("\<Tab>")


" Map Ctrl + / for commenting in Normal mode
nnoremap <C-_> :lua require("Comment.api").toggle.linewise.current()<CR>

" Map Ctrl + / for commenting in Visual mode
vnoremap <C-_> :lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>



" Enable NERDTree Git status
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✗",
    \ "Staged"    : "✓",
    \ "Untracked" : "?",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔",
    \ "Ignored"   : "◌"
\ }


" Enable signify
let g:signify_enable = 1

" Update signs when writing or reading a file
let g:signify_vcs_list = ['git']


" Customize signs
let g:signify_sign_add = '+'
let g:signify_sign_change = '~'
let g:signify_sign_delete = '_'
let g:signify_realtime = 1

set signcolumn=auto
" highlight SignColumn guibg=#000000 guifg=#00000

highlight SignColumn ctermfg=247 ctermbg=233 guifg=#9e9e9e guibg=#121212
highlight link SignColumn LineNr " Match SignColumn to LineNr
highlight SignifySignAdd guifg=#00ff00 guibg=NONE
highlight SignifySignChange guifg=#ffff00 guibg=NONE
highlight SignifySignDelete guifg=#ff0000 guibg=NONE

nnoremap <leader>tt :TagbarToggle<CR>  " Map <leader>tt to toggle the tagbar


highlight TreesitterContext guibg=NONE guifg=NONE
highlight TreesitterContextLineNumber guifg=#7aa2f7




" Resize horizontally
nnoremap <S-Left> :vertical resize -2<CR>
nnoremap <S-Right> :vertical resize +2<CR>

" Resize vertically
nnoremap <S-Up> :resize +2<CR>
nnoremap <S-Down> :resize -2<CR>


function! ResizePanesGrid()
  " Equalize all pane sizes
  wincmd =
endfunction

" Map the function to a keybinding (e.g., <leader>g for "grid")
nnoremap <leader>g :call ResizePanesGrid()<CR>



" trouble
nnoremap <leader>xx :Trouble diagnostics toggle<CR>
nnoremap <leader>xX :Trouble diagnostics toggle filter.buf=0<CR>
nnoremap <leader>cs :Trouble symbols toggle focus=false<CR>
nnoremap <leader>cl :Trouble lsp toggle focus=false win.position=right<cr>
nnoremap <leader>xl :Trouble loclist toggle<cr>

nnoremap <leader>xQ :Trouble qflist toggle<cr>


autocmd BufWritePre * silent! %s/\s\+$//e


" undo tree

set undofile
set undodir=~/.config/nvim/undo
let g:undotree_WindowLayout = 2
let g:undotree_SplitWidth = 30
let g:undotree_SetFocusWhenToggle = 1
nnoremap <F5> :UndotreeToggle<CR>

