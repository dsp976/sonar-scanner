FROM centos

#RUN yum install -y git java-11-openjdk 

#ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk/jre \
#    CLASSPATH=. \
#ENV PATH=$JAVA_HOME:$PATH


## Install git, unzip

RUN yum install -y git unzip

ENV GIT_REPO="https://github.com/SonarSource/sonar-scanning-examples.git" \
    GIT_LOCAL="/tmp/sonar-scanning-examples/"


## Install SonarScanner

ENV INSTALLER="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.0.0.1744-linux.zip" \
    SONAR_HOME="/opt/sonar-scanner" \
    SONAR_HOST="http://localhost:9000" \
    PROJECT_KEY=test_project \
    SRC="/tmp/sonar-scanning-examples/sonarqube-scanner/src/python" 

ENV PATH=$SONAR_HOME/bin:$PATH

WORKDIR /tmp
ADD $INSTALLER /tmp
#ADD sonar-scanner-4.0.0.1744-linux $SONAR_HOME

RUN unzip -q sonar-scanner-cli-*-linux.zip && \
    rm sonar-scanner-cli-*-linux.zip && \
    mv sonar-scanner-*-linux $SONAR_HOME && \
    echo "sonar.host.url=$SONAR_HOST" >> $SONAR_HOME/conf/sonar-scanner.properties 


## Startup scanner
    
COPY scanner.sh /scanner.sh

ENTRYPOINT ["/scanner.sh"]
