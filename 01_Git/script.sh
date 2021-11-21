#!/bin/bash

###
### add path
###

add_path(){
  # $1: comment sentence
  # $2: resource_dir_path 
  # $3: target file path

  CMD="source "
  RESOURCE_FILES=$(ls $2)

  echo -e "\\n${1}" | cat >> $3
  echo $RESOURCE_FILES | 
    awk -v cmd="${CMD}" -v resource_dir_path="${RESOURCE_DIR_PATH}" '{ 
      for (i=1; i<=NF; i++) 
        print cmd to_bashrc_dir_path "/" $i }' | cat >> $3
}

print_header(){
  echo "======== \"$1\" settings ==================================="
}


COMMENT="###_written_by_https://github.com/rakiraki-lucky/accessory"
SCRIPT_DIR_PATH=$(cd $(dirname $0); pwd)

###
### .bashrc settings
###

TARGET_PATH=$(ls ~/.bashrc)         
RESOURCE_DIR_NAME="to_bashrc"
RESOURCE_DIR_PATH="${SCRIPT_DIR_PATH}/${RESOURCE_DIR_NAME}"

print_header $TARGET_PATH
if [ -e $TARGET_PATH ]
then
  echo "\"${TARGET_PATH}\" exists."

  CONTENT=$(cat $TARGET_PATH)
  if [[ $CONTENT != *"${COMMENT}"* ]]
  # judeg whether target file include comment sentence
  # -> Yes)abort, No)execute
  then
    echo "\"${TARGET_PATH}\" does not set yet."

    read -p "Do you execute setting to \"${TARGET_PATH}\"? (Y/n): " YN
    case "${YN}" in
      [yY]*)
        echo "OK. Execute setting..."

        add_path $COMMENT $RESOURCE_DIR_PATH $TARGET_PATH 
        echo "Successfuly. Settings Done."
        ;;
      *)
        echo "Abort." 
        ;;
    esac
  else
    echo "\"${TARGET_PATH}\" is already set."
  fi
else
  echo "\"${TARGET_PATH}\" does not exist."
fi

###
### .gitconfig settings
###

TARGET_PATH=$(ls ~/.gitconfig)       
RESOURCE_DIR_NAME="to_gitconfig"
RESOURCE_DIR_PATH="${SCRIPT_DIR_PATH}/${RESOURCE_DIR_NAME}"

#TARGET_PATH=~/.gitconfig

print_header $TARGET_PATH
if [ -e $TARGET_PATH ]
then
  echo "\"${TARGET_PATH}\" exists."

  CONTENT=$(cat $TARGET_PATH)
  if [[ $CONTENT != *"${COMMENT}"* ]]
  # judeg whether target file include comment sentence
  # -> Yes)abort, No)execute
  then
    echo "\"${TARGET_PATH}\" does not set yet."

    read -p "Do you execute setting to \"${TARGET_PATH}\"? (Y/n): " YN
    case "${YN}" in
      [yY]*)
        echo "OK. Execute setting..."

        add_path $COMMENT $RESOURCE_DIR_PATH $TARGET_PATH 
        echo "Successfuly. Settings Done."
        ;;
      *)
        echo "Abort." 
        ;;
    esac
  else
    echo "\"${TARGET_PATH}\" is already set."
    echo "exit 0"
  fi
else
  echo "\"${TARGET_PATH}\" does not exist."
fi