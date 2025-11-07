#!/bin/bash
# Usage:
#   ./build.sh (build|watch)?
shopt -s nullglob

MODE="$1"

# Collect the input files.
files=("src/index.typ")
for infile in src/writing/*.typ; do
    files+=("$infile")
done

# Create the dist/ folder if not present.
mkdir -p dist/writing

# Copy assets to dist/.
cleancss assets/index.css -o dist/index.css
cp assets/*.ttf dist/

# Keep track of the pids for watch mode and kill them when we exit.
pids=()
cleanup() {
    for pid in "${pids[@]}"; do
        kill "$pid" 2>/dev/null
    done
}
trap cleanup EXIT

# Compile all the source files.
for path in "${files[@]}"; do
    # Strip the leading src/.
    file="${path/src\//}"
    # Remove the file extension.
    base="${file%.*}"
    # Format the output path.
    outfile="dist/${base}.html"
    echo "Compiling $path -> $outfile..."
    # Compile the file.
    case "$MODE" in
        watch) 
            ./typst watch --features html --format html --root . "$path" "$outfile" &
            pids+=("$!")
            ;;
        build)
            echo "asd"
            ;&
        "")
            ./typst compile --features html --format html --root . "$path" "$outfile"
            ;;
        *)
            echo "Invalid mode."
            ;;
    esac
done
wait