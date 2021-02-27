#!/bin/bash

declare -rx DIR_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function _usage()
{
  if [ -n "$1" ]; then
    echo "Error: $1";
    echo
  fi

cat <<EOF
Usage: ./provision.sh environment , cp example.env staging.env , after that ./provision.sh staging
env file must resides in ./, eg. prod or staging
EOF
}

_provision() {
  local sshkey="$1";
  local host="$2";
  local user="$3";
  local port="$4";
  echo "Provisioning $host:$port $user..."

  ssh -o StrictHostKeyChecking=no -o IdentitiesOnly=no -i $sshkey $user@$host -p $port 'sudo bash -s' < "$DIR_ROOT/provision-local.sh"
}

main() {
  local file_env="${DIR_ROOT}/env/${1}.env";
  echo $file_env

  if [[ $# == 0 ]] || [[ ! -f $file_env ]]; then
    _usage "Environment file missing for provision"
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
