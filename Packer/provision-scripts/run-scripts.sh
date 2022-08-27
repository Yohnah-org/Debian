#!/bin/bash

cd /tmp/scripts-to-run/

ls *.sh | sort | while read FILE;
do
    echo "Running $FILE"
    sh $FILE
done