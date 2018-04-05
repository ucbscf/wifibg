#!/bin/sh

#If we ever need to deleted a logged-in console user,
#then uncomment the last line two lines and replace the current
#"for i" loop.
#for i in `who | grep "console" | cut -d" " -f1`
#    do HOMEDIR="$(eval echo ~${i})";
for i in neyman 
    do HOMEDIR="/Users/neyman";
    echo "Cleaning $HOMEDIR";
    for i in Desktop Downloads Documents
        do echo "Deleting $HOMEDIR/${i} contents";
        rm -rf $HOMEDIR/${i}/*
    done
done

