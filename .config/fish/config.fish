# Todo List
# * Hit fish_config
# * Hit fish_update_completion

# timezone setting
set -g theme_date_timezone Asia/Tokyo

# XDG Base Directory Setting
# Use set -x (means "export") instead of export
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache

# path to homebrew
source $XDG_CONFIG_HOME/fish/library.fish
eval (eval (get_homebrew_executable) shellenv)

# path to coreutils, findutils and gnu-sed
set HOMEBREW_PREFIX (get_homebrew_prefix)
if [ -d $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin ];
  set -x PATH "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" "$PATH"
  set -x MANPATH "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman" "$MANPATH"
end

if [ -d $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin ];
  set -x PATH "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin" "$PATH"
  set -x MANPATH "$HOMEBREW_PREFIX/opt/findutils/libexec/gnuman" "$MANPATH"
end

if [ -d $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin ];
  set -x PATH "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" "$PATH"
  set -x MANPATH "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman" "$MANPATH"
end

# path to Xcode developer dir
set -x DEVELOPER_DIR /Applications/Xcode.app/Contents/Developer


# pipenv virtualenv location
set -x PIPENV_VENV_IN_PROJECT true
set -x PIPENV_IGNORE_VIRTUALENVS true

# path to dotfiles/bin
set -x PATH $HOME/dotfiles/bin $PATH

# path to nodebrew
if [ -d $HOME/.nodebrew/current/bin ];
  set -x PATH $HOME/.nodebrew/current/bin $PATH
end

# path to .net sdk
set -x PATH $PATH /usr/local/share/dotnet

# path to android sdk
set -x PATH $HOME/Library/Android/sdk/platform-tools $PATH

# path to flutter
set -x PATH $PATH $HOME/Applications/flutter/bin

# path to flutter version management(fvm)
set -x PATH $PATH $HOME/.pub-cache/bin

# make less avarable for colordiff
set -x LESS -R

# alias settings
## call .aliasrc
make -C $XDG_CONFIG_HOME/fish/functions/Bash2FishAliasesSync sync _B2F_BASHRC=$HOME/.aliasrc _B2F_ALIASES_FILE=$XDG_CONFIG_HOME/fish/b2f_aliasrc.fish; and source $XDG_CONFIG_HOME/fish/b2f_aliasrc.fish

## call .kokorc
if [ (whoami) = "Kokorin" ];
  make -C $XDG_CONFIG_HOME/fish/functions/Bash2FishAliasesSync sync _B2F_BASHRC=$HOME/.kokorc _B2F_ALIASES_FILE=$XDG_CONFIG_HOME/fish/b2f_kokorc.fish; and source $XDG_CONFIG_HOME/fish/b2f_kokorc.fish
end

## call .taiharc
if [ (whoami) = "taihara" -o (whoami) = "Aihara" -o (whoami) = "Kokorin" ];
  make -C $XDG_CONFIG_HOME/fish/functions/Bash2FishAliasesSync sync _B2F_BASHRC=$HOME/.taiharc _B2F_ALIASES_FILE=$XDG_CONFIG_HOME/fish/b2f_taiharc.fish; and source $XDG_CONFIG_HOME/fish/b2f_taiharc.fish
end

## alias for fish
alias relogin="exec $(get_homebrew_prefix)/bin/fish -l"

# abbreviation for cd to last directory
abbr --add --global - 'cd -'

# display welcome message
if type toilet &> /dev/null;
  toilet -f future WELCOME TO FISH
else if type figlet &> /dev/null;
  figlet -f smslant WELCOME TO FISH
end

# display todo list
type todo &> /dev/null; and todo ls --all
