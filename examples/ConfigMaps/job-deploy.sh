#!/bin/bash -e
#
# Deploy Example which fails
#
date
echo ">>>>> Sending Starting e-Mail <<<<<"
echo "The Deployment Pod has started" | mail -s "Deployment Pod Started" timothy.hessing@das.ohio.gov
date
echo ">>>>> Executing Deployment Script <<<<<"
echo " "
#
# .mailrc
echo ">>>>> mailrc Info <<<<<"
ls -als $HOME/.mailrc
cat $HOME/.mailrcb
echo " "
#
date
date > $DATA/deployment.txt
ls -als $DATA
echo ">>>>> Sending Finished e-Mail <<<<<"
echo "The Deployment Pod has finished" | mail -s "Deployment Pod Finished" timothy.hessing@das.ohio.gov
#
echo "Sleeping for 15 seconds to give finished email a chance to be sent"
date
sleep 15
echo "Done sleeping"
date
#
exit 0