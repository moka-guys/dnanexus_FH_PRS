#!/bin/bash

# The following line causes bash to exit at any point if there is any error
# and to output each line as it is executed -- useful for debugging
set -e -x -o pipefail
if [ $skip == false ]; 
	then
		#Grab inputs
		dx-download-all-inputs --parallel
		
		# if vcf is gzipped decompress (removes .gz file)
		if [[ $VCF_name =~ \.gz$ ]]; then
			gunzip $VCF_path
			# capture the vcf_name without the .gz (remove everything after the last full stop)
			vcf_name=${VCF_name%.*}
		else
			# if not compressed can use the input filename
			vcf_name=$VCF_name
		fi

		# make output folder
		mkdir -p ~/out/PRS_output/PRS_output
		
		# capture samplename from file name (remove everything after the first fullstop)
		samplename=${VCF_name%%.*}

		# load docker image
		docker load  --input ~/fh_prs_v1.0.tgz

		# docker run. mount input directory as /sandbox, use the $vcf_name variable set above to create the docker path to mounted dir.
		# Output to output folder named $samplename.txt
		docker run -v /home/dnanexus/in/VCF:/sandbox fh_prs_v1.0:latest /sandbox/$vcf_name > ~/out/PRS_output/PRS_output/$samplename.txt

		# Send output back to DNAnexus project
		mark-section "Upload output"
		dx-upload-all-outputs --parallel

		mark-success
fi