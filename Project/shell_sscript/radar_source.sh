#!/bin/sh

#####################################################################################
################## THIS JOB IS TO DOWNLOAD THE SOURCE API FROM RADAR AND 
#################  UPLOAD INTO S3 BUCKER				#############

############ CREADTED BY : KALPESH SWAIN
############ DATE BY     : 2022/08/10
#####################################################################################

export ODATE=$1
export ENV=$2

radar_folder='/home/ubuntu/Project/'
file='radar.csv'

# creating log files
export logs='/home/ubuntu/Project/logs/log_radar_${ODATE}.log'
touch ${logs}

true_day=$(echo ${ODATE} |cut -c 8)


# ODATE Validation
odate_length=$( echo ${ODATE} | wc -m)
if [ ${odate_length} -gt 8 ]
then
	echo "ODATE is Validated -->${ODATE}"
else
	echo "${ODATE} is Wrong ODATE please re-enter true date"
	echo "${odate_length}"
	exit 1
fi


# Environmental Validation
if [ ${ENV}==QA ]
then
	echo "Environment is -->${ENV}"
else
	echo "Environment should be QA"
	exit 2
fi


# Downloading Source file

curl -o ${radar_folder}${file} 'https://cdn.wsform.com/wp-content/uploads/2021/05/currency.csv'

# Validate downloaded result
export success=$?

if [ ${success} -eq 0 ]
then
	echo "${file} downloaded successfully"
else
	echo "Download Failed"
	exit 3
fi


true_file=$(ls -ltr ${radar_folder} | grep ${true_day} |grep ${file}|awk '{print $9}' )
file_size=$(ls -ltr ${radar_folder} | grep ${file} | wc -l)

if [ -f ${true_file} ]
then      
       echo "file exist"
else
	exit 9
fi

# upload file into s3 bucket
aws s3 cp ${file} s3://raghunathnagar/Input_Files/

export rd=$?

if [ ${rd} -eq 0 ]
then
	echo "${file} upload into s3 successfully"
else
	echo"${file} failed to upload into s3"
	exit 8
fi

# purge file 
rm -rf ${radar_folder}${file}

exit 0
