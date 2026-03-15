#!/bin/bash

# maximum(a, b)
# -------------
# Returns the larger of two numbers.
maximum() {
  if [[ $1 -gt $2 ]]; then
    printf $1
  else
    printf $2
  fi
}
