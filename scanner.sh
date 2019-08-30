#!/bin/bash

while true
do
	rm -fr $GIT_LOCAL
	git clone $GIT_REPO $GIT_LOCAL 
	sonar-scanner \
	  -Dsonar.projectKey=$PROJECT_KEY \
	  -Dsonar.sources=$SRC \
	  -Dsonar.host.url=$SONAR_HOST \
	  -Dsonar.login=$SONAR_LOGIN
	sleep 300
done
