#!/usr/bin/env fish

while read line
    # check if line starts with '*' and has 'path' and 'title' keywords
    set -l matches (string match -r -- '\-\s+\[(.*)\]\((.*)\)' -- $line)

    if test (count $matches) -gt 0
        set title $matches[2]
        set path $matches[3]

        # remove trailing newline from title
        set title (echo $title | sed 's/[\n\r]$//')

        # create directories based on the path
        set -l dirname (echo $path | sed 's#/[^/]*$##')
        mkdir -p "$dirname"

        # add .md extension to the path
        set filename $path.md

        echo "Title: $title"
        echo "Path: $path"
        echo "Filename: $filename"

        # create a new Markdown file with the extracted values
        echo "# $title" > "$filename"
        echo "" >> "$filename"
        echo "This is the $title page." >> "$filename"
        echo "" >> "$filename"
        echo "[Return to Table of Contents]($path)" >> "$filename"

        if test -n "$title"
            echo "Title: $title"
        else
            echo "Title not set."
        end
    else
        echo "Line does not match pattern: $line"
    end
end < _sidebar.md