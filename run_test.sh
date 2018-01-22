#!/bin/bash

cli.py --parameters_file /input_params.json

# check that files were created
if ! [ -e "/i_investigation.txt" ]; then
	echo "Output investigation file doesn't exist"
	exit 1
fi

if ! [ -e "/s_study.txt" ]; then
	echo "Output study file doesn't exist"
	exit 1
fi

echo "All files created successfully"
