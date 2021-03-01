#!/bin/bash

declare -rx DIR_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "$DIR_ROOT/common.sh"

function _error()
{
  if [ -n "$1" ]; then
    echo "Error: $1";
    echo
  fi

cat <<EOF
Usage:
- transfers files;
- restarts nginx, php;
EOF
}

_prepare_artifact() {
  local name="$1";
  local location="$2";
  local target="$DIR_ROOT/artifacts/$name.tar.gz";
  local source="`cd "$DIR_ROOT/../";pwd`";.

  echo $location

  tar -zcvf $target \
    --exclude "." \
    --exclude ".ops/" \
    --exclude "node_modules/" \
    --exclude "*.txt" \
    --exclude "*.log" \
    -C $source $location
}

_deploy() {
  local ssh_key="$1";
  local host="$2";
  local user="$3";
  local port="$4";
  local version="$5";
  local filename="$version.tar.gz";

  echo "Deploying $filename to - $host:$port"
  scp -i $ssh_key -P $port $DIR_ROOT/artifacts/$filename  $user@$host:/tmp/$filename
  ssh -o StrictHostKeyChecking=no -o IdentitiesOnly=no -o PasswordAuthentication=no -i $ssh_key $user@$host -p $port ARTIFACT="$version" 'bash -s' < "$DIR_ROOT/deploy-local.sh"
}

main() {
  local file_env="${DIR_ROOT}/env/${1}.env";
  local artifact_name="transform-$(date '+%Y%m%d-%H%M-%s')";

  if [[ $# -eq 0 ]] || [[ ! -f $file_env ]]; then
    _error "The environment file is missing!"
  else
    # Load env vars into scope:
    # $PROD_SSH_KEY $APP_USER $PROD_SSH_USER $PROD_SSH_PORT
    eval `cat $file_env`

    echo "Environment file found, parsing..."

    _prepare_artifact "$artifact_name" "$VHOST"

    # Deploy to multiple environments at once
    for i in "${!PROD_SSH_HOST[@]}"
    do
      _deploy "$PROD_SSH_KEY" "${PROD_SSH_HOST[$i]}" "${PROD_SSH_USER[$i]}" "${PROD_SSH_PORT[$i]}" "$artifact_name"
    done
  fi
}

main "$@"
