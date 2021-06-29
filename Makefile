SHELL = /bin/bash

CURRENT_CONDA_ENV_NAME = Twist_DNA
# Note that the extra activate is needed to ensure that the activate floats env to the front of PATH
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate $(CURRENT_CONDA_ENV_NAME)

all:
	@($(CONDA_ACTIVATE) ; \
	snakemake --cores 10 --use-singularity --singularity-args "--bind /home/rada/ " -s /home/rada/Documents/CGL/Twist_DNA/Twist_DNA.smk)


create_yaml:
	@($(CONDA_ACTIVATE) ; \
	snakemake -p -j 1 -s /home/rada/Documents/CGL/Twist_DNA/src/Snakemake/rules/Twist_DNA_yaml/Twist_DNA_yaml.smk)


