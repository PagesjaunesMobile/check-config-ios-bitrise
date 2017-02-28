#!/bin/bash

# fail if any commands fails
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$SCRIPT_DIR/libs/messages.sh"
source "$SCRIPT_DIR/libs/rules.sh"

if [ ! -d "$check_project_path" ]; then
  msg_error "Workspace not found"
	exit 1
fi

if [ ! -f "$check_rules_path" ]; then
  msg_error "Rules not found"
	exit 1
fi

config_list="$(xcodebuild -project "$check_project_path" -list | grep '        ' | sed 's/        //g' | tr '\n' '|')"

echo plop
echo $config_list

IFS='|' read -ra SCHEMES <<< "$check_schemes"
for SCHEME in "${SCHEMES[@]}"; do

  IFS='|' read -ra CONFIGS <<< "$check_configs"
  for CONFIG in "${CONFIGS[@]}"; do

    msg_info "Reading settings from $check_project_path, scheme $SCHEME, configuration $CONFIG"
    values="$(xcodebuild clean -project "$check_project_path" -scheme "$SCHEME" -configuration "$CONFIG" -showBuildSettings | tail -n +2 | sed 's/^ *//;s/ *$//') | grep -v 'Error Domain'"
    echo
    source $check_rules_path
    echo

  done

done
