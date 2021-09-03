SHELL = /bin/bash

# The conda env definition file "env.yml" is located in the project's root directory
CURRENT_CONDA_ENV_NAME = Twist_DNA
# Note that the extra activate is needed to ensure that the activate floats env to the front of PATH
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate $(CURRENT_CONDA_ENV_NAME)

all:
	@($(CONDA_ACTIVATE) ; \
	export SINGULARITY_LOCALCACHEDIR=/home/rada/Documents/CGL/Twist_DNA/singularity_cache ; \
	snakemake --cores 20 --use-singularity --singularity-args "--bind /home/rada/ " -s /home/rada/Documents/CGL/Twist_DNA/Twist_DNA.smk --forceall $(ARGS))

create_yaml:
	@($(CONDA_ACTIVATE) ; \
	snakemake -p -j 1 -s /home/rada/Documents/CGL/Twist_DNA/src/Snakemake/rules/Twist_DNA_yaml/Twist_DNA_yaml.smk)

pull_default_sif:
	singularity pull Twist_DNA.sif docker://gmsuppsala/somatic:develop

clean:
	@rm -rf alignment
	@rm -rf Bam
	@rm -rf benchmarks
	@rm -rf CNV
	@rm -f DATA/gene_depth_PVAL-*-ready.txt
	@rm -f genefuse.json
	@rm -rf fastq
	@rm -rf freebayes
	@rm -rf logs
	@rm -rf MSI
	@rm -rf mutect2
	@rm -rf qc
	@rm -rf recall
	@rm -rf Results
	@rm -rf vardict
	@rm -rf varscan
	