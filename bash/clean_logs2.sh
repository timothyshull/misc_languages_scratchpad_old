#!/bin/bash

LOG_DIR=/var/log
ROOT_UID=0     
LINES=50       
E_XCD=86       
E_NOTROOT=87   

if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi  

if [ -n "$1" ]
then
  lines=$1
else  
  lines=$LINES 
fi  


#  Stephane Chazelas suggests the following,
#+ as a better way of checking command-line arguments,
#+ but this is still a bit advanced for this stage of the tutorial.
#
#    E_WRONGARGS=85  # Non-numerical argument (bad argument format).
#
#    case "$1" in
#    ""      ) lines=50;;
#    *[!0-9]*) echo "Usage: `basename $0` lines-to-cleanup";
#     exit $E_WRONGARGS;;
#    *       ) lines=$1;;
#    esac
#
#* Skip ahead to "Loops" chapter to decipher all this.


cd $LOG_DIR

if [ `pwd` != "$LOG_DIR" ] 
    
then
  echo "Can't change to $LOG_DIR."
  exit $E_XCD
fi  # Doublecheck if in right directory before messing with log file.

# Far more efficient is:
#
# cd /var/log || {
#   echo "Cannot change to necessary directory." >&2
#   exit $E_XCD;
# }




tail -n $lines messages > mesg.temp # Save last section of message log file.
mv mesg.temp messages             


#  cat /dev/null > messages
#* No longer needed, as the above method is safer.

cat /dev/null > wtmp  
echo "Log files cleaned up."

exit 0