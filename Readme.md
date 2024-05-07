# DNAnexus FH PRS v2.0.0

## What does this app do?
The app takes in a compressed GVCF and uses bcftools convert (https://github.com/samtools/bcftools/releases/tag/1.13) to change it to a uncompressed VCF based on a provided BED file. 

The Bioconda bcftools docker image v1.13 taken from DockerHub, tagged, and saved as a bcftools_v1.13.tar.gz file, saved in the 001_ToolsReferenceData project. The app loads the docker image from the .tar.gz file each time it is run.

The output uncompressed VCF is used as an input to calculate PRS. It uses the dockerised code from [https://github.com/moka-guys/fhprs] v1.0.1 saved in the 001_ToolsReferenceData project.

## What are typical use cases for this app?
It is used to calculate the polygenic risk score (PRS) for FH samples.

## What inputs are required for this app to run?
This app requires the following inputs:

- g.vcf (compressed)
- BEDfile containing regions of interest
- skip (boolean flag - true (default) or false). If skip = true the app runs but finishes without any data processing. This is so we can embed the app in a generic workflow that would run more than just FH samples.

## How does this app work?
If skip is not true the input GVCF is downloaded, and decompressed and compressed as a bgzip file (requirment for bcftools).
Bcftools then converts GVCF to a VCF, in a format required by the FH dockerised image. The output VCF is saved in PRS_output/
The samplename is captured from the vcf file name (everything before the first full stop).
The docker image packaged in the app is loaded and run, with the output written to a subfolder PRS_output/$samplename.txt

## What does this app output?
This app outputs a decompressed VCF file and one text file with three lines. 
Line 1 lists the genotypes, line2 lists the PRS and line 3 lists the risk and the decile.
The outputs are saved to `/PRS_output`

If skip = true no output is produced.

### This app was produced by the Synnovis Genome Informatics Team.
