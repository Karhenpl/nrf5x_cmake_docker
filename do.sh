# This file should be entry point to command this repository, but now it just simply run container


sdk_dir=${1?"need pass Nordic SDK directory! as argument"}

sudo SDK_DIR=$1 ./tools/scripts/runDocker.sh