FROM jenkins/jenkins:lts
LABEL author="Mike Vartanian"
MAINTAINER mike.vartanian@nih.gov

EXPOSE 8080

COPY jenkins.yaml /var/jenkins_home/jenkins.yaml
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
