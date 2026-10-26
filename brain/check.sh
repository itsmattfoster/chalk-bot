#!/usr/bin/env bash
# Guards the brain and the workspace layout. Prints OK, or lists violations and exits 1.
# Usage: bash brain/check.sh   (from anywhere; finds the workspace from its own location)
B="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; W="$(dirname "$B")"
v=()

# brain/: only the 5 files + check.sh + log/
allowed="CHARTER.md RULES.md NOW.md LESSONS.md INDEX.md check.sh log"
for f in "$B"/* "$B"/.[!.]*; do
  [ -e "$f" ] || continue; n=$(basename "$f")
  [[ " $allowed " == *" $n "* ]] || v+=("extra file in brain/: $n (put it in a brain file instead)")
done
for f in CHARTER.md RULES.md NOW.md LESSONS.md INDEX.md; do [ -f "$B/$f" ] || v+=("missing brain/$f"); done

# log/: only YYYY-MM-DD.md
if [ -d "$B/log" ]; then
  while IFS= read -r x; do v+=("log/ entry not YYYY-MM-DD.md: $x"); done < <(
    find "$B/log" -mindepth 1 ! -name .gitkeep -printf '%P\n' | grep -Ev '^[0-9]{4}-[0-9]{2}-[0-9]{2}\.md$')
fi

# size caps
r=$(wc -l < "$B/RULES.md" 2>/dev/null || echo 0); [ "$r" -gt 150 ] && v+=("RULES.md has $r lines (max 150, prune it)")
n=$(wc -l < "$B/NOW.md" 2>/dev/null || echo 0); [ "$n" -gt 60 ] && v+=("NOW.md has $n lines (max 60, rewrite it)")

# duplicate rules
while IFS= read -r d; do v+=("duplicate line in RULES.md: $d"); done < <(grep -v '^\s*$' "$B/RULES.md" 2>/dev/null | sort | uniq -d)

# top level: exactly brain work files tools archive + README.md (+ LICENSE, .git, .github, .gitignore)
top="brain work files tools archive README.md LICENSE .git .github .gitignore"
for f in "$W"/* "$W"/.[!.]*; do
  [ -e "$f" ] || continue; n=$(basename "$f")
  [[ " $top " == *" $n "* ]] || v+=("extra top-level item: $n (top level is brain/ work/ files/ tools/ archive/)")
done
for d in brain work files tools archive; do [ -d "$W/$d" ] || v+=("missing top-level folder: $d/"); done

# cryptic file names (IMG_1234, untitled, final2, copy, ...)
while IFS= read -r f; do v+=("cryptic file name (rename literally, kebab-case): ${f#$W/}"); done < <(
  find "$W/brain" "$W/work" "$W/files" "$W/tools" \( -name node_modules -o -name .git \) -prune -o -type f -regextype posix-extended \
  -iregex '.*/(img|dsc|dscn|pxl|mvi|vid)_?[0-9]+[^/]*|.*/untitled[^/]*|.*/[^/]*final[ _-]?[0-9]+[^/]*|.*/[^/]*([ _-]copy|copy[ _-]?[0-9]*|\([0-9]+\))(\.[^/]*)?|.*/(copy|new|misc|file|image|video|download)[ _-]?[0-9]*\.[^/]+' -print 2>/dev/null)

# drop zones: nothing may sit in files/uploads or files/downloads > 24h
while IFS= read -r f; do v+=("unsorted for >24h, file it per INDEX.md: ${f#$W/}"); done < <(
  find "$W/files/uploads" "$W/files/downloads" -mindepth 1 ! -name .gitkeep -mmin +1440 2>/dev/null)

if [ ${#v[@]} -eq 0 ]; then echo OK; else printf 'VIOLATIONS:\n'; printf ' - %s\n' "${v[@]}"; exit 1; fi
