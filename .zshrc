export LANG=ja_JP.UTF-8
export LANGUAGE="ja_JP:ja"
export LC_CTYPE=ja_JP.UTF-8
export LC_NUMERIC="ja_JP.UTF-8"
export LC_TIME=ja_JP.UTF-8
export LC_COLLATE=ja_JP.UTF-8
export LC_MONETARY="ja_JP.UTF-8"
export LC_MESSAGES=ja_JP.UTF-8
export LC_PAPER="ja_JP.UTF-8"
export LC_NAME=ja_JP.UTF-8
export LC_ADDRESS="ja_JP.UTF-8"
export LC_TELEPHONE="ja_JP.UTF-8"
export LC_MEASUREMENT=ja_JP.UTF-8
export LC_IDENTIFICATION=ja_JP.UTF-8
export DISPLAY=:0.0
export PATH="/home/linuxbrew/.linuxbrew/bin:`yarn global bin`:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

source ~/.zplug/init.zsh

zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
zplug "mollifier/anyframe"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "peco/peco"
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/composer", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/emacs", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/github", from:oh-my-zsh
zplug "plugins/man", from:oh-my-zsh
zplug "mollifier/zload"
zplug "chrissicool/zsh-256color"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

POWERLEVEL9K_MODE='nerdfont-complete'

export LESS="-RNS"
export LESSOPEN="| $HOME/src-hilite-lesspipe.sh %s"
export PAGER="less"
export EDITOR="emacsclient -n"
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=36:ln=32:bn=32:se=01;33"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
LISTMAX=10000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
bindkey "^/" undo
bindkey "^\\" redo
bindkey "^[^B" vi-backward-blank-word
bindkey "^[^F" vi-forward-blank-word
bindkey "^[^U" backward-delete-word
bindkey "^[^K" delete-word
bindkey "^I" menu-complete

zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-separator '-->'

zstyle ':mime:*' browser-style running x
zstyle ':mime:*' x-browsers

autoload -Uz zmv
zmodload zsh/parameter

setopt append_history       # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt always_last_prompt   # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt auto_list            # 補完候補が複数ある時に、一覧表示する
setopt auto_menu            # タブキー連打で補完候補を順に表示
setopt auto_param_keys      # カッコの対応などを自動的に補完
#setopt auto_param_slash        # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_pushd           # cd 時にOLDDIR を自動的にスタックに積む
setopt correct              # コマンドのスペルチェック
setopt complete_aliases     # エイリアスを設定したコマンドでも補完機能を使えるようにする
setopt complete_in_word     # 語の途中でもカーソル位置で補完
setopt extended_glob        # globを拡張する。
setopt extended_history     # 履歴ファイルに時刻を記録
setopt globdots             # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt hist_expand          # 補完時にヒストリを自動的に展開する。
setopt hist_ignore_all_dups # 重複するヒストリを持たない
setopt hist_ignore_dups     # 前のコマンドと同じならヒストリに入れない
setopt hist_ignore_space    # 空白ではじまるコマンドをヒストリに保持しない
setopt hist_no_store        # history コマンドをヒストリに入れない
setopt hist_reduce_blanks   # 履歴から冗長な空白を除く
setopt ignore_eof           # Ctrl-D でログアウトするのを抑制する。
setopt inc_append_history   # 履歴をインクリメンタルに追加
setopt list_packed          # 補完候補を詰めて表示する
setopt list_types           # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt magic_equal_subst    # = 以降でも補完できるようにする( --prefix=/usr 等の場合)
setopt mark_dirs            # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt no_clobber           # リダイレクトで上書きする事を許可しない。
setopt no_flow_control      # C-s, C-qを無効にする。
#setopt noautoremoveslash    # パスの最後に付くスラッシュを自動的に削除しない
setopt nolistbeep
setopt numeric_glob_sort    # 辞書順ではなく数値順でソート
setopt print_eight_bit      # 補完候補リストの日本語を正しく表示
setopt prompt_subst         # エスケープシーケンスを使う。
setopt pushd_ignore_dups    # ディレクトリスタックに、同じディレクトリを入れない
setopt rec_exact
setopt rmstar_wait          # rm * を実行する前に確認される。
setopt share_history        # 複数プロセスで履歴を共有
setopt bang_hist

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi


alias grep="grep --color=always"
alias fgrep="fgrep --color=always"
alias egrep="egrep --color=always"
alias zgrep="zgrep --color=always"
alias zmv="noglob zmv -W"
alias diff="colordiff --strip-trailing-cr"
alias sdiff="sdiff --strip-trailing-cr"
alias rg="rg -uu --color=always"

alias ls="lsd --color=always"
alias la="lsd -lah --color=always"
alias ltr="lsd -ltarh --color=always"
alias ll="lsd -lh --color=always"
alias sls="lsd -lahS --color=always"

alias rr="rm -rf"
alias rm="rm -i"
alias cp="cp -ip"
alias mv="mv -i"
alias mk="mkdir -p"

alias ssh='TERM=xterm-256color ssh'

alias dvp="tar xfzv"
alias cmp="tar cfzv"

alias em="emacs"
alias en="emacsclient -n"
alias ed="emacs --deamon"

alias hi="history -nir 0"

alias pd="cd -"
alias bd="cd .."
alias peco="peco --initial-filter migemo"

alias -g L="| less"
alias -g T="| tail"
alias -g G="| grep"
alias -g N="| nkf -w"
alias -g W="| wc -l"
alias -g H="| --help | less"
alias -g XG="| xrags grep"
alias -g P="| peco"

function ecmp () { tar czvf $1 --exclude $2 }
function tl () { tar czlf - $1 | tar tzvf - | less }
function jl () { less $1 | nkf -w | less }
#function jr () { nkf -w $1 | richpager }
function ff() { find $1 -name $2 -print }
function fxg() { find $1 -name $2 -print | xargs grep $3 }
function frm() { find $1 -name $2 -exec rm {} \; }
function hig() { history -nir 0 | grep $1 | less }
#function hi()  { history -E 1 } # 全履歴の一覧を出力する
function ft()  { find $1 -type f -ctime $2 | xargs lsd -ltrah --color=always | less }
function zls() { zcat $1 | tar tv | less }
function rcp() { find $1 -type d -name $2 -exec cp -r $3 {} \; }
function bcp() { find $1 -name $2 -exec cp '{}' '{}_bk' \; }
function mcp() { find $1 -name $2 | xargs rename $2 $3 }
function ediff () { emacsclient -n --eval "(ediff-files \"$1\" \"$2\")" }
function er () { emacsclient -n --eval "(find-file-read-only \"$1\")" }
function pe () { emacsclient -n $(pt "$@" | peco | awk -F : '{print "+" $2 " " $1}') }
function ae () { emacsclient -n $(ag "$@" | peco | awk -F : '{print "+" $2 " " $1}') }
function re () { emacsclient -n $(rg "$@" | peco | awk -F : '{print "+" $2 " " $1}') }
function cls() { emacsclient -n $(find ./ -maxdepth 1 -type f | sort | peco ) }
function ccd() { cd "$(find . -maxdepth 1 -type d | peco)" }
function pls() { jl "$(find . -maxdepth 1 -type f | peco)" }

function google () {
    xdg-open "https://www.google.co.jp/search?q=$1"
}

function rampass {

local LEVEL=$1

case $LEVEL in
 'l1' ) cat /dev/urandom | tr -dc '[:digit:]' | fold -w $2 | head -n 10;;
 'l2' ) cat /dev/urandom | tr -dc '[:alpha:]' | fold -w $2 | head -n 10;;
 'l3' ) cat /dev/urandom | tr -dc '[:alnum:]' | fold -w $2 | head -n 10;;
 'l4' ) cat /dev/urandom | tr -dc 'a-zA-Z0-9_!@#$%&?*+-=/\,.;:(){}[]|~^' | fold -w $2 | head -n 10;;
 'l5' ) cat /dev/urandom | tr -dc '[:graph:]' | fold -w $2 | head -n 10;;
 esac
}

function color256()
{
for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
}

function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^O' peco-select-history

#pecoでhistory検索
function peco-select-bd() {
  cd ..
}
zle -N peco-select-bd
bindkey '^U' peco-select-bd

#pecoでhistory検索
function peco-select-cd() {
  cd
}
zle -N peco-select-cd
bindkey '^T' peco-select-cd

#pecoでhistory検索
function peco-select-hd() {
  cd -
}
zle -N peco-select-hd
bindkey '^@' peco-select-hd

#pecoでkill
function peco-pkill() {
  for pid in `ps aux | peco | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
alias pk="peco-pkill"

function dired () {
#WPWD=`cygpath -am $PWD`
 emacsclient -e "(dired \"$PWD\")"
}

function cde () {
   EMACS_CWD=`emacsclient -e "
    (expand-file-name
     (with-current-buffer
         (nth 1
              (assoc 'buffer-list
                     (nth 1 (nth 1 (current-frame-configuration)))))
       default-directory))" | sed 's/^"\(.*\)"$/\1/'`

   echo "chdir to $EMACS_CWD"
   cd "$EMACS_CWD"
}

zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}
       [[  ${cmd} != (cd) && ${cmd} != (r[mr]) ]]
}

precmd() {
    if [ $TERM="screen" ]; then
       echo -ne "\ek$(basename $(pwd))\e\\"
    fi

    if [ $TERM="xterm-256color" ]; then
       #echo -ne "\ek$(basename $(pwd))\e\\"
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    fi
}
