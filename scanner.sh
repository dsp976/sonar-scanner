#!/bin/bash

while true
do
	rm -fr $GIT_LOCAL
	git clone $GIT_REPO $GIT_LOCAL #&& \
	sonar-scanner -h
	sonar-scanner -Dsonar.projectKey=$PROJECT_KEY -Dsonar.sources=$SRC
	sleep 60
done
