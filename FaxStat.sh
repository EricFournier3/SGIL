#!/bin/bash

#BASEDIR="/mnt/Partage/LSPQ_Partage/temp_eric/FAX_SGIL/"
BASEDIR="/mnt/Partage/LSPQ_Partage/SGIL/FAX_STAT/"
BASEDIR_IN=${BASEDIR}"IN/"
BASEDIR_OUT=${BASEDIR}"OUT/"
FAXLOG_FILE=$1
JOUR="$2"
MOIS="$3"

CURRENT_PATH=${PWD}/
CURRENT_YEAR=$(date +"%Y")
CURRENT_HOUR=$(date +"%HH_%Mm")

STAT_FILE="FAX_STAT_${CURRENT_YEAR}${MOIS}${JOUR}_${CURRENT_HOUR}.txt"
STAT_FILE_PATH="${CURRENT_PATH}${STAT_FILE}"
echo "STAT FILE IS ${STAT_FILE_PATH}"

FAXLOG_PATH=${BASEDIR_IN}${FAXLOG_FILE}


FAXSTATUS_PATH_CURRENT=${CURRENT_PATH}"FAX_STATUS_${CURRENT_YEAR}${MOIS}${JOUR}_${CURRENT_HOUR}.txt"

if [ ! -f ${FAXLOG_PATH} ]
  then
  echo "Entrer un nom de fichier"
  exit 1
else
  echo "Faxlog is ${FAXLOG_PATH}"
fi

if [ ${#JOUR} -eq 0 ]
  then 
  echo "entrer un jour"
  echo "./FaxStat.sh <NomFichier> <DD> <MM>"
  exit 1
fi

if [ ${#MOIS} -eq 0 ]
  then 
  echo "entrer un mois"
  echo "./FaxStat.sh <NomFichier> <DD> <MM>"
  exit 1
fi

echo "****************** ${FAXSTATUS_PATH_CURRENT}"
sed -n "/${JOUR}\/${MOIS}/p"  ${FAXLOG_PATH} >  $FAXSTATUS_PATH_CURRENT


#total=$(sed -n '/17\/03/p' ${FAXLOG_PATH}  | wc -l)
#echo "TOTAL FAX for ${JOUR}/${MOIS} : ${total}"

total=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p" | wc -l)
echo "TOTAL FAX for ${JOUR}/${MOIS} : ${total}"
echo "TOTAL FAX for ${JOUR}/${MOIS} : ${total}" > ${STAT_FILE_PATH}

normal=$(sed -n "/${JOUR}\/${MOIS}/p" ${FAXLOG_PATH}  | sed -n '/NORMAL/p' | wc -l)
echo "NORMALSEND FAX for ${JOUR}/${MOIS} : ${normal}"
echo "NORMALSEND FAX for ${JOUR}/${MOIS} : ${normal}" >> ${STAT_FILE_PATH}

busy=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"   | sed -n '/BUSY/p' | wc -l)
echo "BUSY FAX for ${JOUR}/${MOIS} : ${busy}"
echo "BUSY FAX for ${JOUR}/${MOIS} : ${busy}"  >> ${STAT_FILE_PATH}

busy_fail=$(awk '/BUSY/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p" | wc -l ) 
echo "BUSYFAIL FAX for ${JOUR}/${MOIS} : ${busy_fail}"
echo "BUSYFAIL FAX for ${JOUR}/${MOIS} : ${busy_fail}" >> ${STAT_FILE_PATH}

busy=$((busy - busy_fail))


fimerr=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/FIMERR/p' | wc -l)
echo "FIMERR FAX for ${JOUR}/${MOIS} : ${fimerr}"
echo "FIMERR FAX for ${JOUR}/${MOIS} : ${fimerr}" >> ${STAT_FILE_PATH}

fimerr_fail=$(awk '/FIMERR/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | wc -l)
echo "FIMERRFAIL FAX for ${JOUR}/${MOIS} : ${fimerr_fail}"
echo "FIMERRFAIL FAX for ${JOUR}/${MOIS} : ${fimerr_fail}"  >> ${STAT_FILE_PATH}

fimerr=$((fimerr - fimerr_fail))

timeout=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"   | sed -n '/TIMEOUT/p' | wc -l)
echo "TIMEOUT FAX for ${JOUR}/${MOIS} : ${timeout}"
echo "TIMEOUT FAX for ${JOUR}/${MOIS} : ${timeout}"  >> ${STAT_FILE_PATH}

timeout_fail=$(awk '/TIMEOUT/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"   | sed -n '/TIMEOUT/p' | wc -l)
echo "TIMEOUTFAIL FAX for ${JOUR}/${MOIS} : ${timeout_fail}"
echo "TIMEOUTFAIL FAX for ${JOUR}/${MOIS} : ${timeout_fail}"  >> ${STAT_FILE_PATH}

timeout=$((timeout - timeout_fail))


queued=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/QUEUED/p' | wc -l)
echo "QUEUED FAX for ${JOUR}/${MOIS} : ${queued}"
echo "QUEUED FAX for ${JOUR}/${MOIS} : ${queued}" >> ${STAT_FILE_PATH}


cancel=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/CANCEL/p' | wc -l)
echo "CANCEL FAX for ${JOUR}/${MOIS} : ${cancel}"
echo "CANCEL FAX for ${JOUR}/${MOIS} : ${cancel}" >> ${STAT_FILE_PATH}


lindrp=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p" | sed -n '/LINDRP/p' | wc -l)
echo "LINEDROP FAX for ${JOUR}/${MOIS} : ${lindrp}"
echo "LINEDROP FAX for ${JOUR}/${MOIS} : ${lindrp}" >> ${STAT_FILE_PATH}

lindrp_fail=$(awk '/LINDRP/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p" |  wc -l)
echo "LINEDROPFAIL FAX for ${JOUR}/${MOIS} : ${lindrp_fail}"
echo "LINEDROPFAIL FAX for ${JOUR}/${MOIS} : ${lindrp_fail}" >> ${STAT_FILE_PATH}

lindrp=$((lindrp - lindrp_fail))

noansw=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/NOANSW/p' | wc -l)
echo "NOANSWER FAX for ${JOUR}/${MOIS} : ${noansw}"
echo "NOANSWER FAX for ${JOUR}/${MOIS} : ${noansw}"  >> ${STAT_FILE_PATH}

noansw_fail=$(awk '/NOANSW/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  |  wc -l)
echo "NOANSWERFAIL FAX for ${JOUR}/${MOIS} : ${noansw_fail}"
echo "NOANSWERFAIL FAX for ${JOUR}/${MOIS} : ${noansw_fail}"  >> ${STAT_FILE_PATH}

noansw=$((noansw - noansw_fail))

nofile=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/NOFILE/p' | wc -l)
echo "NOFILE FAX for ${JOUR}/${MOIS} : ${nofile}"
echo "NOFILE FAX for ${JOUR}/${MOIS} : ${nofile}"  >> ${STAT_FILE_PATH}

notfax=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"   | sed -n '/NOTFAX/p' | wc -l)
echo "NOTFAX FAX for ${JOUR}/${MOIS} : ${notfax}"
echo "NOTFAX FAX for ${JOUR}/${MOIS} : ${notfax}" >> ${STAT_FILE_PATH}

notfax_fail=$(awk '/NOTFAX/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  |  wc -l)
echo "NOTFAXFAIL FAX for ${JOUR}/${MOIS} : ${notfax_fail}"
echo "NOTFAXFAIL FAX for ${JOUR}/${MOIS} : ${notfax_fail}"  >> ${STAT_FILE_PATH}

notfax=$((notfax - notfax_fail))

scherr=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/SCHERR/p' | wc -l)
echo "SCHERR FAX for ${JOUR}/${MOIS} : ${scherr}"
echo "SCHERR FAX for ${JOUR}/${MOIS} : ${scherr}" >> ${STAT_FILE_PATH}

scherr_fail=$(awk '/SCHERR/{if($5 > 4){print $2" -- "$5" -- "$6}}'  ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  |  wc -l)
echo "SCHERRFAIL FAX for ${JOUR}/${MOIS} : ${scherr_fail}"
echo "SCHERRFAIL FAX for ${JOUR}/${MOIS} : ${scherr_fail}" >> ${STAT_FILE_PATH}

scherr=$((scherr - scherr_fail))

snding=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/SNDING/p' | wc -l)
echo "SENDING FAX for ${JOUR}/${MOIS} : ${snding}"
echo "SENDING FAX for ${JOUR}/${MOIS} : ${snding}"  >> ${STAT_FILE_PATH} 

echo "------------------------------ SOMMAIRE ${JOUR}/${MOIS} pour ${FAXLOG_FILE} ---------------------------------------"
echo "------------------------------ SOMMAIRE ${JOUR}/${MOIS} pour ${FAXLOG_FILE} ---------------------------------------"  >> ${STAT_FILE_PATH}

TOTAL_ERROR=$((busy_fail + fimerr_fail + timeout_fail + lindrp_fail + noansw_fail + notfax + scherr_fail))
TOTAL_PENDING=$((busy + fimerr + timeout + queued + cancel + lindrp + noansw + nofile + notfax + scherr + snding))

echo "TOTAL SEND : ${normal}"
echo "TOTAL PENDING : ${TOTAL_PENDING}"
echo "TOTAL ERROR : ${TOTAL_ERROR}"

echo "TOTAL SEND : ${normal}"  >> ${STAT_FILE_PATH}
echo "TOTAL PENDING : ${TOTAL_PENDING}"  >> ${STAT_FILE_PATH}
echo "TOTAL ERROR : ${TOTAL_ERROR}"   >> ${STAT_FILE_PATH}

exit 1

