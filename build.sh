#!/bin/bash
shopt -s nullglob

# Collect the input files.
files=("src/index.typ")
for infile in src/writing/*.typ; do
    files+=("$infile")
done

# Create the dist/ folder if not present.
mkdir -p dist/writing

cp src/*.css dist/
cp src/*.otf dist/
cp src/*.ttf dist/

for path in "${files[@]}"; do
    # Strip the leading src/.
    file="${path/src\//}"
    # Remove the file extension.
    base="${file%.*}"
    # Format the output path.
    outfile="dist/${base}.html"
    echo "Compiling $path -> $outfile..."
    # Compile the file.
    ./typst compile --features html --format html --root src/ "$path" "$outfile"
done