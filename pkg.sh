#!/bin/bash
TASK_ID=ftpartifact
BUILD_VERSION=`cat VERSION`
tar cvzf $TASK_ID-$BUILD_VERSION.tar.gz run.xml macro convertor VERSION 

if [ -f $TASK_ID-$BUILD_VERSION.tar.gz  ]; then
    echo 'package success'
    ls $TASK_ID-$BUILD_VERSION.tar.gz
else
    echo 'package failed'
    exit -1
fi
