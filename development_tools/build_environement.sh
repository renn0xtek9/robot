#!/bin/bash
set -euxo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEV_ENV_DEFINITION_SUBDIR="$DIR"/development_environments
PREFIX="robot"
# Build docker image locally
docker build -t "$PREFIX"_continuous_integration_environment:0.0.1 "$DEV_ENV_DEFINITION_SUBDIR"/continuous_integration_environment
docker build -t "$PREFIX"_software_developer_environment:0.0.1 "$DEV_ENV_DEFINITION_SUBDIR"/software_developer_environment
docker build -t "$PREFIX"_system_engineering_environment:0.0.1 "$DEV_ENV_DEFINITION_SUBDIR"/system_engineering_environment
# Tag docker image 
docker tag "$PREFIX"_system_engineering_environment:0.0.1 ghcr.io/renn0xtek9/"$PREFIX"_system_engineering_environment:0.0.1
# Push docker images to gihub registry
docker push ghcr.io/renn0xtek9/"$PREFIX"_system_engineering_environment:0.0.1
