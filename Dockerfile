# gentest
# Here you can use whatever base image is relevant for your application.
FROM iopconttest-registry-quay-quay-enterprise.apps.iopconttest.css.id.ohio.gov/timhessing/genomics-test:0.0

# Here you can specify the maintainer for the image that you're building
LABEL maintainer="Tim Hessing <tim.hessing@das.ohio.gov>"

# Export an environment variable that provides information about the application version.
# Replace this with the version for your application.
ENV GENEMICS_VERSION=0.0

# Set the labels that are used for OpenShift to describe the builder image.
LABEL io.k8s.description="Genomics Test" \
    io.k8s.display-name="Genomics Test 0.0" \
    io.openshift.tags="gentest,genomics-test:0.0,basespace,nextflow,python" \
    # io.openshift.expose-services="8080:http" \
    # this label tells s2i where to find its mandatory scripts
    # (run, assemble, save-artifacts)
    io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

# Install the nginx web server package and clean the yum cache
RUN echo $GENOMICS
ENV GENOMICS /opt/genomics
RUN echo "Test" > $GENOMICS/test.txt
#RUN git clone https://dasbdagitp01.id.ohio.gov/38173418/genomic-test.git $GENOMICS
# OR https://stackoverflow.com/questions/23391839/clone-private-git-repo-with-dockerfile
#
# Generate ssh keys with ssh-keygen -q -t rsa -N '' -f repo-key which will give you repo-key and repo-key.pub files.
# Add repo-key.pub to your repository deployment keys.
# On GitHub, go to [your repository] -> Settings -> Deploy keys
#
# Add something like this to your Dockerfile:
#ADD repo-key /
#RUN \
#  chmod 600 /repo-key && \  
#  echo "IdentityFile /repo-key" >> /etc/ssh/ssh_config && \  
#  echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \  
#  // your git clone commands here...
#
#RUN git clone git@dasbdagitp01.id.ohio.gov:38173418/genomic-test.git 

# Copy the S2I scripts to /usr/libexec/s2i since we set the label that way
COPY ./s2i/bin/ /usr/libexec/s2i

#RUN chown -R 1001:1001 /usr/share/nginx
#RUN chown -R 1001:1001 /var/log/nginx
#RUN chown -R 1001:1001 /var/lib/nginx
#RUN touch /run/nginx.pid
#RUN chown -R 1001:1001 /run/nginx.pid
#RUN chown -R 1001:1001 /etc/nginx

#USER 1001

# Modify the usage script in your application dir to inform the user how to run
# this image.
CMD ["/usr/libexec/s2i/usage"]