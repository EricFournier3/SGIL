#!/bin/bash

BASEDIR="/mnt/Partage/LSPQ_Partage/temp_eric/FAX_SGIL/"  #TODO CHANGER REPERTOIRE DE BASE
FAXLOG_FILE=$1
JOUR="$2"
MOIS="$3"


FAXLOG_PATH=${BASEDIR}${FAXLOG_FILE}

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



#total=$(sed -n '/17\/03/p' ${FAXLOG_PATH}  | wc -l)
#echo "TOTAL FAX for ${JOUR}/${MOIS} : ${total}"

total=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p" | wc -l)
echo "TOTAL FAX for ${JOUR}/${MOIS} : ${total}"

normal=$(sed -n "/${JOUR}\/${MOIS}/p" ${FAXLOG_PATH}  | sed -n '/NORMAL/p' | wc -l)
echo "NORMALSEND FAX for ${JOUR}/${MOIS} : ${normal}"

busy=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"   | sed -n '/BUSY/p' | wc -l)
echo "BUSY FAX for ${JOUR}/${MOIS} : ${busy}"

busy_fail=$(awk '/BUSY/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p" | wc -l ) 
echo "BUSYFAIL FAX for ${JOUR}/${MOIS} : ${busy_fail}"

busy=$((busy - busy_fail))


fimerr=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/FIMERR/p' | wc -l)
echo "FIMERR FAX for ${JOUR}/${MOIS} : ${fimerr}"

fimerr_fail=$(awk '/FIMERR/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | wc -l)
echo "FIMERRFAIL FAX for ${JOUR}/${MOIS} : ${fimerr_fail}"

fimerr=$((fimerr - fimerr_fail))

timeout=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"   | sed -n '/TIMEOUT/p' | wc -l)
echo "TIMEOUT FAX for ${JOUR}/${MOIS} : ${timeout}"

timeout_fail=$(awk '/TIMEOUT/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"   | sed -n '/TIMEOUT/p' | wc -l)
echo "TIMEOUTFAIL FAX for ${JOUR}/${MOIS} : ${timeout_fail}"

timeout=$((timeout - timeout_fail))


queued=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/QUEUED/p' | wc -l)
echo "QUEUED FAX for ${JOUR}/${MOIS} : ${queued}"


cancel=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/CANCEL/p' | wc -l)
echo "CANCEL FAX for ${JOUR}/${MOIS} : ${cancel}"


lindrp=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p" | sed -n '/LINDRP/p' | wc -l)
echo "LINEDROP FAX for ${JOUR}/${MOIS} : ${lindrp}"

lindrp_fail=$(awk '/LINDRP/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p" |  wc -l)
echo "LINEDROPFAIL FAX for ${JOUR}/${MOIS} : ${lindrp_fail}"

lindrp=$((lindrp - lindrp_fail))

noansw=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/NOANSW/p' | wc -l)
echo "NOANSWER FAX for ${JOUR}/${MOIS} : ${noansw}"

noansw_fail=$(awk '/NOANSW/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  |  wc -l)
echo "NOANSWERFAIL FAX for ${JOUR}/${MOIS} : ${noansw_fail}"

noansw=$((noansw - noansw_fail))

nofile=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/NOFILE/p' | wc -l)
echo "NOFILE FAX for ${JOUR}/${MOIS} : ${nofile}"

notfax=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"   | sed -n '/NOTFAX/p' | wc -l)
echo "NOTFAX FAX for ${JOUR}/${MOIS} : ${notfax}"

notfax_fail=$(awk '/NOTFAX/{if($5 > 4){print $2" -- "$5" -- "$6}}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  |  wc -l)
echo "NOTFAXFAIL FAX for ${JOUR}/${MOIS} : ${notfax_fail}"

notfax=$((notfax - notfax_fail))

scherr=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/SCHERR/p' | wc -l)
echo "SCHERR FAX for ${JOUR}/${MOIS} : ${scherr}"

scherr_fail=$(awk '/SCHERR/{if($5 > 4){print $2" -- "$5" -- "$6}}'  ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  |  wc -l)
echo "SCHERRFAIL FAX for ${JOUR}/${MOIS} : ${scherr_fail}"

scherr=$((scherr - scherr_fail))

snding=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/SNDING/p' | wc -l)
echo "SENDING FAX for ${JOUR}/${MOIS} : ${snding}"

echo "------------------------------ SOMMAIRE ${JOUR}/${MOIS} ---------------------------------------"



TOTAL_ERROR=$((busy_fail + fimerr_fail + timeout_fail + lindrp_fail + noansw_fail + notfax + scherr_fail))
TOTAL_PENDING=$((busy + fimerr + timeout + queued + cancel + lindrp + noansw + nofile + notfax + scherr + snding))

echo "TOTAL SEND : ${normal}"
echo "TOTAL PENDING : ${TOTAL_PENDING}"
echo "TOTAL ERROR : ${TOTAL_ERROR}"



exit 1

