
#!/bin/sh

#####################################################################################
################## THIS JOB IS TO DOWNLOAD THE SOURCE API FROM RADAR AND
#################  UPLOAD INTO S3 BUCKER                                #############

############ CREADTED BY : KALPESH SWAIN
############ DATE BY     : 2022/08/10
#####################################################################################

export ODATE=$1
export ENV=$2


aws s3 cp s3://raghunathnagar/Input_Files/radar.csv /home/ubuntu


spark_sub=$( find ~/ -type f -name "spark-submit" | cut -d'/' -f1-4)
${spark_sub}/bin/spark-submit \
	--deploy-mode client \
	/home/ubuntu/jen_yml_pipe/Project/python_script/mode.py




# Upload file into s3

aws s3 mv /home/ubuntu/readar_clean/part* s3://raghunathnagar/Output_Files/

# purge file
rm -rf /home/ubuntu/readar_clean

exit 0
