function fish_prompt
	if test $status -eq 0
    set_color green
    printf '%s ' "☀"
  else
    set_color blue
    printf '%s ' "☂"
  end
end
