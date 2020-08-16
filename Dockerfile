FROM centos:7

ARG JENKINS_SLAVE_VERSION=3.27
ARG DOCKER_VERSION=18.06.3

RUN yum install iproute curl wget java-1.8.0-openjdk git openssh-client openssl procps -y \
    && yum clean all && rm -rf /var/cache/yum

# install docker
#RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}-ce.tgz
ADD docker-18.06.3-ce.tgz /tmp/
RUN cd /tmp && mv docker/docker /bin/docker && cd /

#RUN yum install iproute curl wget java-1.8.0-openjdk git openssh-client openssl procps -y \
#    && yum clean all && rm -rf /var/cache/yum \
#    && wget https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}-ce.tgz \
#    && tar -xf docker-${DOCKER_VERSION}-ce.tgz \
#    && mv docker/docker /bin/docker \
#    && rm -rf docker docker-${DOCKER_VERSION}-ce.tgz \
#    && wget https://raw.githubusercontent.com/jenkinsci/docker-jnlp-slave/${JENKINS_SLAVE_VERSION}-1/jenkins-slave -O /jenkins-slave \
#    && chmod +x /jenkins-slave \
#    && curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JENKINS_SLAVE_VERSION}/remoting-${JENKINS_SLAVE_VERSION}.jar
#

COPY remoting-3.27.jar /usr/share/jenkins/slave.jar
COPY jenkins-slave /jenkins-slave
RUN chmod +x /jenkins-slave

#ENTRYPOINT ["/jenkins-slave"]
CMD ["/jenkins-slave"]
