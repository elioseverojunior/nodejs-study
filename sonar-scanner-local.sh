sonar-scanner \
  -Dsonar.projectKey=nodejs-study \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=$SONAR_TOKEN \
  -Dsonar.branch.name=master \
  -Dsonar.branch.target=master