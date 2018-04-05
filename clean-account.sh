#!/bin/sh

HOMEDIR="$HOME"

for i in Desktop Downloads Documents
    do echo "Deleting $HOMEDIR/${i} contents";
    rm -rf $HOMEDIR/${i}/*
done
