# https://github.com/oh-my-fish/plugin-peco/blob/master/functions/peco_select_history.fish
function peco_select_history
	if test (count $argv) = 0
    set peco_flags --layout=bottom-up
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  history|peco $peco_flags|read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end
