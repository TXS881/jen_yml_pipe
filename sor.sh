export ODATE=$1

currdir=`pwd`
c=`ls -ltr ${currdir} | grep logs | awk '{print $9}'`
echo "${c}"



if [[ -f ${currdir}/${c} ]]
then
    echo "${currdir}/${c}"
    mv ${currdir}/*logs*  ${currdir}/${ODATE}_logs.log
    echo "${currdir}/${c}"
else
    exit 3
fi