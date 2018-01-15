#!/bin/bash

python cli.py /input_params.json

# check that files were created
if ! [ -e "/i_investigation.txt" ]; then
	echo "Output investigation file doesn't exist"
	exit 1
fi

echo "All files created successfully"
