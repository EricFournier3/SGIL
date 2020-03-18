#!/bin/bash

#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/NORMAL/p'  |wc -l #NORMAL
#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/BUSY/p'  |wc -l #BUSY
#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/FIMERR/p'  |wc -l #FIMERR
#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/TMEOUT/p'  |wc -l #TMEOUT
#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/QUEUED/p'  |wc -l #QUEUED
#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/CANCEL/p'  |wc -l #CANCEL
#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/LINDRP/p'  |wc -l #LINDRP
#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/NOANSW/p'  |wc -l #NOANSW
#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/NOFILE/p'  |wc -l #NOFILE
#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/NOTFAX/p'  |wc -l #NOTFAX
#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/SCHERR/p'  |wc -l #SCHERR
#sed -n '/17\/03/p' faxlog_20200318_8H15.txt.txt | sed -n '/SNDING/p'  |wc -l #SNDING


BASEDIR="/mnt/Partage/LSPQ_Partage/temp_eric/FAX_SGIL/"
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

fimeerr=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/FIMERR/p' | wc -l)
echo "FIMEERR FAX for ${JOUR}/${MOIS} : ${fimeerr}"

timeout=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"   | sed -n '/TIMEOUT/p' | wc -l)
echo "TIMEOUT FAX for ${JOUR}/${MOIS} : ${timeout}"

queued=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/QUEUED/p' | wc -l)
echo "QUEUED FAX for ${JOUR}/${MOIS} : ${queued}"

cancel=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/CANCEL/p' | wc -l)
echo "CANCEL FAX for ${JOUR}/${MOIS} : ${cancel}"

lindrp=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p" | sed -n '/LINDRP/p' | wc -l)
echo "LINEDROP FAX for ${JOUR}/${MOIS} : ${lindrp}"

noansw=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/NOANSW/p' | wc -l)
echo "NOANSWER FAX for ${JOUR}/${MOIS} : ${noansw}"

nofile=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/NOFILE/p' | wc -l)
echo "NOFILE FAX for ${JOUR}/${MOIS} : ${nofile}"

notfax=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"   | sed -n '/NOTFAX/p' | wc -l)
echo "NOTFAX FAX for ${JOUR}/${MOIS} : ${notfax}"

scherr=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/SCHERR/p' | wc -l)
echo "SCHERR FAX for ${JOUR}/${MOIS} : ${scherr}"

snding=$(awk 'NR>1{print $2" -- "$5" -- "$6}' ${FAXLOG_PATH} | sed -n "/${JOUR}\/${MOIS}/p"  | sed -n '/SNDING/p' | wc -l)
echo "SENDING FAX for ${JOUR}/${MOIS} : ${snding}"

TOTAL_ERROR=$((cancel + lindrp + noansw + nofile + notfax + scherr + timeout + busy_fail))

echo "TOTAL ERROR for ${JOUR}/${MOIS} : ${TOTAL_ERROR}"



exit 1

