export ODATE=$1

currdir=`pwd`
#echo "${currdir}/"
c=`ls -ltr ${currdir}/ | grep logs | awk '{print $9}'`
echo "${c}"

rm -rf ${currdir}/*logs.log
$(touch ${ODATE}_logs.log)

log_file=${ODATE}_logs.log

if [[ -f ${log_file} ]]
then
    echo "Info: Todays log file start" > ${log_file}
else 
    exit 7
fi

exit 0
