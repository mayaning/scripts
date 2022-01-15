" 更新时间：2016-03-30 12:15:21

" 定义快捷键的前缀，即 <Leader>
let mapleader=";"

" >>>>>>>>>> >>>>>>>>>>
" 文件类型侦测

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" vim 自身（非插件）快捷键
"
" Vim 可以用来查看和编辑二进制文件
" vim -b egenea-base.ko   加上-b参数，以二进制打开
" 然后输入命令  :%!xxd -g 1  切换到十六进制模式显示

" 定义快捷键到行首和行尾
nmap LB 0
nmap LE $

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p

" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>

" 设置快捷键遍历子窗口
" 依次遍历
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j

" 打开vim时，自动中转到上次打开的位置。
" 打开历史编辑过的文件：
" ^Coo 即按住Ctrl, 然后按两次o
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 设置高亮TODO NOTE FIXME等关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|Note by Ma Yaning\)')
  endif
endif

" 定义快捷键在结对符之间跳转
"nmap <Leader>M %

" <<<<<<<<<< <<<<<<<<<<

" 让配置变更立即生效
"autocmd BufWritePost $MYVIMRC source $MYVIMRC

" >>>>>>>>>> >>>>>>>>>>
" 其他

" 开启实时搜索功能
set incsearch

" 搜索时大小写不敏感
"set ignorecase

" 关闭兼容模式
set nocompatible

" vim 自身命令行模式智能补全
set wildmenu

" 设置文本宽度为80列，在81列给出提示
set textwidth=80
set colorcolumn=+1

" 设置自动折行
set wrap
" 设置中文自动折行
" option m - Also break at multi-byte character above 255. This is useful for
" Asian text where every charater is a word on its own.
" option M - When joining lines, don't insert a space before or after a
" multi-byte character. Overrules the 'B' flag. 
set formatoptions+=mM
" 使用gq快捷键可以对内容进行重排，达到手动折行的目的

" 个人喜好设置
" 设置添加注释的快捷键: <Leader>mync
nmap <Leader>mync O/** Note by Ma Yaning:<CR>*/<ESC>bi

" Latex listing: \lstinputlisting[language=Bash]{}
nmap <Leader>lff o\lstinputlisting[language=Bash]{}<ESC>i
nmap <Leader>lil A\lstinline{}<ESC>i
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####


"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
" 插件管理器 Vundle
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
" 使用说明:
" 安装：
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" 
" 插件安装
" BundleList -列举出列表中(.vimrc中)配置的所有插件
" BundleInstall -安装列表中全部插件
" BundleInstall -更新列表中全部插件
" BundleSearch foo -查找foo插件
" BundleSearch foo -刷新foo插件缓存
" BundleClean -清除列表中没有的插件
" BundleClean! -清除列表中没有的插件
"
" vundle 环境设置
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'   " slarized 配色方案
Plugin 'tomasr/molokai'                     " molokai配色方案
Plugin 'vim-scripts/phd'                    " phd配色方案
Plugin 'Lokaltog/vim-powerline'             " 状态栏插件
Plugin 'octol/vim-cpp-enhanced-highlight'   " CPP语法高亮插件
Plugin 'nathanaelkane/vim-indent-guides'    " 缩进可视化插件 Indent Guides
Plugin 'majutsushi/tagbar'                  " 标签侧边栏插件
Plugin 'vim-scripts/DfrankUtil'             " indexer和vimprj插件的依赖
Plugin 'vim-scripts/indexer.tar.gz'         " 周期性标签生成
Plugin 'vim-scripts/vimprj'                 " 不同的项目中使用不同的vim配置文件
Plugin 'dyng/ctrlsf.vim'                    " 关键字查找
Plugin 'terryma/vim-multiple-cursors'       " 多光标
Plugin 'scrooloose/nerdcommenter'           " 快速注释/解开注释 
Plugin 'vim-scripts/DrawIt'                 " 文本画图插件
Plugin 'SirVer/ultisnips'                   " 预定义代码块输入
Plugin 'honza/vim-snippets'                 " 预定义代码块集合
Plugin 'Valloric/YouCompleteMe'             " 基于语义的代码补全
Plugin 'derekwyatt/vim-fswitch'             " .h和.cpp文件间切换
Plugin 'derekwyatt/vim-protodef'            " 自动生成接口函数
Plugin 'fholgado/minibufexpl.vim'           " 多文档编辑 
"Plugin 'gcmt/wildfire.vim'                  " 快速选中结对符内的文本
Plugin 'sjl/gundo.vim'                      " 基于分支的undo
Plugin 'Lokaltog/vim-easymotion'            " 快速跳转
Plugin 'suan/vim-instant-markdown'          " markdown文件实时预览
"Plugin 'lilydjwg/fcitx.vim'                 " fcitx与vim配合, 你在vim插入状态下
                                        " 输入中文时，回到正常模式下，不用
                                        " 切换输入法便可以进行命令操作
Plugin 'ctrlpvim/ctrlp.vim'                 " 模糊文件搜索
Plugin 'vim-scripts/cscope.vim'
"Plugin 'python-mode/python-mode'            " python mode
Plugin 'w0rp/ale'
Plugin 'fatih/vim-go'                       " Golang plugin
Plugin 'dgryski/vim-godef'
Plugin 'Blackrush/vim-gocode'
"Plugin 'majutsushi/tagbar'
Plugin 'TakeshiTseng/vim-language-p4'
Plugin 'Visual-Mark'                        " virtualmark多行标签插件
Plugin 'Mark'                               " virtualmark多行标签插件
Plugin 'scrooloose/nerdtree'          " File tree manager
Plugin 'jistr/vim-nerdtree-tabs'      " enhance nerdtree's tabs
Plugin 'ryanoasis/vim-devicons'       " add beautiful icons besides files
Plugin 'Xuyuanp/nerdtree-git-plugin'  " display git status within Nerdtree
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight' " enhance devicons
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/winmanager'
Plugin 'kien/rainbow_parentheses.vim'   " 彩色括号
" Python
Plugin 'davidhalter/jedi-vim'      " Python 自动补全工具
Plugin 'hhatto/autopep8'           " Python 自动格式化工具
Plugin 'nvie/vim-flake8'           " Python 语法检查工具，依赖于flake8, 可以通过
                                   " pip3 install flake8安装
Plugin 'DoxygenToolkit.vim'

" PlantUML
"Plugin 'plantuml-syntax'
"Plugin 'wmgraphviz'
Plugin 'weirongxu/plantuml-previewer.vim.git'
Plugin 'aklt/plantuml-syntax'
Plugin 'tyru/open-browser.vim'

" 插件列表结束
call vundle#end()
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
" WinManager
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
" 设置F2和\twm两种方式来开关Winmanager
nnoremap <leader>wm :WMToggle<cr>
" 设置Ctrl+W Ctrl+F进入NERDTree窗口
nnoremap <c-w><c-f> :FirstExplorerWindow<cr>
" 设置Ctrl+W Ctrl+B进入TagList窗口
nnoremap <c-w><c-b> :BottomExplorerWindow<cr>
" 设置NERDTree和TagList同一列，NERDTree在上面，Taglist在下面
"let g:winManagerWindowLayout = 'NERDTree|TagList'
let g:winManagerWindowLayout = 'TagList'
" 设置宽度为40，默认25
let g:winManagerWidth = 40

" MBE
" 始终打开mini buffer
let g:miniBufExplBuffersNeeded = 1
" 通过gbk后退一个buffer，gbj前进一个buffer
nnoremap gbk :MBEbb<cr>
nnoremap gbj :MBEbf<cr>

" Used by winmanager {{{1
" 设置在Winmanager中显示的名称
let g:NERDTree_title = "[NERDTree]"
" 函数中加exe 'q' 可避免多弹出一个框的问题
function! NERDTree_Start()
    exe 'q'
    exe 'NERDTree'
endfunction
" 这个函数的返回值1, 如果设置为0的话，在打开文件时窗口会乱
function! NERDTree_IsValid()
    return 1
endfunction

let Tlist_Show_One_File = 1         "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1       "如果taglist窗口是最后一个窗口，则退出vim
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
"
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
" tagbar 标签列表
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
" 功能说明:
" What Tagbar is
" Tagbar is a Vim plugin that provides an easy way to browse the tags of the
" current file and get an overview of its structure. It does this by creating a
" sidebar that displays the ctags-generated tags of the current file, ordered 
" by their scope. This means that for example methods in C++ are displayed under
" the class they are defined in.
" What Tagbar is not
" Tagbar is not a general-purpose tool for managing tags files. It only creates
" the tags it needs on-the-fly in-memory without creating any files. tags file 
" management is provided by other plugins, like for example easytags.

"配置:
" 设置 tagbar 子窗口的位置出现在主编辑区的左边
let tagbar_left=1
" 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag
nnoremap <Leader>ilt :TagbarToggle<CR>
" 设置标签子窗口的宽度
let tagbar_width=32
" tagbar 子窗口中不显示冗余帮助信息
let g:tagbar_compact=1
" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
 \ 'ctagstype' : 'c++',
 \ 'kinds'     : [
     \ 'c:classes:0:1',
     \ 'd:macros:0:1',
     \ 'e:enumerators:0:0', 
     \ 'f:functions:0:1',
     \ 'g:enumeration:0:1',
     \ 'l:local:0:1',
     \ 'm:members:0:1',
     \ 'n:namespaces:0:1',
     \ 'p:functions_prototypes:0:1',
     \ 's:structs:0:1',
     \ 't:typedefs:0:1',
     \ 'u:unions:0:1',
     \ 'v:global:0:1',
     \ 'x:external:0:1'
 \ ],
 \ 'sro'        : '::',
 \ 'kind2scope' : {
     \ 'g' : 'enum',
     \ 'n' : 'namespace',
     \ 'c' : 'class',
     \ 's' : 'struct',
     \ 'u' : 'union'
 \ },
 \ 'scope2kind' : {
     \ 'enum'      : 'g',
     \ 'namespace' : 'n',
     \ 'class'     : 'c',
     \ 'struct'    : 's',
     \ 'union'     : 'u'
 \ }
\ }
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
"
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
" NERDTree 
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
" 功能描述：
" 工程文件浏览

" 配置:
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置 NERDTree 子窗口宽度
let NERDTreeWinSize=40
" 设置 NERDTree 子窗口位置
let NERDTreeWinPos="right"
"let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

filetype plugin indent on
" >>>>>>>>>> >>>>>>>>>>
"
" 配色方案
set background=dark
"colorscheme solarized
"colorscheme molokai
"colorscheme phd
"colorscheme default

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" vim-powerline
"
"功能说明:
" Powerline是Vim的一个非常漂亮的状态栏插件，安装了Powerline之后，
" Vim底部将会出现一个增强型状态栏，当Vim处于NORMAL、INSERT、BLOCK等状态时，
" 状态栏会呈现不同的颜色，同时状态栏还会显示当前编辑文件的格式（uft-8等）、
" 文件类型（java、xml等）和光标位置等.
"
"配置:
" 设置状态栏主题风格
let g:Powerline_colorscheme='solarized256'

" <<<<<<<<<< <<<<<<<<<<

" <<<<<<<<<< <<<<<<<<<<
" vim-cpp-enhanced-highlight
"
" 功能说明:
" Vim自带的语法高亮不能高亮C++的部分关键字和标准库，
" 使用vim-cpp-enhanced-highlight可以解决这个问题
"
" 配置:
"高亮类，成员函数，标准库和模板
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
"文件较大时使用下面的设置高亮模板速度较快，但会有一些小错误
"let g:cpp_experimental_template_highlight = 1

" >>>>>>>>>> >>>>>>>>>>
"
" >>>>>>>>>> >>>>>>>>>>
" vim-indent-guides
" 
" 功能说明:
" vimer，看见win下notepad++等editor的对齐线是不是很羡慕？
" 不要急，vim也有同样的插件帮您实现——vim-indent-guides。
"
" 配置
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
nmap <silent> <Leader>i <Plug>IndentGuidesToggle

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" indexer
"
" 功能说明:
" 周期性针对这个工程自动生成标签文件，并通知 vim 引人该标签文件
"
" 配置
" 设置插件 indexer 调用 ctags 的参数
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+l+p+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" DfrankUtil
"
" 功能说明:
" Just a library for some scripts.
" You don't need to download it if you haven't plugins depending on DfrankUtil.
" Now there's two plugins that depend on this library:
"   *) Indexer (vimscript #3221)
"   *) Vimprj (vimscript #3872)

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" vimprj 
"
" 功能说明:
" Using this plugin is quite easy. You need to create in the root directory of
" your project new directory ".vimprj" and put any number of files "*.vim" in it.
" Every time you open new file in Vim, plugin looks for ".vimprj" directory up
" by tree, and if it is found, then all *.vim files from it will be sourced.
"
" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" ctrlsf
"
" 功能说明:
" 在安装了ack或者ag的基础上再安装该插件即可。正如它的名字，它提供了和sublime 
" text 2中Ctrl-Shift-F 一样的搜索效果。和ack或者ag不同的是，不再是显示一行，而
" 是显示整个上下文。非常好用。除此之外，可以按下 p 进行预览，运行 :CtrlSFOpen 
" 重新打开搜索结果窗口(默认选择后关闭搜索窗口)。这个插件也是来自国内的朋友。

" 设置ctrlsf 使用ag
let g:ctrlsf_ackprg = 'ag'
" 使用 ctrlsf.vim 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
nnoremap <Leader>sp :CtrlSF<CR>

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" multiple-cursors
"
" 功能说明:
" 类似sublimetext的多光标选中
"
" 配置:
"
" Default highlighting (see help :highlight and help :highlight-link)
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" nerdcommenter
"
" 功能说明:
" 快速注释/解开注释
" <leader>cc            加注释
" <leader>cu            解注释
" <leader>c<space>      加上/解开注释, 智能判断
" <leader>cy            先复制, 再注解(p可以进行黏贴)
"
" 配置
" 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" DrawIt
"
" 功能说明：
" 文本作图插件，用法如下
"   \di to start DrawIt and
"   \ds to stop  DrawIt.
"Supported Features
"   <left>       move and draw left
"   <right>      move and draw right, inserting lines/space as needed
"   <up>         move and draw up, inserting lines/space as needed
"   <down>       move and draw down, inserting lines/space as needed
"   <s-left>     move left
"   <s-right>    move right, inserting lines/space as needed
"   <s-up>       move up, inserting lines/space as needed
"   <s-down>     move down, inserting lines/space as needed
"   <space>      toggle into and out of erase mode
"   >            draw -> arrow
"   <            draw <- arrow
"   ^            draw ^  arrow
"   v            draw v  arrow
"   <pgdn>       replace with a \, move down and right, and insert a \
"   <end>        replace with a /, move down and left,  and insert a /
"   <pgup>       replace with a /, move up   and right, and insert a /
"   <home>       replace with a \, move up   and left,  and insert a \
"   \>           draw fat -> arrow
"   \<           draw fat <- arrow
"   \^           draw fat ^  arrow
"   \v           draw fat v  arrow
"   \a           draw arrow based on corners of visual-block
"   \b           draw box using visual-block selected region
"   \e           draw an ellipse inside visual-block
"   \f           fill a figure with some character
"   \h           create a canvas for \a \b \e \l
"   \l           draw line based on corners of visual block
"   \s           adds spaces to canvas
"   <leftmouse>  select visual block
"<s-leftmouse>  drag and draw with current brush (register)
"   \ra ... \rz  replace text with given brush/register
"   \pa ...      like \ra ... \rz, except that blanks are considered
"                to be transparent
"
" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" UltiSnips
"
" 功能说明:
" 这是什么？相信大家经常在写代码时需要在文件开头加一个版权声明之类的注释，
" 又或者在头文件中要需要： #ifndef... #def... #endif 这样的宏，亦或者写一个
" for 、 switch 等很固定的代码片段，这是一个非常机械的重复过程，但又十分频繁。
" 我十分厌倦这种重复，为什么不能有一种快速输入这种代码片段的方法呢？于是，
" 各种snippets插件出现了，而它们之中，UltiSnips是最好的一个。比如上面的一长串 
" #ifndef... #def... #endif ，你只需要输入 ifn<TAB> ，怎么样，方便吧。更为重要
" 的一点是它支持扩展，你可以随心所欲的编辑你自己的snippets。
"
" 配置
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" UltiSnips 的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" YouCompleteMe
"
" 功能说明:
" 基于语义的代码补全
" 依赖:
" dnf install clang clang-libs clang-devel boost boost-devel cmake python
" 编译:
" # cmake -G "Unix Makefiles" -DUSE_SYSTEM_BOOST=ON -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
" cd ~/.vim/bundle/YouCompleteMe
" ./install.sh
"
" 配置:
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
let g:ycm_global_ycm_extra_conf = '~/.vim/data/ycm/.ycm_extra_conf.py'
" let g:ycm_server_python_interpreter='/usr/bin/python2.7'
let g:ycm_server_python_interpreter='/usr/bin/python3'
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=0
"" 引入 C++ 标准库 tags
"set tags+=/data/misc/software/app/vim/stdcpp.tags
"set tags+=/data/misc/software/app/vim/sys.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 基于语义的代码导航
nnoremap <leader>jc :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
" YCM 补全菜单配色
" 菜单
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" vim-protodef
"
" 功能说明:
" 在 *.h 中写成员函数的声明，在 *.cpp 中写成员函数的定义，很麻烦，我希望能根据
" 类声明自动生成类实现的代码框架 —— 
" vim-protodef（https://github.com/derekwyatt/vim-protodef ）。vim-protodef 
" 依赖 FSwitch（https://github.com/derekwyatt/vim-fswitch ），请一并安装
" 使用<leader>PP生成接口
"
" 配置:
" 成员函数的实现顺序与声明顺序一致
let g:disable_protodef_sorting=1
" 设置 pullproto.pl 脚本路径
let g:protodefprotogetter='~/.vim/bundle/vim-protodef/pullproto.pl'
" 成员函数的实现顺序与声明顺序一致
let g:disable_protodef_sorting=1

" <<<<<<<<<< <<<<<<<<<<


" >>>>>>>>>> >>>>>>>>>>
" minibufexpl 
" 
" 功能说明
" 多文档编辑

" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>bl :MBEToggle<cr>

" buffer 切换快捷键
map <C-Tab> :MBEbn<cr>
map <C-S-Tab> :MBEbp<cr>

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" wildfire
" 
" 功能说明:
" 快速选中结对符内的文本
" 
" 配置:
" 快捷键
map <SPACE> <Plug>(wildfire-fuel)
vmap <S-SPACE> <Plug>(wildfire-water)

" 适用于哪些结对符
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" gundo
" 用法说明：
" undo，编辑器世界中的后悔药，让你有机会撤销最近一步或多步操作，这是任何编辑器
" 都具备的基础功能。比如，第一步输入 A，第二步输入 B，第三步输入 C，当前文本为
" ABC，一次 undo 后变成 AB，再次 undo 后变成 A，显然，每次 undo 撤销的均是最后
" 的一步操作，通常采用栈这种数据结构来实现 undo 功能，由于栈具有后进先出的特点
" ，所以，功能实现起来非常自然且便捷，但同时，也引入了致命伤，无法支持分支上的
"  undo 操作。
"  还是前面的例子，分三步依次输入完 ABC 后，一次 undo 变成 AB，这时，输入 D，
"  之后，无论你多少次 undo 都不可能再找回 C，究其原因，D 是彻底覆盖了 C，而不是
"  与 C 形成两个分支
"  在我的使用场景中，非常需要在我输入 D 后还能找回 C 的 undo 功能，即，支持分支
"  的 undo，gundo.vim 降临。gundo.vim采用树这种数据结构来实现 undo，每一次编辑
"  操作均放在树的叶子上，每次 undo后，先回到主干，新建分支继续后续操作，而不是
"  直接覆盖，从而实现支持分支的undo 功能。gundo.vim 要求 vim 版本不低于 v7.3 且
"  支持 python v2.4 及以上。
" 
" 配置:
" 调用 gundo 树
nnoremap <Leader>ud :GundoToggle<CR>

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" easymotion
" 
" 功能说明:
" 快速跳转
" 
" 配置:
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
" 跳转到当前光标前后的位置(w/b)
" 快捷键<leader><leader>w和<leader><leader>b
" 搜索跳转(s)
" 快捷键<leader><leader>s, 然后输入要搜索的字母, 这个跳转是双向的
" 行级跳转(jk)
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
" 行内跳转(hl)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
"ctrlp
"
" 功能说明：
" 模糊搜索, 可以搜索文件/buffer/mru/tag等等
"
" 配置：
" 设置过滤不进行查找的后缀名 
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
\ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
\ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" <<<<<<<<<< <<<<<<<<<<

" >>>>>>>>>> >>>>>>>>>>
" cscope
" 
" 功能描述:
" 代码导航
" 
" 配置
if has("cscope")
set csprg=/usr/bin/cscope        " 指定用来执行cscope的命令
set csto=0                        " 设置cstag命令查找次序：0先找cscope数据库再找标签文件；1先找标签文件再找cscope数据库
set cst                            " 同时搜索cscope数据库和标签文件
set cscopequickfix=s-,c-,d-,i-,t-,e-    " 使用QuickFix窗口来显示cscope查找结果
set nocsverb
if filereadable("cscope.out")    " 若当前目录下存在cscope数据库，添加该数据库到vim
    cs add cscope.out
elseif $CSCOPE_DB != ""            " 否则只要环境变量CSCOPE_DB不为空，则添加其指定的数据库到vim
    cs add $CSCOPE_DB
endif
set csverb
endif
map <F4> :cs add ./cscope.out .<CR><CR><CR> :cs reset<CR>
imap <F4> <ESC>:cs add ./cscope.out .<CR><CR><CR> :cs reset<CR>
" 将:cs find c等Cscope查找命令映射为<C-_>c等快捷键（按法是先按Ctrl+Shift+-, 然后很快再按下c）
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR> :copen<CR><CR>

" cscope find"的用法:
" cs find c|d|e|f|g|i|s|t name
" 0 或 s  查找这个 C 符号(可以跳过注释)
" 1 或 g  查找这个定义
" 2 或 d  查找这个函数调用的函数
" 3 或 c  查找调用过这个函数的函数
" 4 或 t  查找这个字符串
" 6 或 e  查找这个 egrep 模式
" 7 或 f  查找这个文件
" 8 或 i  查找包含这个文件的文件
" <<<<<<<<<< <<<<<<<<<<

" >>
" 营造专注气氛

" 禁止光标闪烁
set gcr=a:block-blinkon0

" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFullscreen()
call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf
" 全屏开/关快捷键
map <silent> <F11> :call ToggleFullscreen()<CR>
"" 启动 vim 时自动全屏
"autocmd VimEnter * call ToggleFullscreen()
"
" <<

" >>
" 辅助信息

" 总是显示状态栏
set laststatus=2

" 显示光标当前位置
set ruler

" 开启行号显示
set number

" 高亮显示当前行/列
"set cursorline
"set cursorcolumn

" 高亮显示搜索结果
set hlsearch

" <<

" >>
" 其他美化

" 设置 gvim 显示字体
set guifont=YaHei\ Consolas\ Hybrid\ 10.5

" <<

" >>
" 语法分析

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" <<

" >>
" 缩进

" 自适应不同语言的智能缩进
filetype indent on

" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" <<

" >>
" 代码折叠

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" <<


" >>
" 代码导航

" 正向遍历同名标签
nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
nmap <Leader>tp :tprevious<CR>

" <<


" >>
" 内容替换

" 精准替换
" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
wa
let flag = ''
if a:confirm
    let flag .= 'gec'
else
    let flag .= 'ge'
endif
let search = ''
if a:wholeword
    let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
else
    let search .= expand('<cword>')
endif
let replace = escape(a:replace, '/\&~')
execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 不确认、整词
nnoremap <Leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>

" <<



" >>
" 库信息参考

" 启用:Man命令查看各类man信息
source $VIMRUNTIME/ftplugin/man.vim

" 定义:Man命令查看各类man信息的快捷键
nmap <Leader>man :Man 3 <cword><CR>

" <<

" >>
" 环境恢复

" 设置环境保存项
set sessionoptions="blank,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"

" 保存 undo 历史。必须先行创建 .undo_history/
set undodir=~/.undo_history/
set undofile

" 保存快捷键
"map <leader>ss :mksession! my.vim<cr> :wviminfo! my.viminfo<cr>
map <leader>ss :mksession! my.vim<cr>

" 恢复快捷键
"map <leader>rs :source my.vim<cr> :rviminfo my.viminfo<cr>
map <leader>rs :source my.vim<cr>

" <<
 
" 设置快捷键实现一键编译及运行
"nmap <Leader>m :wa<CR> :cd build/<CR> :!rm -rf main<CR> :!cmake CMakeLists.txt<CR>:make<CR><CR> :cw<CR> :cd ..<CR>
"nmap <Leader>g :wa<CR>:cd build/<CR>:!rm -rf main<CR>:!cmake CMakeLists.txt<CR>:make<CR><CR>:cw<CR>:cd ..<CR>:!build/main<CR>

" Golang
autocmd BufWritePre *.go :Fmt


" ale-setting <<
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"打开文件时不进行检查
let g:ale_lint_on_enter = 0

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
nmap <Leader>f :ALEFix<CR>
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\   'csh': ['shell'],
\   'go': ['gofmt', 'golint', 'go vet'],
\   'help': [],
\   'perl': ['perlcritic'],
\   'python': ['flake8', 'mypy', 'pylint'],
\   'rust': ['cargo'],
\   'spec': [],
\   'text': [],
\   'zsh': ['shell'],
\   'reStructuredText': ['rstcheck']
\}

let g:ale_fixers = {
            \'python': ['remove_trailing_lines', 'trim_whitespace', 'autopep8']
            \}
" >>>

" >>> Visual-Mark
" 
" 安装 visualmark.vim 后，如果是在 Ubuntu 下做标记，会报一个“E197 不能设定语言为
" "en_US""的错误，但是在 Windows 下却不会。在网上找了一下，发现修复方法。
" 只要将exec ":lan mes en_US" 修改为 exec ":lan POSIX" 即可，为了能够在两个系统
" 中都能使用，于是修改了一下 visualmark.vim 源码，就是在 exec 外加了一个判断系统
" 的语句。本来还想直接上传一份供大家下载使用，才发现 Iteye 居然只能上传图像....
" 这里就提供具体修改方法：
" 使用文本编辑器打开 visualmark.vim
" 定位到
" exec ":lan mes en_US"
" 修改为
" if has("win32") || has("win95") || has("win64") || has("win16")
"    exec ":lan mes en_US"
" else
"    exec ":lan POSIX"
" endif
" 保存即可。
"
" >>>>
"
" >>>> Rainbow Parentheses 多彩括号
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

" 始终打开 Rainbow Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" 手动打开命令
" :RainbowParenthesesToggle       " Toggle it on/off
" :RainbowParenthesesLoadRound    " (), the default when toggling
" :RainbowParenthesesLoadSquare   " []
" :RainbowParenthesesLoadBraces   " {}
" :RainbowParenthesesLoadChevrons " <>

" >>>>>

" <<<<<
" DoxygenToolkit
" 最常用的操作命令:
" cc 单行注释   注释方式//
" cm 对选中的范围多行注释  注释方式为 /* ... */
" cs 以"性感"的方式注释
" cu 取消注释
" ca 切换// 与/**/注释方式   这个只是切换, 并不注释
"let g:load_doxygen_syntax = 1 " 设置VIM对doxygen进行语法高亮
let g:DoxygenToolKit_startCommentBlock = "/** "
let g:DoxygenToolKit_interCommentBlock = " */"
let NERDSpaceDelims = 1           " 让注释符与语句之间留一个空格
let NERDCompactSexyComs = 1       " 多行注释时样子更好看
let g:NERDDefaultAlign = 'left'  "将行注释符左对齐
let g:DoxygenToolkit_authorName = "Ma Yaning, <mayaning4coding@163.com>"
let g:DoxygenToolkit_companyName = "Ma Yaning"
let g:DoxygenToolkit_undocTag = "DOXIGEN_SKIP_BLOCK"
let g:DoxygenToolkit_briefTag_pre = "@Brief\t"
let g:DoxygenToolkit_paramTag_pre = "@Param\t"
let g:DoxygenToolkit_returnTag = "@Returns\t"
let g:DoxygenToolkit_briefTag_funcName = "yes"    "是否在注释中自动包含函数名称
let g:DoxygenToolkit_maxFunctionProtoLines = 30
let g:doxygen_enhanced_color = 1
let g:DoxygenToolkit_blockHeader = "*******************************************************"
let g:DoxygenToolkit_blockFooter = "*******************************************************"
let g:DoxygenToolkit_versionString = "0.1"

" License声明
let s:licenseTag = "*******************************************************" . "\<enter>"
let s:licenseTag = s:licenseTag . "Copyright "
let s:licenseTag = s:licenseTag . "2021 - " . strftime("%Y")
let s:licenseTag = s:licenseTag . " " . g:DoxygenToolkit_companyName . "\<enter>"
let s:licenseTag = s:licenseTag . "Licensed under the Apache License, Version 2.0 (the \"License\");" . "\<enter>"
let s:licenseTag = s:licenseTag . "you may not use this file except in compliance with the License." . "\<enter>"
let s:licenseTag = s:licenseTag . "You may obtain a copy of the License at" . "\<enter>"
let s:licenseTag = s:licenseTag . "\<enter>"
let s:licenseTag = s:licenseTag . "    http://www.apache.org/licenses/LICENSE-2.0" . "\<enter>"
let s:licenseTag = s:licenseTag . "\<enter>"
let s:licenseTag = s:licenseTag . "Unless required by applicable law or agreed to in writing, software" . "\<enter>"
let s:licenseTag = s:licenseTag . "distributed under the License is distributed on an \"AS IS\" BASIS," . "\<enter>"
let s:licenseTag = s:licenseTag . "WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied." . "\<enter>"
let s:licenseTag = s:licenseTag . "See the License for the specific language governing permissions and" . "\<enter>"
let s:licenseTag = s:licenseTag . "limitations under the License." . "\<enter>"
let s:licenseTag = s:licenseTag . "*******************************************************"
let g:DoxygenToolkit_licenseTag=s:licenseTag

vmap <C-S-P>    dO#endif<Esc>PO#if 0<Esc>
map dox <Esc>:Dox<cr>
map doxa <Esc>:DoxAuthor<cr>
map doxl <Esc>:DoxLic<cr>
map doxb :DoxBlock<CR>
map doxc odocClass<C-B>
map doxm odocMember<C-B>

" >>>>>
"
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
"# PlantUML 配置
"# 使用说明：
"# <leader>pv 生成样图
"# <leader>pu 更新样图
"# <leader>lv 生成样图
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
" Custom plantuml.jar file path
let g:plantuml_previewer#plantuml_jar_path = 
            \ '/home/mayaning/Apps/plantuml/plantuml-1.2021.13.jar'
" :PlantumlSave default format
let g:plantuml_previewer#save_format = 'png'
" Custom plantuml viewer path
" The plugin will copy viewer to here if the directory does not exist
" And tmp.puml and tmp.svg will output to here
let g:plantuml_previewer#viewer_path = '/tmp/vim-plantuml-preview'

map <leader>pv :PlantumlOpen<CR>
map <leader>pu :PlantumlStart<CR>
map <leader>ps :PlantumlSave<CR>
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
"
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
"# Open-Browser设置
"# 使用说明：
"# 1. 正常模式下光标移动到url上输入 gx 即可打开网址，光标移动到词组上可用设置的
"#    引擎搜索改词组； 
"# 2 .可视模式下输入 gx 即可搜索选中的内容；
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
let g:netrw_nogx = 1 " disable netrw's gx mapping.
"  正常模式下光标移动到url上输入 gx 即可打开网址，光标移动到词组上可用设置的引擎
"  搜索改词组； 
nmap gx <Plug>(openbrowser-smart-search)
" 可视模式下输入 gx 即可搜索选中的内容；
vmap gx <Plug>(openbrowser-smart-search)
" 搜索引擎配置
let g:openbrowser_default_search = 'baidu'
let g:openbrowser_search_engines = {
\  'baidu': 'http://www.baidu.com/s?wd={query}&rsv_bp=0&rsv_spt=3&inputT=2478',
\}
"# ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
