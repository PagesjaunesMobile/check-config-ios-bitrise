function read_value {
  value=$(echo "$values" | grep -e "^$1 = ")
  value=$(echo $value | awk -F" = " '{print $2}')
  echo "$value"
}

function check_value_equals {
  value="$(read_value $1)"
  if [ $value == $2 ]; then
	  msg_success "\"$1\" equals \"$2\""
		return 0
  else 
		msg_error "\"$1\" equals \"$value\", should be \"$2\""
		return 1
	fi
}

function check_value_contains {
  value="$(read_value $1)"
  echo "$1 = $value"
  if [[ $value =~ .*$2.* ]]; then
		msg_success "\"$1\" contains \"$2\""
		return 0
	else
		msg_error "\"$1\" should contain \"$2\""
		return 1
	fi
}

function check_value_not_contains {
  value="$(read_value $1)"
  echo "$1 = $value"
  if [[ $value =~ .*$2.* ]]; then
		msg_error "\"$1\" contains \"$2\""
		return 1
	else
		msg_success "\"$1\" does not contain \"$2\""
		return 0
	fi
}