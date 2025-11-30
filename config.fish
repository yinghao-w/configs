if status is-interactive
    # Commands to run in interactive sessions can go here
	fish_add_path ~/.local/bin

	set -g -x EDITOR nvim
	set -g -x MANPAGER "fish -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -l man'"

	abbr --add av source venv/bin/activate.fish
	abbr --add ncspot flatpak run io.github.hrkfdn.ncspot
	abbr --add todo todo.sh
	abbr --add ddg lynx duckduckgo.com
	abbr --add n nnn
	abbr --add gs git status
	abbr --add gl git log
	abbr --add glg git log --oneline --graph --decorate --all
	abbr --add gd git diff

	function c -a compiler
		set -g -x CC $compiler
	end

	set -g -x FZF_CTRL_T_OPTS "--preview 'bat --color=always --style=plain --line-range :500 {}'"
	source (status dirname)/fzf_key_bindings.fish
end
