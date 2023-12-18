#!/bin/bash -e
#
# Initialization Job
#
date
KRAKENFILE=k2_standard_08gb_20230605.tar.gz
#
echo ">>>>> Sending Starting e-Mail <<<<<"
echo "The Kraken Job has started" | mail -s "Kraken Reference DB Creation Job Started" timothy.hessing@das.ohio.gov
date
echo ">>>>> Executing Kraken Reference DB Creation Job <<<<<"
echo " "
#
#
echo "### Create Reference Directory, $REFERENCE, to store Kraken DB"
if [ ! -d "$REFERENCE" ]; then
    echo "$REFERENCE does not exist, create it."
    mkdir -vp $REFERENCE
else
    echo "$REFERENCE exists."
fi
cd $REFERENCE
pwd
#
#
echo "### Get Kraken DB"
if [ ! -f "$KRAKENFILE" ]; then
    echo "$KRAKENFILE does not exists, get it."
    wget -nv https://genome-idx.s3.amazonaws.com/kraken/${KRAKENFILE} -O ${REFERENCE}/${KRAKENFILE}
else
    echo "$KRAKENFILE exists."
fi
#
#
echo "### Extract Kraken DB"
tar -zxvf ${REFERENCE}/${KRAKENFILE} -C $REFERENCE
#
date
date >  $DATA/kraken-job.txt
ls -als $REFERENCE
#
echo ">>>>> Sending Finished e-Mail <<<<<"
echo "The Kraken Job has finished" | mail -s "Kraken Reference DB Creation Job Finished" timothy.hessing@das.ohio.gov
#
echo "Sleeping for 15 seconds to give finished email a chance to be sent"
date
sleep 15
echo "Done sleeping"
date
#
exit 0