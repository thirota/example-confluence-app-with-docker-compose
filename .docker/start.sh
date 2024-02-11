#!/bin/bash

mkdir -p /opt/atlassian/confluence/confluence/WEB-INF/atlassian-bundled-plugins/
cp /opt/quickreload.properties /var/atlassian/application-data/confluence/quickreload.properties
cp /opt/quickreload-5.0.2.jar /opt/atlassian/confluence/confluence/WEB-INF/atlassian-bundled-plugins/quickreload-5.0.2.jar
chown -R confluence:confluence /var/atlassian/application-data/confluence

/entrypoint.py