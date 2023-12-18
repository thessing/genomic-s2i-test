# genomic-s2i-test

This repository consists of example code for building an S2I image in the IOP Container Platform (OpenShfit), as well as example code for creating a base image uisng Docker and deploying jobs in OpenShift. The folder structure is the following:

<ul> 
<li><b>.2si</b> - This is the only directory needed for S2I build. It contains the minimum number of files needed to create an S2I build from an existing base image. This must be created in the directory structure given here. The files needed are:</li>
<ul>
<li><b>bin/assemble</b> - This tells OpenShift S2I what to do to the base image.</li>
<li><b>bin/rum</b> - This tells OpenShift what to execute in the new image, when built as a job or deployment workload.</li>
</ul>
<li><b>examples/BaseImage</b> - This contains the files needed to build a base image with e-Mail, Kerberos, NextFlow, BaseSpace & Python 3.10 from Conda.</li>
<ul>
<li><b>.condarc</b> - This is used by the Dockerfile to define the location of the State of Ohio package repostory to use with conda.</li>
<li><b>docker-commands</b> - These are some example commands that can be used with the Dockerfile to build a base image.</li>
<li><b>Dockerfile</b> - This is the Dockerfile used to build a base image, which contains e-Mail, Kerberos, NextFlow, BaseSpace & Python 3.10 from Conda.</li>
<li><b>krb5.conf</b> - This is the default Kerberos configuration file for the State of Ohio, used within the Dockerfile.</li>
<li><b>package-repo-crt</b> - This is a certificate for the State of Ohio package respository.</li>
</ul>
<li><b>buildYAMLS</b> - These are example YAML files that can be used in OpenShift to create S2I Pipeline Images, Persistent Volumes, Secrets, Jobs & Deployments</li>
<ul>
<li><b>secret-example.yaml</b> - This is an example YAML file to create a secret.</li>
<li><b>pv-example.yaml</b> - This is an example YAML file to create a Persistent Volume.</li>
<li><b>pipeline-image-build.yaml</b> - This is an example YAML file build a pipeline image using the base image stored in quay.</li>
<li><b>init-job.yaml</b> - This is an example YAML file to build and run an initialization job using the pipeline image stored in quay.</li>
<li><b>analysis-job.yaml</b> - This is an example YAML file to build and run an analysis job using the pipeline image stored in quay.</li>
<li><b>deployment.yaml</b> - This is an example YAML file to build and run an deployment using the pipeline image stored in quay.</li>
</ul>
<li><b>ConfigMaps</b> - These are example files and YAML files that are used to create the ConfigMaps in the example jobs and deployments within this Git Repository. </li>
<ul>
<li><b>krb5.conf & krb5.yaml</b> - These are example files for a krb5.conf file created as a ConfigMap that is used is the job and deployment builds.</li>
<li><b>38173418.keytab & 38173418-keytab.yaml</b> - These are example files for a keytab file created as a ConfigMap that is used is the job and deployment builds.</li>
<li><b>.mailrc-init & mailrc-init.yaml</b> - These are example files for a .mailrc file created as a ConfigMap that is used within the init job build.</li>
<li><b>job-init.sh & job-init.yaml</b> - These are example files for a job.sh file created as a ConfigMap that is used within the init job build.</li>
<li><b>.mailrc-analysis & mailrc-analysis.yaml</b> - These are example files for a .mailrc file created as a ConfigMap that is used within the analysis job build.</li>
<li><b>job-analysis.sh & job-analysis.yaml</b> - These are example files for a job.sh file created as a ConfigMap that is used within the analysis job build.</li>
<li><b>.mailrc-deploy & mailrc-deploy.yaml</b> - These are example files for a .mailrc file created as a ConfigMap that is used within the deployment build.</li>
<li><b>job-deploy.sh & job-deploy.yaml</b> - These are example files for a job.sh file created as a ConfigMap that is used within the deployment build.</li>
</ul>
</ul>