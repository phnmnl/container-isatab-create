#!/bin/bash

mkdir /out

isacreate.py --galaxy_parameters_file=/files/galaxy/tools/isacreate/test-data/default_ms_gc.json --target_dir=/out/

#  check that files were created
if ! [ -e "/out/i_investigation.txt" ]; then
	echo "Output investigation file doesn't exist"
	ls /out/
	exit 1
fi

if ! [ -e "/out/s_study.txt" ]; then
	echo "Output study file doesn't exist"
	ls /out/
	exit 1
fi

if ! [ -e "/out/a_blood_GC_negative_assay.txt" ]; then
	echo "Output GC_negative assay file doesn't exist"
	ls /out/
	exit 1
fi

echo "All files created successfully"
