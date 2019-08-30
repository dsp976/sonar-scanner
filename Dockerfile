FROM centos


## Install git, unzip

RUN yum install -y git unzip

ENV GIT_REPO="https://github.com/SonarSource/sonar-scanning-examples.git" \
    GIT_LOCAL="/tmp/sonar-scanning-examples/"


## Install SonarScanner

ENV INSTALLER="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.0.0.1744-linux.zip" \
    SONAR_HOME="/opt/sonar-scanner" \
    SONAR_HOST="http://10.111.188.35:9000" \
    PROJECT_KEY=test_project \
    SONAR_LOGIN=81e217fe2778926bda265861e0006af92055afbe \
    SRC="/tmp/sonar-scanning-examples/sonarqube-scanner/src/python" 

ENV PATH=$SONAR_HOME/bin:$PATH

WORKDIR /tmp
ADD $INSTALLER /tmp

RUN unzip -q sonar-scanner-cli-*-linux.zip && \
    rm sonar-scanner-cli-*-linux.zip && \
    mv sonar-scanner-*-linux $SONAR_HOME && \
    echo "sonar.host.url=$SONAR_HOST" >> $SONAR_HOME/conf/sonar-scanner.properties 


## Startup scanner
    
COPY scanner.sh /scanner.sh

ENTRYPOINT ["/scanner.sh"]
