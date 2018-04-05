#!/bin/sh

USER=$(id -u -n)
HOMEDIR=$(getent passwd "$USER" | cut -d: -f6)

echo $HOMEDIR

for i in Desktop Downloads Documents
    do echo "Deleting $HOMEDIR/${i} contents";
    rm -rf $HOMEDIR/${i}/*
done
