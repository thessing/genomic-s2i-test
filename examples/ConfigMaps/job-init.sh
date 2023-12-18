#!/bin/bash -e
#
# Initialization Job
#
date
#
KEYTAB=$HOME/$RUNUSER.keytab
PRINCIPAL=$RUNUSER@ID.OHIO.GOV
KINIT=/usr/bin/kinit
CURL=/usr/bin/curl
HTTPFS="https://httpfs.c12.data.ohio.gov:14000/webhdfs/v1"
#
echo ">>>>> Sending Starting e-Mail <<<<<"
echo "The Initialization Job has started" | mail -s "Initialization Job Started" timothy.hessing@das.ohio.gov
date
echo ">>>>> Executing Initialization Job <<<<<"
echo " "
#
# Check BaseSpace
echo ">>>>> BaseSpace Version <<<<<"
bs --version
echo " "
#
# Check NextFlow
echo ">>>>> NextFlow Version <<<<<"
nextflow -version 
echo " "
#
# .mailrc
echo ">>>>> mailrc Info <<<<<"
ls -als $HOME/.mailrc
cat $HOME/.mailrc
echo " "
#
echo "### Create Directories for data ro be stored"
echo "### on the Pod  ${DATA}/${RUNNAME}/${RUNDATE}/"
echo "### and in HDFS /user/${RUNUSER}/${RUNNAME}/${RUNDATE}/"
#
mkdir -vp $DATA/$RUNNAME/$RUNDATE
#
$KINIT -k -t "$KEYTAB" "$PRINCIPAL" || echo "Failed to authenticate to kerberos using keytab ${KEYTAB} as ${PRINCIPAL}"
$CURL -vvv --noproxy '*' -f -X PUT -i --negotiate -u : "${HTTPFS}/user/${RUNUSER}/${RUNNAME}/${RUNDATE}/?op=MKDIRS&permission=1775" \
|| echo "Failed to create HDFS /user/${RUNUSER}/${RUNNAME}/${RUNDATE} directory" 
#
date
date >  $DATA/$RUNNAME/$RUNDATE/init-job.txt
ls -als $DATA/$RUNNAME/$RUNDATE/
#
echo ">>>>> Sending Finished e-Mail <<<<<"
echo "The Initialization Job has finished" | mail -s "Initialization Job Finished" timothy.hessing@das.ohio.gov
#
echo "Sleeping for 15 seconds to give finished email a chance to be sent"
date
sleep 15
echo "Done sleeping"
date
#
exit 0