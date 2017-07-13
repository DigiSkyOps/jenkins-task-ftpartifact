#!/bin/bash
TASK_ID=ftpartifact
TASK_VERSION=$(cat VERSION)
GIT_COMMIT_ID=$(git rev-parse --short HEAD)
BUILD_VERSION=${TASK_VERSION}+${GIT_COMMIT_ID}.${TRAVIS_BUILD_NUMBER}

echo $BUILD_VERSION > VERSION
tar cvzf $TASK_ID-$BUILD_VERSION.tar.gz run.xml macro convertor VERSION 

if [ -f $TASK_ID-$BUILD_VERSION.tar.gz  ]; then
    echo 'package success'
    ls $TASK_ID-$BUILD_VERSION.tar.gz
else
    echo 'package failed'
    exit -1
fi
