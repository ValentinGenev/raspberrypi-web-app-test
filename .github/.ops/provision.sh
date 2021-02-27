#!/bin/bash

declare -rx DIR_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function _error()
{
  if [ -n "$1" ]; then
    echo "Error: $1";
  fi

cat <<EOF
Usage:
- updates server's os;
- installs dependencies;
- prepares dirs;
EOF
}

_provision() {
  local sshkey="$1";
  local host="$2";
  local user="$3";
  local port="$4";
  echo "Provisioning..."

  ssh -o StrictHostKeyChecking=no -o IdentitiesOnly=no -i $sshkey $user@$host -p $port 'sudo bash -s' < "$DIR_ROOT/provision-local.sh"
}

main() {
  local file_env="${DIR_ROOT}/env/${1}.env";
  echo $file_env

  if [[ $# == 0 ]] || [[ ! -f $file_env ]]; then
    _error "The environment file is missing!"
  else
    echo "Environment file found, parsing... "

    # Load env vars into scope:
    # $PROD_SSH_KEY $PROD_SSH_HOST $PROD_SSH_USER $PROD_SSH_PORT
    eval `cat $file_env`

    # Deploy to multiple environments at once
    for i in "${!PROD_SSH_HOST[@]}"
    do
      _provision "$PROD_SSH_KEY" "${PROD_SSH_HOST[$i]}" "${PROD_SSH_USER[$i]}" "${PROD_SSH_PORT[$i]}"
    done
  fi
}

main "$@"
