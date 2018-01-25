#!/bin/bash

mkdir /out

cli.py --sample_assay_plans_file=/files/galaxy/test-data/sample_assay_plans.json --study_info_file=/files/galaxy/test-data/study_info.json --treatment_plans_file=/files/galaxy/test-data/treatment_plan.json --target_dir=/out/

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
	exit 1
fi

echo "All files created successfully"
