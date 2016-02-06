if [ -d /usr/share/source-highlight ]; then
	export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
	export LESS=' -R '
fi
