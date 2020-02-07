FROM jenkins/jenkins:lts
LABEL author="Mike Vartanian"
MAINTAINER mike.vartanian@nih.gov

EXPOSE 8080

ENV JENKINS_HOME /var/jenkins_home

COPY *.yaml /var/jenkins_home/
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false"
