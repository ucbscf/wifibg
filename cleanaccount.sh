#!/bin/bash

user=neyman
echo "Cleaning $HOMEDIR";
for i in Desktop Downloads Documents; do
    d="/Users/${user}/${i}"
    echo "Deleting ${d} contents";
    rm -rf ${d}
    install -d -g staff -o ${user} ${d}
done

