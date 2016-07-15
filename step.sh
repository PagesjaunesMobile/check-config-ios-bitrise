#!/bin/bash

# fail if any commands fails
set -e

SCRIPT_DIR = "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$SCRIPT_DIR/libs/messages.sh"
source "$SCRIPT_DIR/libs/rules.sh"

values=$(xcodebuild -workspace $check_workspace -scheme $check_scheme -configuration $check_config -showBuildSettings | tail -n +2 | sed 's/^ *//;s/ *$//')

msg_info "Reading settings from $check_workspace, scheme $check_scheme, configuration $check_config"

source $check_rules_path
