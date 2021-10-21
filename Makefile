SHELL = /bin/bash
.ONESHELL:
#.SHELLFLAGS := -eu -o pipefail -c
.SHELLFLAGS := -e -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# The conda env definition file "env.yml" is located in the project's root directory
CURRENT_CONDA_ENV_NAME = Twist_DNA
# Note that the extra activate is needed to ensure that the activate floats env to the front of PATH
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate $(CURRENT_CONDA_ENV_NAME)

CPUS = 6
ARGS = --forceall


run:
	@($(CONDA_ACTIVATE) ; \
	export SINGULARITY_LOCALCACHEDIR=/home/rada/Documents/CGL/Twist_DNA/singularity_cache ; \
	snakemake --cores $(CPUS) --use-singularity --singularity-args "--bind /home/rada/ " -s /home/rada/Documents/CGL/Twist_DNA/Twist_DNA.smk $(ARGS))

config:
	@($(CONDA_ACTIVATE) ; \
	snakemake -p -j 1 -s /home/rada/Documents/CGL/Twist_DNA/src/Snakemake/rules/Twist_DNA_yaml/Twist_DNA_yaml.smk)

pull_default_sif:
	singularity pull Twist_DNA.sif docker://gmsuppsala/somatic:develop

clean:
	@rm -rf alignment ; \
	Bam ; \
	benchmarks ; \
	CNV ; \
	DATA/gene_depth_PVAL-*-ready.txt ; \
	genefuse.json ; \
	fastq ; \
	freebayes ; \
	logs ; \
	MSI ; \
	mutect2 ; \
	qc ; \
	recall ; \
	Results ; \
	vardict ; \
	varscan
	