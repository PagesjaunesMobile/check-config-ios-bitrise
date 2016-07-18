#!/bin/bash

# fail if any commands fails
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$SCRIPT_DIR/libs/messages.sh"
source "$SCRIPT_DIR/libs/rules.sh"

if [ ! -d "$check_workspace_path" ]; then
  msg_error "Workspace not found"
	exit 1
fi

if [ ! -f "$check_rules_path" ]; then
  msg_error "Rules not found"
	exit 1
fi

CONFIG="$check_config"

IFS='|' read -ra SCHEMES <<< "$check_schemes"
echo $check_schemes
for SCHEME in "${SCHEMES[@]}"; do
  
  msg_info "Reading settings from $check_workspace_path, scheme $SCHEME, configuration $check_config"
  
  values="$(xcodebuild -workspace "$check_workspace_path" -scheme "$SCHEME" -configuration "$check_config" -showBuildSettings | tail -n +2 | sed 's/^ *//;s/ *$//')"
  echo
  source $check_rules_path
  echo
    
done
