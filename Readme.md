# DNAnexus FH PRS v1.0

## What does this app do?
This app calculates a PRS based on an input VCF. It uses the dockerised code from [https://github.com/moka-guys/fhprs].

## What are typical use cases for this app?
It is used to calculate the polygenic risk score (PRS) for FH samples.

## What inputs are required for this app to run?
This app requires the following inputs:

- g.vcf (compressed or uncompressed)
- skip (boolean flag - true (default) or false). If skip = true the app runs but finishes without any data processing. This is so we can embed the app in a generic workflow that would run more than just FH samples.


## How does this app work?
If skip is not true the input VCF is downloaded, and if required, decompressed using gunzip.
The samplename is captured from the vcf file name (everything before the first full stop).
The docker image packaged in the app is loaded and run, with the output written to a subfolder PRS_output/$samplename.txt

## What does this app output?
This app outputs one text file with three lines. 
Line 1 lists the genotypes, line2 lists the PRS and line 3 lists the risk and the decile.
The result file is output to `/PRS_output`

If skip = true no output is produced.

### This app was produced by the Viapath Genome Informatics Team.
