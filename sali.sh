export ODATE=$1

currdir=`pwd`
#echo "${currdir}/"
c=`ls -ltr ${currdir}/ | grep logs | awk '{print $9}'`



log_dir="/home/ec2-user/log_dir/"

sudo rm -rf ${log_dir}*logs.log
$(sudo touch ${log_dir}${ODATE}_logs.log)

log_file=${ODATE}_logs.log

if [[ -f ${log_dir}${log_file} ]]
then
    echo "Info: Todays log file start" > ${log_dir}${log_file}
else
    exit 7
fi

exit 0
