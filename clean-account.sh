#!/bin/sh

USER=$(id -u -n)
HOMEDIR=$(getent passwd "$USER" | cut -d: -f6)

$HOMEDIR

for i in Desktop Downloads Documents
    do "Deleting $HOMEDIR/${i} contents";
    rm -rf $HOMEDIR/${i}/*
done
