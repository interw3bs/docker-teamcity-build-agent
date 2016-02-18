# Jetbrains Teamcity Build Agent

Contains a build agent for use in conjunction with teamcity. 

You **must** specify these environment variables:

- ```TEAMCITY_URL``` (e.g. http://<teamcity-link-alias>:8111)
- ```BUILD_AGENT_NAME``` (e.g. Worker-1)

This image comes bundled with node.js 0.10.42 as well as Meteor 1.2. 

## Example run command

> docker run -d --link teamcity:teamcity -e BUILD_AGENT_NAME=ChuckNorris -e TEAMCITY_URL=http://teamcity:8111 interwebs/teamcity-build-agent
