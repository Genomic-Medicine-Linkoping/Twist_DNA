.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS := -e -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# The conda env definition file "env.yml" is located in the project's root directory
CURRENT_CONDA_ENV_NAME = Twist_DNA
# Note that the extra activate is needed to ensure that the activate floats env to the front of PATH
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate $(CURRENT_CONDA_ENV_NAME)

CPUS = 90
ARGS = --forceall

.PHONY: \
run \
config \
pull_default_sif \
clean \
report \
collection \
archive \
help

REPORT = report.html

RESULTS = \
alignment \
Bam \
benchmarks \
CNV \
DATA/gene_depth_*-ready.txt \
DATA/background_run.tsv \
genefuse.json \
fastq \
freebayes \
logs \
MSI \
mutect2 \
qc \
recall \
Results \
vardict \
varscan \
$(REPORT)

SAMPLE_DATA = \
samples.tsv \
SampleSheet.csv \
units.tsv

# In this directory is gathered all results when you run command make archive
RESULTS_DIR = LI_VAL_17-24

STORAGE = /data/Twist_DNA/results

MAIN_SMK = /home/lauri/Desktop/Twist_DNA/Twist_DNA.smk

## run: Run the main pipeline
run:
	$(CONDA_ACTIVATE)
	export SINGULARITY_LOCALCACHEDIR=/data/Twist_DNA/singularity_cache
	snakemake --cores $(CPUS) \
	--use-singularity \
	--singularity-args "--bind /home/lauri/ --bind /data/" \
	-s $(MAIN_SMK) $(ARGS)

## config: Make the main config file (usually run before running the main pipeline)
config:
	$(CONDA_ACTIVATE)
	snakemake -p -j 1 -s /home/lauri/Desktop/Twist_DNA/src/Snakemake/rules/Twist_DNA_yaml/Twist_DNA_yaml.smk $(ARGS)

## pull_default_sif: Pull the default singularity image
pull_default_sif:
	singularity pull Twist_DNA.sif docker://gmsuppsala/somatic:develop

## report: Make snakemake report
report:
	$(CONDA_ACTIVATE)
	snakemake -j 1 --report $(REPORT) -s $(MAIN_SMK)

## collection: Collect all results from the last run into own directory
collection:
	mkdir -p $(RESULTS_DIR)
	mv $(RESULTS) $(RESULTS_DIR)
	cp $(SAMPLE_DATA) $(RESULTS_DIR)

## clean: Remove all the latest results
clean:
	rm -rf $(RESULTS)

#@($(CONDA_ACTIVATE)
#snakemake --cores 1 --delete-all-output --verbose Twist_DNA.smk

## archive: Move to larger storage location
archive:
	mv $(RESULTS_DIR) $(STORAGE)

## help: Show this message
help:
	@grep '^##' ./Makefile
