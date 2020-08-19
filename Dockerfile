FROM centos:7

ARG JENKINS_SLAVE_VERSION=3.27
ARG DOCKER_VERSION=18.06.3

RUN yum install iproute curl wget java-1.8.0-openjdk git openssh-client openssl procps -y \
    && yum clean all && rm -rf /var/cache/yum

# install docker
# wget https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}-ce.tgz
ADD docker-18.06.3-ce.tgz /tmp/
RUN cd /tmp && mv docker/docker /bin/docker && cd /

# curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/3.27/remoting-3.27.jar
COPY remoting-3.27.jar /usr/share/jenkins/slave.jar

# wget https://raw.githubusercontent.com/jenkinsci/docker-jnlp-slave/3.27-1/jenkins-slave -O jenkins-slave
COPY jenkins-slave /jenkins-slave
RUN chmod +x /jenkins-slave

ENTRYPOINT ["/jenkins-slave"]
