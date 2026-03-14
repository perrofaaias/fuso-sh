#!/bin/bash

FUSO_VERSION="1.0"
FUSO_LANGUAGE="pt"
FUSO_HOME="$HOME/HOME/fuso"

source "$FUSO_HOME/lib/text.sh"
source "$FUSO_HOME/lib/layt.sh"

container "$(text app.name)" "$(text app.version $FUSO_VERSION)" "$(text app.lang $FUSO_LANGUAGE)"
