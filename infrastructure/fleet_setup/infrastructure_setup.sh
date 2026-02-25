#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR" || exit 1
ansible-playbook -i inventory.yaml continuous_integration/charlieindia.yaml -e "target_host=charlieindia1" --ask-pass --ask-become-pass
