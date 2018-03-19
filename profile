#! /usr/bin/env bash
set -e

base_command=$(basename "$0")
usage=$(cat << EOM
$base_command -- a program to list aws profile and print aws environment variables of given profile.

Usage: 
    $base_command <command> <profile-name>

Commands:
    list|ls
        List the available profiles found in \$HOME/.aws/credentials file.
    switch <profile-name>
        Print all the environment variables of given profile name.

Example:
    List proflies:
        $base_command ls
    Print environment variables of profile 'test':
        $base_command switch test
    Enable profile 'test':
        eval \$($base_command siwtch test)
EOM
)

list_profiles() {
    while read line; do
        if [[ $line == "["* ]]; then 
            echo "$line" | tr -d '[]'
        fi
    done < "$HOME/.aws/credentials"
}

switch_profile() {
   if aws configure get aws_access_key_id --profile $1 >/dev/null; then
        echo "export AWS_DEFAULT_PROFILE=$1"
        echo "export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id --profile $1)"
        echo "export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key --profile $1)"
        echo "export AWS_DEFAULT_REGION=$(aws configure get region --profile $1)"
   fi
}

if which aws >/dev/null; then
    :
else
    echo "$usage"
    echo 'Error: Missing dependency awscli'
    exit 1
fi

case "$1" in
    ls|list)
        list_profiles
        ;;
    switch)
        if [[ -z $2 ]]; then
            echo "$usage"
            echo "Error: No profile name provided for command 'switch'"
            exit 1
        fi
        switch_profile $2
        ;;
    *)
        echo "$usage"
        exit 0
        ;;
esac
