#!/bin/bash

mkdir /out

cli.py --galaxy_parameters_file=/files/galaxy/test-data/galaxy_inputs.json --target_dir=/out/

# check that files were created
if ! [ -e "/out/i_investigation.txt" ]; then
	echo "Output investigation file doesn't exist"
	exit 1
fi

if ! [ -e "/out/s_study.txt" ]; then
	echo "Output study file doesn't exist"
	exit 1
fi

if ! [ -e "/out/a_plasma_nmr_1D 1H NMR_wet_assay.txt" ]; then
	echo "Output assay file doesn't exist"
	ls /out/
	exit 1
fi

echo "All files created successfully"
