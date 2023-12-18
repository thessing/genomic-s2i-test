#Dockerfile
#
# Args
ARG base_image
#
# Use Base Image
FROM $base_image
#
# Args
ARG image_name
ARG version
ARG sub_version
#
# Upgrade packages and install other packages into the base image
RUN yum -y update && \
    yum install -y yum-utils && \
    yum install -y wget && \
    yum install -y git && \
    yum install -y mailx && \
    yum install -y postfix && \
    yum install -y krb5-libs krb5-workstation
#
# Update Kerberos Configuration File
COPY krb5.conf /etc/krb5.conf
#
# Update Certificate for this Build
COPY 8-28-2023-package-repo.cer /etc/pki/ca-trust/source/anchors/package-repo.cer
COPY 8-28-2023-intermediate.cer /etc/pki/ca-trust/source/anchors/intermediate.cer
COPY 8-28-2023-USERTrustRSA-Root.cer /etc/pki/ca-trust/source/anchors/USERTrustRSA-Root.cer
COPY 8-28-2023-package-repo.cer /usr/share/pki/ca-trust-source/anchors/package-repo.cer
COPY 8-28-2023-intermediate.cer /usr/share/pki/ca-trust-source/anchors/intermediate.cer
COPY 8-28-2023-USERTrustRSA-Root.cer /usr/share/pki/ca-trust-source/anchors/USERTrustRSA-Root.cer
RUN update-ca-trust extract
#
# Create Application & Data Disk Environment Variables & Directories
#
# Define Application location
ENV HOME /opt/app-home
RUN mkdir -v $HOME
RUN chmod a+rwx $HOME
#
# Define Data location
ENV DATADISK /data
RUN mkdir -v $DATADISK
RUN chmod a+rwx $DATADISK
#
# Relax Permissions on /opt
RUN chmod a+rwx /opt
#
# Install Docker
RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
RUN yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#
# Latest Java (need 11 or greater)
RUN yum install -y java-11-openjdk
#
# Install miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
   /bin/bash ~/miniconda.sh -b -p /opt/conda
#
# Create Environment Variable
ENV CONDA_DIR /opt/conda
#
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH
#
# Put condarc in right spot
COPY .condarc $CONDA_DIR/.condarc
#
# Update Conda base
RUN conda update -n base -c defaults conda -y
#
# Install Conda Python plus some standard libraries
RUN conda install -y -c iop-main python=3.10 pip argcomplete backcall bitarray certifi \
charset-normalizer cycler debugpy decorator entrypoints idna importlib-metadata impyla \
ipykernel ipython jedi jupyter_client jupyter pykerberos kiwisolver matplotlib \
matplotlib-inline nest-asyncio parso pexpect pickleshare prompt-toolkit \
ptyprocess pure-sasl pygments pyparsing python-dateutil pyzmq requests six tornado \
traitlets typing-extensions urllib3 wcwidth zipp thriftpy2 pandas krb5 xz hdfs3 pyarrow
#
# Install/Update Flask
RUN pip install Flask
#
RUN rm -f ~/miniconda.sh
RUN chmod -R a+rwx $CONDA_DIR
#
# Make User 100970000 for odh-genomics project (100980000 for tesdt-01)the owner of the $HOME area
#RUN chown -R 1000970000:root $HOME
#RUN chown -R 1000980000:root $HOME
#
# Change to USER 100970000 for odh-genomics project (100980000 for tesdt-01) [Note: $HOME is /opt/app-home]
#USER 1000970000
#USER 1000980000
#
# Define BaseSpace Location and add to PATH
ENV BASESPACE $HOME/basespace
RUN mkdir -v $BASESPACE
ENV PATH=$BASESPACE:$PATH
#
# Install BaseSpace
RUN wget "https://launch.basespace.illumina.com/CLI/latest/amd64-linux/bs" -O $BASESPACE/bs
RUN chmod -R a+rwx $BASESPACE
#
# Define NextFlow Location and add to PATH
ENV NEXTFLOW $HOME/nextflow
RUN mkdir -v $NEXTFLOW
ENV PATH=$NEXTFLOW:$PATH
#
# Install NextFlow
RUN cd $NEXTFLOW && wget -qO- https://get.nextflow.io | bash && ls -als
RUN cd $HOME && $NEXTFLOW/nextflow self-update
RUN chmod -R a+rwx $NEXTFLOW
#
# Define GISAID Location and add to PATH
ENV GISAID $HOME/gisaid
RUN mkdir -v $GISAID
ENV PATH=$GISAID:$PATH
#RUN chmod -R a+rwx $GISAID
#
# Pick-up any hidden files or other added to the $HPME Directory
RUN chmod -R a+rwx $HOME
#
# Override Runtime label and environment variables metadata
ENV IMAGE_NAME="$image_name" \
    IMAGE_FULL_VERSION="$version.$sub_version"  \
    IMAGE_SHORT_VERSION="$version" \
    IMAGE_MAINTENANCE_VERSION="$sub_version"  \
    IMAGE_DESCRIPTION="$image_name version $version.$sub_version for use in IOP OpenShift." \
    GENOMICS_VERSION=$IMAGE_FULL_VERSION
#
# Here you can specify the maintainer for the image that you're building
# Set the labels that are used for OpenShift to describe the builder image.
LABEL maintainer="Tim Hessing <tim.hessing@das.ohio.gov>"
LABEL io.k8s.description=$IMAGE_DESCRIPTION \
      io.k8s.display-name="$image_name version $version.$sub_version" \
      io.openshift.tags="$IMAGE_NAME,genomics,basespace,nextflow,python" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"
    # io.openshift.expose-services="8080:http" \
    # this label tells s2i where to find its mandatory scripts
    # (run, assemble, save-artifacts)