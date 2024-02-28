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


function fix-tex-accents {
    if [[ $# -ne 1 ]]; then
        echo "Usage: fix-tex-accents <file.tex>"
        return 1
    fi

    local file="$1"
    local temp_file="${file}.tmp"

    # Replace accented characters
    sed -e 's/\\'\''a/á/g' \
        -e 's/\\'\''e/é/g' \
        -e 's/\\'\''i/í/g' \
        -e 's/\\'\''o/ó/g' \
        -e 's/\\'\''u/ú/g' \
        "$file" > "$temp_file"

    # Overwrite the original file with the modified content
    mv "$temp_file" "$file"

    echo "Accents replaced successfully."
}
