" make 256color in tmux work
set background=dark

if 1
	augroup vimStartup
		au!
	
		autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
			\ |		exe "normal! g`\""
			\ | endif
	augroup END
endif

augroup go_save | au!
	autocmd BufWritePost *.go !goimports -l -w '%:p:h'
	autocmd BufWritePost *.go edit!
	autocmd BufWritePost *.go redraw!
augroup end

augroup rust_save | au!
	autocmd BufWritePost *.rs !cargo fmt
	autocmd BufWritePost *.rs edit!
	autocmd BufWritePost *.rs redraw!
augroup end

augroup zig_save | au!
	autocmd BufWritePost *.zig !zig fmt '%:p:h'
	autocmd BufWritePost *.zig edit!
	autocmd BufWritePost *.zig redraw!
	autocmd BufWritePost *.zon !zig fmt '%:p:h'
	autocmd BufWritePost *.zon edit!
	autocmd BufWritePost *.zon redraw!
augroup end

autocmd FileType rust setlocal ts=4 sw=4 softtabstop=4 expandtab
autocmd FileType zig setlocal ts=4 sw=4 softtabstop=4 expandtab
autocmd FileType yaml setlocal ts=2 sw=2 softtabstop=2 expandtab
autocmd FileType nroff setlocal expandtab

autocmd FileType gitcommit setlocal textwidth=72 formatoptions-=t

nnoremap <Enter> moO<Esc>`o

set autoindent
set number relativenumber
set hls is
set ttm=100
syntax off
