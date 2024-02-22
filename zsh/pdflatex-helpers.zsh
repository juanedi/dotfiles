function cleantex {
    if [[ -z "$1" ]]; then
        echo "Usage: cleantex <tex_file_basename>"
        return 1
    fi
    filename=$(basename "$2" .tex)
    rm -f "$1".aux "$1".log "$1".nav "$1".out "$1".snm "$1".toc "$1".vrb
}

function mktex {
    # Check if argument is provided
    if [[ -z "$1" ]]; then
        echo "Usage: mktex <relative_path_to_tex_file> [--pub]"
        return 1
    fi

    # Check if --pub flag is present
    if [[ "$2" == "--pub" ]]; then
        if [[ -z "$1" ]]; then
            echo "Usage: mktex <relative_path_to_tex_file> [--pub]"
            return 1
        fi
        filename=$(basename "$1" .tex)
        pdflatex --interaction nonstopmode --shell-escape --jobname="$filename"-pub "\def\pub{}\input{$1}" && cleantex "$filename"
    else
        filename=$(basename "$1" .tex)
        pdflatex --interaction nonstopmode --shell-escape --jobname="$filename" "$1" && cleantex "$filename"
    fi
}
