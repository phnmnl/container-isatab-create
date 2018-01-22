#!/usr/bin/env python3
"""Commandline interface for running ISA API create mode"""
import click
import os

from isatools import isatab
from isatools.create.models import (
    TreatmentSequence,
    INTERVENTIONS,
    BASE_FACTORS,
    TreatmentFactory,
    IsaModelObjectFactory,
    SampleAssayPlanDecoder
)
from isatools.model import Investigation


@click.command()
@click.option('--parameters_file',
              help='Path to JSON file containing input Galaxy tool parameters',
              prompt='Path to JSON Galaxy parameters file', nargs=1, type=str,
              default='input_params.json')
def create_from_plan_parameters(parameters_file):
    decoder = SampleAssayPlanDecoder()
    with open(parameters_file) as fp:
        plan = decoder.load(fp)
    treatment_factory = TreatmentFactory(
        intervention_type=INTERVENTIONS['CHEMICAL'], factors=BASE_FACTORS)
    agent_levels = 'calpol, none'
    for agent_level in agent_levels:
        treatment_factory.add_factor_value(BASE_FACTORS[0], agent_level.strip())
    dose_levels = 'low, high'
    for dose_level in dose_levels:
        treatment_factory.add_factor_value(BASE_FACTORS[1], dose_level.strip())
    duration_of_exposure_levels = 'long, short'
    for duration_of_exposure_level in duration_of_exposure_levels:
        treatment_factory.add_factor_value(BASE_FACTORS[2],
                                           duration_of_exposure_level.strip())
    treatment_sequence = TreatmentSequence(
        ranked_treatments=treatment_factory.compute_full_factorial_design())
    isa_object_factory = IsaModelObjectFactory(plan, treatment_sequence)
    s = isa_object_factory.create_assays_from_plan()
    i = Investigation()
    s.filename = "s_study.txt"
    i.studies = [s]
    os.mkdir('isa')
    isatab.dump(isa_obj=i, output_path='/', i_file_name='i_investigation.txt')


if __name__ == '__main__':
    create_from_plan_parameters()
