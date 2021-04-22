pipeline {
  agent { dockerfile {
      filename 'tests/dockerfiles/twist_dna.dockerfile'
      dir './'

    }
  }
  stages {
    stage('Dry run tests') {
      steps {
        sh 'pwd'
        sh 'ls -l .'
        sh 'cp -r /data_twist_dna_fgbio . && snakemake -n -s /Twist_DNA/Twist_DNA.smk --directory ./data_twist_dna_fgbio'
        sh 'cp -r /data_twist_dna_markdup . && snakemake -n -s Twist_DNA.smk --directory ./data_twist_dna_markdup'
        sh 'cp -r /data_twist_dna_gpu . && snakemake -n -s Twist_DNA.smk --directory ./data_twist_dna_gpu'
        sh 'cp -r /data_twist_dna_cutadapt . && snakemake -n -s Twist_DNA.smk --directory ./data_twist_dna_cutadapt'
        sh 'cp -r /data_twist_dna_fastp . && snakemake -n -s Twist_DNA.smk --directory ./data_twist_dna_fastp'
        sh 'cp -r /data_gms_somatic . && snakemake -n -s gms_somatic.smk --directory ./data_gms_somatic/'
        sh 'cp -r /data_demultiplex . && snakemake -n -s demultiplex.smk --directory ./data_demultiplex/'
      }
    }
  }
}
