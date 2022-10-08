
#!/bin/sh

#####################################################################################
################## THIS JOB IS TO DOWNLOAD THE SOURCE API FROM RADAR AND
#################  UPLOAD INTO S3 BUCKER                                #############

############ CREADTED BY : KALPESH SWAIN
############ DATE BY     : 2022/08/10
#####################################################################################

export ODATE=$1
export ENV=$2

spark_sub=$( find ~/ -type f -name "spark-submit" | cut -d'/' -f1-4)
${spark_sub}/bin/spark-submit \
	--deploy-mode client \
	/home/ubuntu/Project/mode.py



csv_file=$(ls -ltr '/home/ubuntu/Project/readar_clean.csv/'| grep 'part*')

if [ -f ${csv_file} ]
then
        echo " transfered csv file "
else
        echo "file is not present"
        exit 6
fi

# Upload file into s3

aws s3 mv /home/ubuntu/Project/readar_clean.csv/part* s3://raghunathnagar/Output_Files/

# purge file
rm -rf /home/ubuntu/Project/readar_clean

exit 0
