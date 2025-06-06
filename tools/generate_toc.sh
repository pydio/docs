#!/bin/bash

DOCS_DIR="$1"
BASE_URL="$2"
BASE_URL="${BASE_URL%/}"  # Trim trailing slash

if [[ -z "$DOCS_DIR" || ! -d "$DOCS_DIR" ]]; then
  echo "❌ Usage: $0 <docs_dir>"
  exit 1
fi

slugify() {
  echo "$1" | iconv -t ascii//TRANSLIT | \
    tr '[:upper:]' '[:lower:]' | \
    sed -E 's/[^a-z0-9]+/-/g' | \
    sed -E 's/^-+|-+$//g'
}

generate_toc_for_folder() {
  local folder="$1"
  local toc=""

  for md in $(find "$folder" -maxdepth 1 -type f -name "*.md" | sort); do
    [[ ! -f "$md" ]] && continue
    [[ "$(basename "$md")" == "index.md" ]] && continue

    #title=$(grep -m 1 '^title:' "$md" | cut -d':' -f2- | sed 's/^ *//' || basename "$md" .md)
    title=$(grep -m 1 '^title:' "$md" | cut -d':' -f2- | sed 's/^ *//' | sed 's/^["'\'']\|["'\'']$//g')

    [[ -z "$title" ]] && title=$(basename "$md" .md)

    slug=$(grep -m 1 '^slug:' "$md" | cut -d':' -f2- | sed 's/^ *//')
    [[ -z "$slug" ]] && slug=$(slugify "$title")

    # Collect parent slugs from .nav.yaml up to DOCS_DIR
    slugs=()
    current="$folder"
    while [[ "$current" != "$DOCS_DIR" && "$current" != "." ]]; do
      nav_file="$current/.nav.yaml"
      part=$(basename "$current")
      if [[ -f "$nav_file" ]]; then
        nav_slug=$(grep -m 1 '^slug:' "$nav_file" | cut -d':' -f2- | sed 's/^ *//')
        [[ -n "$nav_slug" ]] && part="$nav_slug"
      fi
      slugs=("$part" "${slugs[@]}")
      current=$(dirname "$current")
    done

    # uri_path="/$(IFS=/; echo "${slugs[*]}")/$slug/"
    # toc+="- [$title]("/${BASE_URL}${uri_path}")\n"
    uri_path="../$slug/"
    toc+="- [$title]("${uri_path}")\n"

  done

  echo -e "$toc"
}

# Recursively find all index.md
find "$DOCS_DIR" -type f -name "index.md" | while read -r index_md; do
  if grep -q '\[:summary\]' "$index_md"; then
    folder=$(dirname "$index_md")
    toc_markdown=$(generate_toc_for_folder "$folder")
    #echo "📄 Updating TOC in $index_md"

    awk -v toc="$toc_markdown" '
      {
        if ($0 ~ /\[:summary\]/) {
          print toc
        } else {
          print
        }
      }
    ' "$index_md" > "$index_md.tmp" && mv "$index_md.tmp" "$index_md"
  fi
done

echo "✅ TOC inserted into all matching index.md files."
