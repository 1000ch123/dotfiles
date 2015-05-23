# ------------------------------
# 外部リソース
# ------------------------------
#source ~/programming/shellScript/myscript/*.sh
#source ~/programming/openNI2/OpenNI-MacOSX-x64-2.2/OpenNIDevEnvironment


# ------------------------------
# settings
# ------------------------------
export PATH=.:/usr/local/bin:$PATH # brew で installしたプログラムを利用する

export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

bindkey -e               # キーバインドをemacsモードに設定
#bindkey -v              # キーバインドをviモードに設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
#setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }

# arduinoパス設定
#export ARDUINO_DIR = /Applications/Arduino.app/Contents/Resources/Java
#export ARDMK_DIR = /usr/local


# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors

# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
# tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
#  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
#RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

autoload -U colors; colors


function rprompt-git-current-branch {
        local name st color

        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi
        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=${fg[green]}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=${fg[yellow]}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=${fg_bold[red]}
        else
                color=${fg[red]}
        fi

        # %{...%} は囲まれた文字列がエスケープシーケンスであることを明示する
        # これをしないと右プロンプトの位置がずれる
        echo "%{$color%}$name%{$reset_color%} "
}


setopt prompt_subst
RPROMPT='[`rprompt-git-current-branch`%~]'


# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

### Title (user@hostname) ###
case "${TERM}" in
kterm*|xterm*|)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;
esac

############
# self settings
############

### node設定
#[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
#nvm use default
#npm_dir=${NVM_PATH}_modules
#export NODE_PATH=$npm_dir
#export PATH=$PATH:$NODE_PATH
#nvm use v0.10.26

# nodebrew設定
export PATH=$HOME/.nodebrew/current/bin:$PATH

### python:virtualenv
# source /usr/local/bin/virtualenvwrapper.sh
# export PYTHONPATH=/usr/local/Cellar/pyqt/4.10.3/lib/python2.7/site-packages:/usr/local/Cellar/sip/4.15.3/lib/python2.7/site-packages:$PYTHONPATH

### haskell
### cabal用パス設定
export PATH=/Users/masa/Library/Haskell/bin:$PATH

### python:django-admin
export PATH=/Users/masa/.virtualenvs/py2/lib/python2.7/site-packages/django/bin:$PATH

### pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

### ruby設定
eval "$(rbenv init -)"

### phpのバージョン決定
export PATH=/usr/local/Cellar/php54/5.4.20/bin:$PATH

### boostのpath
#export CPLUS_INCLUDE_PATH=/usr/local/Cellar/boost/1.55.0/include:$CPLUS_INCLUDE_PATH

### z.sh利用
#. `brew --prefix`/etc/profile.d/z.sh

### for latex
export BSTINPUTS=/usr/local/texlive/2013/texmf-dist/pbibtex/bst:$BSTINPUTS


#############
# functions #
#############

function cdls(){
  \cd $1;
  ls;
}

function git(){
  hub "$@"
}

#alias

alias zshconfig="vim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias -s py=python
alias gi=git
alias op=open
alias ll="ls -la"
alias cd=cdls
alias chrome="open -a /Applications/Google\ Chrome.app"
alias rm=rmtrash
alias rmswp="rm ~/.vim/swp/*.swp"

alias memo="makeMemo"
alias memols="ls ~/Dropbox/memo"
alias vim=/usr/local/bin/vim



### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### fuck
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'

