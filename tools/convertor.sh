#!/bin/bash

INPUT_DIR="$1"
OUTPUT_DIR="$2"
NAV_FILE="$OUTPUT_DIR/.nav.yml"
BASE_URL="$3"
BASE_URL="${BASE_URL%/}"  # Trim trailing slash


if [[ -z "$INPUT_DIR" || -z "$OUTPUT_DIR" ]]; then
  echo "❌ Usage: $0 <input_dir> <output_dir>"
  exit 1
fi

if [[ ! -d "$INPUT_DIR" ]]; then
  echo "❌ Error: Input directory '$INPUT_DIR' does not exist."
  exit 1
fi

if [[ $BASE_URL == "" ]]; then
  echo "❌ Error: 'BASE_URL' is required."
  exit 1
fi

slugify() {
  echo "$1" | iconv -t ascii//TRANSLIT | \
    tr '[:upper:]' '[:lower:]' | \
    sed -E 's/[^a-z0-9]+/-/g' | \
    sed -E 's/^-+|-+$//g'
}


cd ${PWD}
mkdir -p "$OUTPUT_DIR"
INPUT_DIR="$(realpath "$INPUT_DIR")"
OUTPUT_DIR="$(realpath "$OUTPUT_DIR")"
NAV_FILE="$OUTPUT_DIR/.nav.yml"

> "$NAV_FILE"

  SYMLINKS_DIR_NAME="urlmaps"
  SYMLINKS="${OUTPUT_DIR%/}/$SYMLINKS_DIR_NAME"
  echo "Symlinks folder: ${SYMLINKS}"

  # Ensure symblinks folder exists
  if [[ ! -d "${SYMLINKS}" ]]; then
    mkdir -p "${SYMLINKS}"
  fi


declare -A page_titles
declare -A section_menus
declare -A url_map



generate_symlinks() {
  local dir="$1"
  local rel_dir=$(realpath "$dir")

  # Skip folders
  [[ "$(basename "$dir")" == "images" ]] && return
  [[ "$(basename "$dir")" == "$SYMLINKS_DIR_NAME" ]] && return

  for file in "$dir"/*; do
    if [[ -d "$file" ]]; then
      generate_symlinks "$file"
    elif [[ "$file" == *.md ]]; then
      local filename=$(basename "$file")
      [[ "$filename" == "index.md" || "$filename" == "README.md" ]] && continue
      [[ -d "${file%.md}" ]] && continue  # Skip if there's a matching folder

      # Read title and slug from file frontmatter
      frontmatter=$(awk '/^---/ {if (!found) {found=1; next} else {exit}} found' "$file")
      title=$(echo "$frontmatter" | grep -m 1 '^title:' | cut -d':' -f2- | sed 's/^ *//' | sed 's/^["'\'']//;s/["'\'']$//')
      slug=$(echo "$frontmatter" | grep -m 1 '^slug:' | cut -d':' -f2- | sed 's/^ *//')

      [[ -z "$slug" ]] && slug=$(slugify "$title")

      # Construct folder path with slugs from .nav.yaml
      # Start from the folder of the file
      folder=$(dirname "$file")
      slugs=()

      # Traverse up to OUTPUT_DIR
      while [[ "$(realpath "$folder")" != "$OUTPUT_DIR" && "$folder" != "/" && "$folder" != "." ]]; do
      echo "examine folder: $folder"
        nav_file="$folder/.nav.yaml"
        part=""
        if [[ -f "$nav_file" ]]; then
          part=$(awk -F':' '/^slug:/ {gsub(/^[ \t]+/, "", $2); print $2}' "$nav_file")
        fi
        [[ -z "$part" ]] && part=$(basename "$folder")
        slugs=("$part" "${slugs[@]}")
        folder=$(dirname "$folder")
      done

      # Final full path
      structured_path=$(IFS=/; echo "${slugs[*]}/$slug")

# echo "📄 Processing: $file"
# echo "  → title: $title"
# echo "  → slug: $slug"
# echo "  → structured_path: $structured_path"

      # Write to map
      if [[ -n "$slug" ]]; then
        echo "$slug:$structured_path" >> "$SYMLINKS/urlmaps.conf"
        url_map["$slug"]="$BASE_URL/$structured_path"
      else
        echo "⚠️ Warning: empty slug for $file — skipping"
      fi
    fi
  done
}


rewrite_relative_links() {
  local file="$1"
  
  # Build a single sed command for all replacements
  local sed_cmd=""
  for slug in "${!url_map[@]}"; do
    path="${url_map[$slug]}"
    # Escape special characters for sed
    esc_slug=$(printf '%s' "$slug" | sed 's/[.[\*^$/]/\\&/g')
    esc_path=$(printf '%s' "$path" | sed 's/[&/\]/\\&/g')
    sed_cmd+=$'\ns|](\./'"$esc_slug"')|](/'"$esc_path"'/)|g'
  done

  # Apply all replacements in one sed pass
  sed "$sed_cmd" "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
}


# Step 1: Parse all .yaml files for section and page metadata
echo "Step 1: Parse all .yaml files for section and page metadata"
while IFS= read -r yaml_path; do
  dir_path=$(dirname "$yaml_path")
  file_base=$(basename "$yaml_path" .yaml)
  matching_md="$dir_path/$file_base.md"
  matching_dir="$dir_path/$file_base"

  rel_key=$(realpath --relative-to="$INPUT_DIR" "$yaml_path")
  rel_key="${rel_key%.yaml}.md"

  # Section metadata
  if [[ -d "$matching_dir" ]]; then
    rel_dir=$(realpath --relative-to="$INPUT_DIR" "$matching_dir")
    menu=$(grep '^menu:' "$yaml_path" | cut -d':' -f2- | sed 's/^ *//')
    [[ -n "$menu" ]] && section_menus["$rel_dir"]="$menu"
  fi

  # Page metadata
  if [[ -f "$matching_md" ]]; then
    title=$(grep '^title:' "$yaml_path" | cut -d':' -f2- | sed 's/^ *//')
    [[ -n "$title" ]] && page_titles["$rel_key"]="$title"
  fi
done < <(find "$INPUT_DIR" -type f -name "*.yaml")


# Step 2: Convert .yaml + .md into a .md with frontmatter
echo "# Step 2: Convert .yaml + .md into output .md with frontmatter"
while IFS= read -r yaml; do
  base="${yaml%.yaml}"
  md="${base}.md"
  rel_path=$(realpath --relative-to="$INPUT_DIR" "$base")
  folder_rel=$(dirname "$rel_path")
  file_base=$(basename "$md" .md)

  #[[ "$folder_rel" == "." ]] && continue
  [[ "$folder_rel" == "images" ]] && continue
  [[ ! -f "$md" ]] && { echo "⚠️ Skipping: No .md found for $yaml"; continue; }

  # 🧠 Check for X.md + X/ → move X.md → X/index.md
  folder_match="$(dirname "$md")/$file_base"
  if [[ -d "$folder_match" && "$(basename "$yaml")" == "$file_base.yaml" ]]; then
    #echo "📁 Found section-level file: rewriting $rel_path.md → $rel_path/index.md"
    out_md="$OUTPUT_DIR/$rel_path/index.md"
    rel_path="$rel_path/index"
    out_dir=$(dirname "$out_md")
  else 
    out_md="$OUTPUT_DIR/${rel_path}.md"
  fi

  out_dir=$(dirname "$out_md")
  mkdir -p "$out_dir"

  meta=$(sed 's/^abstract:/description:/' "$yaml")
  # title=$(grep -m 1 '^title:' "$yaml" | cut -d':' -f2- | sed 's/^ *//')
  title=$(grep -m 1 '^title:' "$yaml" | cut -d':' -f2- | sed 's/^ *//' | sed 's/^["'\'']\|["'\'']$//g')

    slug=$(slugify "$title")

    # Determine depth of the .md file
    depth=$(grep -o "/" <<< "$rel_path" | wc -l | tr -d ' ')

    # Build the correct prefix, like ../../images/
    img_prefix=$(printf '../%.0s' $(seq 1 $depth))"images"
    echo "Slug: $slug"

    {
        echo "---"
        echo "slug: $slug"
        echo "$meta"
        echo ""
        echo "---"
        cat "$md"
    }  | sed "s|\[:image:\([^]]*\)\]|\![](${img_prefix}/\1)|g" | sed "s|\[:image-popup:\([^]]*\)\]|\![](${img_prefix}/\1)|g" > "$out_md" 

    # Fix mkdocs ipv6 issue
    #if [[ "$rel_path" == "developer-guide/0_introduction/2_authentication" ]]; then
    sed -i 's|http://localhost:\[3636-3666\]|`http://localhost:[3636-3666]`|g' "$out_md"      
    sed -i '/^tags:/,/^[[:space:]]*$/{/^[[:space:]]*$/!d;}' "$out_md"
    #sed -i '/^tags:/{n; :a; s/^[[:space:]]\+[^[:space:]]/  - &/g; n; /^[[:space:]]*[^[:space:]]/!ba;}' "$out_md"
    sed -i '/^icon:/d' "$out_md"
    #sed -i '/^###### Auto generated by Pydio Cells Enterprise Distribution/d' "$out_md"
sed -i '/^###### Auto generated by Pydio Cells Enterprise Distribution/{s/^###### //; i\
---
}'  "$out_md"
    sed -i '/<div style="background-color: #fbe9b7;font-size: 14px;">/,/<\/div>/d' "$out_md"
    #fi
    echo "processing file $out_md: done"

#done < <(find "$INPUT_DIR" -type f -name "*.yaml" | grep -vE "^$INPUT_DIR/[^/]+\.yaml$" | sort)
done < <(find "$INPUT_DIR" -type f -name "*.yaml" | sort)


# Step 3: Copying matched section-level .yaml files as .nav.yaml into $OUTPUT ..."
echo "📋 Copying matched section-level .yaml files as .nav.yaml into $OUTPUT ..."
find "$INPUT_DIR" -maxdepth 5 -type f -name "*.yaml" | while read -r yaml_path; do
  base_name=$(basename "$yaml_path" .yaml)
  dir_path=$(dirname "$yaml_path")
  folder_path="$dir_path/$base_name"

  if [[ -d "$folder_path" ]]; then
    rel_folder=$(realpath --relative-to="$INPUT_DIR" "$folder_path")
    target_folder="$OUTPUT_DIR/$rel_folder"
    mkdir -p "$target_folder"

    index_md="$target_folder/index.md"
    if [[ -f "$index_md" ]]; then      
      title=$(grep -m 1 '^title:' "$index_md" | cut -d':' -f2- | sed 's/^ *//' | sed -E 's/^["'\''"]+|["'\''"]+$//g')
      if [[ -n "$title" ]]; then
        slug=$(echo "$title" | iconv -t ascii//TRANSLIT | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g')
      else
        slug=$(echo "$base_name" | iconv -t ascii//TRANSLIT | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g')
      fi
    else
      slug=$(echo "$base_name" | iconv -t ascii//TRANSLIT | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g')
    fi

  slug=$(echo "$slug" | sed -E 's/^[0-9]+-//')

    # Copy and append slug field
    {
      cat "$yaml_path"
      echo ""
      echo "slug: $slug"
    } > "$target_folder/.nav.yaml"

    #echo "✅ Copied $yaml_path → $target_folder/.nav.yaml with slug: $slug"
  fi
done



# Step 4: Copying matched section-level .md files to index.md"
echo "📋 Copying matched section-level .md to index.md"
find "$INPUT_DIR" -maxdepth 5 -type f -name "*.md" | while read -r md_path; do
  base_name=$(basename "$md_path" .md)
  dir_path=$(dirname "$md_path")
  folder_path="$dir_path/$base_name"

  if [[ -d "$folder_path" ]]; then
    rel_folder=$(realpath --relative-to="$INPUT_DIR" "$folder_path")
    target_folder="$OUTPUT_DIR/$rel_folder"
    mkdir -p "$target_folder"

    index_md="$target_folder/index.md"
    # Copy and append slug field
    cat "$md_path"  > "$target_folder/index.md"
sed -i '/^###### Auto generated by Pydio Cells Enterprise Distribution/{s/^###### //; i\
---
}' "$target_folder/index.md"
    #sed -i '/^###### Auto generated by Pydio Cells Enterprise Distribution/{s/^###### //; i\---}' "$target_folder/index.md"
    #sed -i '/^###### Auto generated by Pydio Cells Enterprise Distribution.*/d' "$target_folder/index.md"
    echo "✅ Copied $md_path → $target_folder/.nav.yaml with slug: $slug"
  fi
done


# Step 5: Generate url maps
echo "Step 5: Generate url maps"
generate_symlinks ${OUTPUT_DIR}

# Walk through all .md files
# echo "Walk through all .md files on $OUTPUT_DIR"
# find "$OUTPUT_DIR" -type f -name "*.md" | while read -r md; do
#   echo "examine file: $md"
#   rewrite_relative_links "$md"
# done


export -f rewrite_relative_links

echo "Walk through all .md files on $OUTPUT_DIR"
find "$OUTPUT_DIR" -type f -name "*.md" | \
  xargs -P 4 -n 1 -I {} bash -c 'echo "examine file: {}"; rewrite_relative_links "$@"' _ {}



# Step 5: Copy images/ folder
echo "Step 5: Copy images/ folder"
if [[ -d "$INPUT_DIR/images" ]]; then
  echo "📦 Copying images/ to output directory..."
  cp -r "$INPUT_DIR/images" "$OUTPUT_DIR/"
fi

# echo "✅ Conversion complete."
# echo "📄 Navigation saved to: $NAV_FILE"

# TODO
# - tags in frontmatter
# - icon in frontmatter
# - absolute link in articles