#!/bin/bash

source "$FUSO_HOME/lib/util.sh"

# text(key, ...)
# --------------
# Returns a string based on the chosen locale. Returns [key] unchanged if the
# translation is not found in the file. Simple substitutions (e.g., %s, %d) are
# supported.
text() {
  local lang="$FUSO_LANGUAGE"
  local file="$FUSO_HOME/text/$lang.lng"

  local message="$1"
  local arguments=("$@")

  if [[ -f "$file" ]]; then
    local fetch="$(grep "^$message=" "$file" | head -n1)"
    [[ -z "$fetch" ]] || message="${fetch#*=}"
  fi

  printf "$message" ${arguments[@]:1}
}

# visu(string)
# ------------
# Returns the NUMBER of characters outside the PUA range.
visu() {
  local string="$1"
  local number=0
  local count

  while IFS= read -r -n1 count; do
    case "$count" in
      [$'\uE000'-$'\uF8FF']) ((number+=0)) ;;
      *) ((number+=1)) ;;
    esac
  done < <(printf "%s" "$string")

  printf '%d\n' "$number"
}
