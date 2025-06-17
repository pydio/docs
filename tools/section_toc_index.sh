#!/bin/bash

DOCS_DIR="${1:-docs}"
MAX_DEPTH="${2:-2}"

slugify() {
  echo "$1" | iconv -t ascii//TRANSLIT | \
    tr '[:upper:]' '[:lower:]' | \
    sed -E 's/[^a-z0-9]+/-/g' | \
    sed -E 's/^-+|-+$//g'
}

extract_slug_from_nav() {
  local dir="$1"
  local nav_file="$dir/.nav.yaml"
  if [[ -f "$nav_file" ]]; then
    grep -m1 '^slug:' "$nav_file" | cut -d':' -f2- | sed 's/^ *//' | sed 's/"//g'
  fi
}

extract_title_from_nav() {
  local dir="$1"
  local nav_file="$dir/.nav.yaml"
  if [[ -f "$nav_file" ]]; then
    grep -m1 '^title:' "$nav_file" | cut -d':' -f2- | sed 's/^ *//' | sed 's/"//g'
  fi
}

extract_slug_from_md() {
  local file="$1"
  grep -m1 '^slug:' "$file" | cut -d':' -f2- | sed 's/^ *//' | sed 's/"//g'
}

extract_title_from_md() {
  local file="$1"
  grep -m1 '^title:' "$file" | cut -d':' -f2- | sed 's/^ *//' | sed 's/"//g'
}

build_slug_path() {
  local path="$1"
  local slug_parts=()

  while [[ "$path" != "$DOCS_DIR" && "$path" != "." && "$path" != "/" ]]; do
    slug=$(extract_slug_from_nav "$path")
    [[ -z "$slug" ]] && slug=$(basename "$path")
    slug_parts=("$slug" "${slug_parts[@]}")
    path=$(dirname "$path")
  done

  IFS=/; echo "${slug_parts[*]}"
}

generate_toc() {
  local base_dir="$1"
  local rel_dir="$2"
  local depth="$3"
  local indent="$4"
  local toc=""

  [[ "$depth" -gt "$MAX_DEPTH" ]] && return

  for item in "$base_dir/$rel_dir"/*; do
    [[ "$(basename "$item")" =~ ^(images|urlmaps)$ ]] && continue

    if [[ -f "$item" && "$item" == *.md ]]; then
      [[ "$(basename "$item")" == "index.md" ]] && continue
      title=$(extract_title_from_md "$item")
      [[ -z "$title" ]] && title=$(basename "$item" .md)
      slug=$(extract_slug_from_md "$item")
      [[ -z "$slug" ]] && slug=$(basename "$item" .md)
      parent_slug_path=$(build_slug_path "$(dirname "$item")")
      relative_slug_path="${parent_slug_path#*/}"
      link="../${relative_slug_path}/${slug}"
      toc+="$(printf "\n%s* [%s](%s)\n" "$indent" "$title" "$link")"

    elif [[ -d "$item" ]]; then
      title=$(extract_title_from_nav "$item")
      [[ -z "$title" ]] && title=$(basename "$item")
      slug=$(extract_slug_from_nav "$item")
      [[ -z "$slug" ]] && slug=$(basename "$item")
      parent_slug_path=$(build_slug_path "$item")
      relative_folder_path="${parent_slug_path#*/}"
      folder_link="../${relative_folder_path}/index/"
      toc+="$(printf "\n%s* **[%s](%s)**\n" "$indent" "$title" "$folder_link")"
      toc+=$(generate_toc "$base_dir" "$(realpath --relative-to="$base_dir" "$item")" $((depth + 1)) "$indent  ")
    fi
  done

  echo "$toc"
}

generate_index() {
  local folder="$1"
  local index_file="$folder/index.md"

  if [[ ! -f "$index_file" ]]; then
    echo "ℹ️ Creating missing index.md in $folder"
    touch "$index_file"
  fi

  local title
  title=$(extract_title_from_nav "$folder")
  [[ -z "$title" ]] && title=$(basename "$folder")

  local toc
  toc=$(generate_toc "$folder" "." 1 "")

  {
    echo "---"
    echo "title: $title"
    echo "weight: 0"
    echo "---"
    echo
    echo "$toc"
  } > "$index_file.tmp" && mv "$index_file.tmp" "$index_file"

  echo "✅ TOC generated in: $index_file"
}

# Process 1st-level folders under DOCS_DIR
for folder in "$DOCS_DIR"/*; do
  [[ -d "$folder" ]] || continue
  [[ "$(basename "$folder")" =~ ^(images|urlmaps)$ ]] && continue

  generate_index "$folder"
done

echo "🎉 Recursive TOC generation completed (max depth: $MAX_DEPTH)"
