function ds_implementation --description "not intended to be called directly" -a opts file
	if ! test -e $file
		printf "cannot access '%s': No such file or directory\n" $file
		return
	else if test -d $file
		# if file is a directory, du and ls contents instead
		set -f file (path normalize $file/*) (path normalize $file/.*)
		# print directory total size
		set -f opts $opts -c
	else if test -f $file
		set -f file $file
	end

	set -f total_printed false
	set -f output (du -hs $opts $file | sort -hr | string collect | string split "\n")

	for row in $output
		# split the row string into a list
		set -f elements (string split (echo -e "\t") $row)

		if test $total_printed = false -a $elements[2] = "total"
			set_color magenta
			set -f total_printed true
		else if test -d $elements[2]
			set_color blue
		else if test -L $elements[2]
			set_color cyan
		else if test -x $elements[2]
			set_color green
		end

		printf "%s\t%s" $elements[1] (basename $elements[2])

		set_color normal

		# print potential suffix symbol, and newline
		# entry should match directory first since directories are also executable
		if test -d $elements[2]
			echo
		else if test -L $elements[2]
			echo "@"
		else if test -x $elements[2]
			echo "*"
		else
			echo
		end
	end
end

function ds --description "du and ls together"
	# parse options and arguments
	for word in $argv
		if test (string sub -e 1 -- "$word") = "-"
			set -f opts $opts $word
		else
			set -f args $args $word
		end
	end

	# add redundant default arguments so variables are non-empty
	if test -z "$opts"
		set -f opts "-hs"
	end
	if test -z "$args"
		set -f args "."
	end

	for arg in $args
		ds_implementation $opts $arg
	end
end
