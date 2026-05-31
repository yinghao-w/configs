#!/usr/bin/env fish

if test -n "$XDG_CONFIG_HOME"
	set -g config_dir $XDG_CONFIG_HOME
else
	set -g config_dir $HOME/.config
end

function make_link -a target location
	ln -sfn (realpath $target) $config_dir/$location
end

make_link tmux.conf tmux/tmux.conf
make_link vimrc vim/vimrc
make_link init.lua nvim/init.lua

make_link config.fish fish/config.fish
make_link fzf_key_bindings.fish fish/fzf_key_bindings.fish
make_link default_no_user.fish fish/functions/fish_prompt.fish
make_link ds.fish fish/functions/ds.fish
