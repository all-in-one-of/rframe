#!/bin/bash

# SET HOUDINI VERSION
export HOUDINI_VERSION="17.5"

#GET PATH FROM SCRIPT
#DIR=`dirname -- "$0"`
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#source houdini_setup from HFS
pushd /opt/hfs${HOUDINI_VERSION}
source houdini_setup
popd > /dev/null

#set EXPORTVARS
export HOUDINI_PATH="${DIR}/houdini${HOUDINI_MAJOR_RELEASE}.${HOUDINI_MINOR_RELEASE}_setup:${HFS}/houdini"
export JOB=${DIR}/project
echo "HOUDINO_PATH --> ${HOUDINI_PATH}"
echo "PROJECT_PATH --> ${JOB}"

