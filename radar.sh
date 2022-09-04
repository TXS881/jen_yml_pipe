
export ODATE=$1
echo "${ODATE}"

currdir=`pwd`
echo "${currdir}"

export log=${currdir}/${ODATE}_logs.log


file_name="/other/splyr.txt"

if [[ -f ${currdir}${file_name} ]]
then    

    echo "INFO : splyr file present for ${ODATE}" > ${log}
else
    echo "error file"               > ${log}

    exit 2
fi

export RS=$?

if [[ ${RS} -eq 0 ]]
then
    echo "file run successfully"        >> ${log}
else
    echo "file not found"               >> ${log}
    exit 3
fi

exit 0