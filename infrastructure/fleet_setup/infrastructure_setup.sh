#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR" || exit 1
echo "Enter GitHub Runner Token"
read GH_RUNNER_TOKEN
echo "Expected SHA256 of github runner package"
read SHA256 
ansible-playbook -i inventory.yaml continuous_integration/charlieindia_setup_runner.yaml -e "target_host=charlieindia1" -e "runner_token=$GH_RUNNER_TOKEN" -e "sha256_github_runner=$SHA256" --ask-pass --ask-become-pass
ansible-playbook -i inventory.yaml continuous_integration/charlieindia_activate_runner.yaml -e "target_host=charlieindia1" --ask-pass --ask-become-pass
