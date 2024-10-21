#/bin/bash

set -eu

mkdir -p work public

PATH_LIST_FILE="lists-family.txt"

PATH_URLS_TEMP="work/url.list.txt"
PATH_URLS_RAW="work/lists-family.txt"
PATH_URLS_FINAL="public/list-family.txt"

if [ ! -f "$PATH_URLS_RAW" ]; then
  echo "generate $PATH_URLS_RAW"
  while IFS= read -r url
  do
    wget "$url" -O "$PATH_URLS_TEMP"
    cat "$PATH_URLS_TEMP" >> "$PATH_URLS_RAW"
  done < "$PATH_LIST_FILE"
fi

if [ ! -f "$PATH_URLS_FINAL" ]; then
  echo "sort $PATH_URLS_FINAL"
  sort -u "$PATH_URLS_RAW" > "$PATH_URLS_FINAL"
  echo "clean $PATH_URLS_FINAL"
  sed -i '/^#/d' "$PATH_URLS_FINAL"
fi
