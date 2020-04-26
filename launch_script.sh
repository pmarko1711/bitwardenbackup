#!/bin/bash

BW_OUT=bwout.fl
BW_RAW=bwout.raw

function login () {
    # ensure loging
    if [[ -z "$BW_USER" ]] || [[ -z "$BW_PASS" ]]; then
        echo "BW_USER and/or BW_PASS not defined"
        exit 1
    fi
    BW_SESSION="$(bw login $BW_USER $BW_PASS --raw)"
    if [[ $? -ne 0 ]]; then
        echo "Could not log in"
        exit 2
    fi
}

function logout () {
    # ensure loging out
    if [[ -z "$BW_SESSION" ]]; then
        echo "BW_SESSION"
        exit 1
    fi
    bw logout
    unset BW_SESSION
}

function list_items () {
    if [[ -z "$GPG_PASS" ]]; then
        CPASS=$BW_PASS
    else
        CPASS=$GPG_PASS
    fi
    if [[ -z "$RAW" ]]; then
        bw list items --session $BW_SESSION > $BW_RAW
        echo $CPASS | gpg2 -o $BW_OUT -a -c --batch --passphrase-fd 0 $BW_RAW
        rm $BW_RAW
    else
        bw list items --session $BW_SESSION > $BW_OUT
    fi
}

# main logic
login
list_items
if [[ -z "$OUTFILE" ]]; then
    cat $BW_OUT
    rm $BW_OUT
else
    cp $BW_OUT "/output/$OUTFILE"
    echo "Output saved to $OUTFILE"
    rm $BW_OUT
fi

logout > /dev/null
