#!/usr/bin/env bash
NAME="$1"
if [ -z "$NAME" ]; then
    echo "Usage: cl-new <project-name>"
    exit 1
fi

sbcl --noinform --non-interactive \
     --eval "(ql:quickload :quickproject :silent t)" \
     --eval "(quickproject:make-project (merge-pathnames \"$NAME/\" *default-pathname-defaults*
