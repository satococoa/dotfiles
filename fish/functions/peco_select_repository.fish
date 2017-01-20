function peco_select_repository
  if test (count $argv) = 0
    set peco_flags --layout=bottom-up
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  ghq list --full-path|peco $peco_flags|read foo

  if [ $foo ]
    cd $foo
    commandline -f repaint
    emit fish_prompt
  else
    commandline ''
  end
end
