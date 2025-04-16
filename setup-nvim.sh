#!/bin/bash

# 1. Cài đặt Vim
sudo apt update && sudo apt install vim -y
# 2. Cài đặt Neovim
sudo apt install neovim -y
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# 3. Tạo file .vimrc (không cần executable)
cat > ~/.vimrc <<EOF
" ~/.vimrc

" Thiết lập số dòng và highlight dòng hiện tại
set number                 " - Hiển thị số dòng.
set norelativenumber       " - Tắt hiển thị số dòng tương đối.
set cursorline             " - Tô sáng dòng hiện tại.
set title                  " - Hiển thị tên file trên tiêu đề cửa sổ.

" Tăng tốc độ nhập lệnh
set timeoutlen=500         " - Rút ngắn thời gian chờ giữa các phím trong tổ hợp phím (500ms).

" Cải thiện tìm kiếm
set ignorecase             " - Tìm kiếm không phân biệt chữ hoa/thường.
set smartcase              " - Tìm kiếm phân biệt chữ hoa nếu chuỗi có chữ hoa.
set incsearch              " - Tìm kiếm tức thời khi gõ.
set hlsearch               " - Tô sáng tất cả các kết quả tìm kiếm.

" Tự động lưu file khi rời chế độ Insert
autocmd InsertLeave * write " - Tự động lưu tệp khi thoát chế độ Insert.

" Cuộn mượt hơn
set scrolloff=8            " - Giữ 8 dòng trên/dưới con trỏ khi cuộn dọc.
set sidescrolloff=8        " - Giữ 8 cột trái/phải khi cuộn ngang.

" Định nghĩa phím tắt cơ bản
let mapleader = " "        " - Đặt phím leader là phím Space.
nnoremap <leader>e :Ex<CR> " - Nhấn Space + e để mở file explorer.
vnoremap <C-c> "+y         " - Copy văn bản được chọn vào clipboard hệ thống.

" Mouse support
set mouse=a                " - Bật hỗ trợ chuột trong Neovim.
set wildmenu               " - Bật menu gợi ý lệnh :e.
set path+=**               " - Tìm file trong thư mục con.
set autoread               " - Tự động tải lại file nếu tệp thay đổi bên ngoài.
set confirm                " - Hiển thị hộp thoại xác nhận khi thoát mà chưa lưu.

" Phím tắt tiện lợi
nnoremap <C-a> ggVG        " - Ctrl+A để chọn toàn bộ văn bản.
vnoremap <C-a> <Esc>ggVG   " - Ctrl+A để chọn toàn bộ văn bản trong Visual mode.
inoremap <C-a> <Esc>ggVG   " - Ctrl+A để chọn toàn bộ văn bản trong Insert mode.

nnoremap <C-s> :w<CR>:q<CR> " - Ctrl+S để lưu và thoát tệp.
inoremap <C-s> <Esc>:w<CR>:q<CR> " - Ctrl+S để lưu và thoát trong Insert mode.

" Bật clipboard
set clipboard+=unnamedplus " - Copy/paste trực tiếp giữa Neovim và clipboard hệ thống.

" Tự động đóng ngoặc
inoremap " ""<left>        " - Tự động đóng dấu ".
inoremap ' ''<left>        " - Tự động đóng dấu '.
inoremap ( ()<left>        " - Tự động đóng ngoặc tròn.
inoremap [ []<left>        " - Tự động đóng ngoặc vuông.
inoremap { {}<left>        " - Tự động đóng ngoặc nhọn.
inoremap {<CR> {<CR>}<ESC>O " - Tự động đóng ngoặc nhọn và xuống dòng.

" Quản lý plugin
call plug#begin('~/.local/share/nvim/plugged') " - Bắt đầu khai báo plugin.

" Các plugin
Plug 'nvim-tree/nvim-web-devicons'       " - Icon đẹp cho file explorer.
Plug 'nvim-tree/nvim-tree.lua'           " - File explorer thay thế NERDTree.
Plug 'vim-airline/vim-airline'           " - Thanh trạng thái đẹp.
Plug 'vim-airline/vim-airline-themes'    " - Giao diện cho thanh trạng thái.
Plug 'folke/tokyonight.nvim', { 'as': 'tokyo' } " - Theme giao diện Tokyonight.

Plug 'neoclide/coc.nvim', {'branch': 'release'} " - Hỗ trợ auto-completion giống VSCode.
Plug 'jiangmiao/auto-pairs'              " - Tự động đóng ngoặc/bracket.
Plug 'tpope/vim-commentary'              " - Comment code nhanh bằng `gc`.
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " - Highlight code nâng cao.

Plug 'tpope/vim-fugitive'                " - Tích hợp Git trong Neovim.
Plug 'airblade/vim-gitgutter'            " - Hiển thị thay đổi Git ở lề.

Plug 'ctrlpvim/ctrlp.vim'                " - Tìm file nhanh giống VSCode Ctrl+P.
Plug 'nvim-lua/plenary.nvim'             " - Thư viện hỗ trợ plugin Telescope.
Plug 'nvim-telescope/telescope.nvim'    " - Plugin tìm kiếm mạnh mẽ.

Plug 'williamboman/mason.nvim'          " - Quản lý LSP servers.
Plug 'williamboman/mason-lspconfig.nvim' " - Cấu hình cho LSP server.

call plug#end() " - Kết thúc khai báo plugin.

EOF

# 4. Tạo symlink cho Neovim
mkdir -p ~/.config/nvim
ln -sf ~/.vimrc ~/.config/nvim/init.vim

echo "Hoàn tất! File .vimrc đã được tạo"
