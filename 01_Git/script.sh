#!/bin/bash

###
### create path
###

COMMENT="### written by https://github.com/rakiraki-lucky/accessory"
BASHRC_CONTENT=$(cat 'target1')
SCRIPT_DIR_PATH=$(cd $(dirname $0); pwd)
CMD="source "

### setting .bashrc
if [[ $BASHRC_CONTENT != *"${COMMENT}"* ]]
then
  TARGET_FILE=~/.bashrc
  echo "start setting .bashrc..."
  echo -e "\\n${COMMENT}" | cat >> TARGET_FILE

  TO_BASHRC_DIR_PATH=$(cd "${SCRIPT_DIR_PATH}/to_bashrc/"; pwd)
  TO_BASHRC_FILES=$(ls "${SCRIPT_DIR_PATH}/to_bashrc/" )

  echo $TO_BASHRC_FILES | 
    awk -v cmd="${CMD}" -v to_bashrc_dir_path="${TO_BASHRC_DIR_PATH}" '{ 
      for (i=1; i<=NF; i++) 
        print cmd to_bashrc_dir_path "/" $i }' | cat >> TARGET_FILE
else
  echo ".bashrc already set"
fi

BASHRC_CONTENT=$(cat 'target2')

### setting .gitconfig
if [[ $BASHRC_CONTENT != *"${COMMENT}"* ]]
then
  TARGET_FILE=~/.gitconfig
  echo "start setting .gitconfig..."
  echo -e "\\n${COMMENT}" | cat >> target2

  TO_GITCONFIG_DIR_PATH=$(cd "${SCRIPT_DIR_PATH}/to_gitconfig/"; pwd)
  TO_GITCONFIG_FILES=$(ls "${SCRIPT_DIR_PATH}/to_gitconfig/" )

  echo $TO_GITCONFIG_FILES | 
    awk -v cmd="${CMD}" -v to_gitconfig_dir_path="${TO_GITCONFIG_DIR_PATH}" '{ 
      for (i=1; i<=NF; i++) 
        print cmd to_gitconfig_dir_path "/" $i }' | cat >> target2
else
  echo ".gitconfig already set"
fi