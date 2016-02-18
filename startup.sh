#! /bin/bash

cp conf/buildAgent.dist.properties conf/buildAgent.properties
sed -i 's@http://localhost:8111/@'"$TEAMCITY_URL"'@g' conf/buildAgent.properties
sed -i 's@name=@'name="$BUILD_AGENT_NAME"'@g' conf/buildAgent.properties

bin/agent.sh run
