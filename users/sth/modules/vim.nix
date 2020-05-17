{ nixos, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "a378bccd609c159fa8d421233b9c5eae04f02042";
    ref = "release-20.03";
  };
in
{
  home-manager.users.sth.programs.vim = {
    enable = true;
    extraConfig = ''
      set nocompatible
      filetype off

      syntax enable
      set background=dark

      set tabstop=4
      set softtabstop=4
      set shiftwidth=2
      set expandtab
      set nowrap

      set number
      set relativenumber
      set showcmd
      set ruler
      set cursorline
      set wildmenu
      set lazyredraw
      set showmatch
      set list listchars=tab:»·,trail:·


      let mapleader = ","
      let maplocalleader = "\\"

      set backspace=indent,eol,start

      nnoremap <C-w>, :bp<CR>
      nnoremap <C-w>. :bn<CR>
      nnoremap <C-w>x :bd<CR>
      nnoremap <C-w>X :bd!<CR>

      nnoremap <C-w>1 :b1<CR>
      nnoremap <C-w>2 :b2<CR>
      nnoremap <C-w>3 :b3<CR>
      nnoremap <C-w>4 :b4<CR>
      nnoremap <C-w>5 :b5<CR>
      nnoremap <C-w>6 :b6<CR>
      nnoremap <C-w>7 :b7<CR>
      nnoremap <C-w>8 :b8<CR>
      nnoremap <C-w>9 :b9<CR>

      set splitbelow
      set splitright

      nnoremap <C-w>\ :vsplit<CR>
      nnoremap <C-w>- :split<CR>
      nnoremap <C-w>j <C-W><C-J>
      nnoremap <C-w>k <C-W><C-K>
      nnoremap <C-w>l <C-W><C-L>
      nnoremap <C-w>h <C-W><C-H>
      nnoremap <C-j> <C-W><C-J>
      nnoremap <C-k> <C-W><C-K>
      nnoremap <C-l> <C-W><C-L>
      nnoremap <C-h> <C-W><C-H>

      set incsearch
      set hlsearch
      nnoremap <leader><space> :nohlsearch<CR><C-l>

      set encoding=utf-8


      " Strip trailing whitespaces on each save
      fun! <SID>StripTrailingWhitespaces()
          let l = line(".")
          let c = col(".")
          %s/\s\+$//e
          call cursor(l, c)
      endfun
      autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

      "ctrlp.vim
      let g:ctrlp_map = '<c-p>'
      let g:ctrlp_cmd = 'CtrlP'
      let g:ctrlp_working_path_mode = 'ra'
      let g:ctrlp_regexp = 1 "search in regex mode
      let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
      let g:ctrlp_root_markers = ['.env']
      let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] "ignore files in gitignore
      set wildignore+=*/tmp/*,*.so,*.swp,*.zip
      set wildignore+=*/.git/*,*/.idea/*,*/.DS_Store,*/vendor
      map <D-r> :CtrlPBufTag<CR>
      map <D-p> :CtrlP<CR>

      "nerdcommenter
      let g:NERDSpaceDelims = 1
      let g:NERDCompactSexyComs = 1
      let g:NERDCommentEmptyLines = 1
      let g:NERDTrimTrailingWhitespace = 1

      "vim-gitgutter
      set updatetime=250
      nmap ]h <Plug>GitGutterNextHunk
      nmap [h <Plug>GitGutterPrevHunk
    '';

    plugins = with pkgs.vimPlugins; [
      ctrlp-vim
      emmet-vim
      nerdcommenter
      nerdtree
      nord-vim
      vim-nix
      vim-airline
      vim-airline-themes
      vim-gitgutter
    ];
  };
}