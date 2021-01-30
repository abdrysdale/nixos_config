with import <nixpkgs> {};

vim_configurable.customize {
	
	# Binary name
	name = "vim";
	vimrcConfig.customRC = ''
		set nu
		syntax on
        set backspace=indent,eol,start
		let g:vim_markdown_math = 1
		let g:vim_markdown_strikethrough = 1
		set viminfo='100,f1
		map <C-n> :NERDTreeToggle<CR>
		filetype plugin indent on
		filetype plugin on
		let g:text_flavor='latex'
		let g:Tex_DefaultTargetFormat='pdf'
		let g:tex_flavor='latex'
		let g:vimtex_view_method='zathura'
		let g:vimtex_quickfix_mode=0
		set conceallevel=1
		let g:tex_conceal='abdmg'
		set tabstop=4
		set shiftwidth=4
		set grepprg=grep\ -nH\ $*
		set noexpandtab
		map <C-c> :"+y<CR>
		setlocal spell
		set spell spelllang=en_gb
		hi clear SpellBad
		hi SpellBad cterm=underline
		inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
		set splitbelow
		set splitright
	'';
    vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
    vimrcConfig.vam.pluginDictionaries = [
      { names = [
        # Plug ins at:
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/vim-plugins/vim-plugin-names
        "vim-markdown"
        "nerdtree"
        "vim-gitgutter"
        "todo-txt-vim"
        ]; }
    ];
}
