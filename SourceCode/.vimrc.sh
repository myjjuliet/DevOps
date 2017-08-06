set hlsearch "검색어 하이라이팅"
set autoindent "자동 들여쓰기"
set scrolloff=2
set wildmode=longest,list
set ts=4 "tag select"
set sts=4 "st select"
set sw=1 " 스크롤바 너비"
set autowrite " 다른 파일로 넘어갈 때 자동 저장"
set autoread " 작업 중인 파일 외부에서 변경됬을 경우 자동으로 불러옴"
set cindent " C언어 자동 들여쓰기"
set bs=eol,start,indent
set history=256
set laststatus=2 " 상태바 표시 항상"
set paste " 붙여넣기 계단현상 없애기"
set ignorecase " 대소문자 구분없이 검색"
set shiftwidth=4 " 자동 들여쓰기 너비 설정"
"" 마지막으로 수정된 곳에 커서를 위치함
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

syntax enable
set t_Co=256

"컬러 스킴 사용"
colorscheme OceanicNext
