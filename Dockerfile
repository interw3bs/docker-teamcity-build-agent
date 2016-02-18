FROM java:8-jre
MAINTAINER Michel Albers <m.albers@interwebs-ug.de>

WORKDIR /opt/buildagent

ADD buildAgent.zip /opt/buildagent/
ADD startup.sh /usr/local/bin/startup
RUN chmod +x /usr/local/bin/startup
RUN unzip -qq buildAgent.zip && rm -f buildAgent.zip
RUN chmod +x bin/agent.sh

# Install node.js
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_0.10 | bash -
RUN apt-get install -y nodejs

# Install standard node package managers
RUN npm i -g gulp grunt-cli bower 

# Install meteor
RUN curl https://install.meteor.com/ | sh

# Install php and composer
RUN apt-get install -y php5-cli php5-gd php5-mcrypt
RUN mkdir -p /opt/composer

# Install Composer
WORKDIR /opt/composer
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
RUN php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === 'fd26ce67e3b237fffd5e5544b45b0d92c41a4afe3e3f778e942e43ce6be197b9cdc7c251dcde6e2a52297ea269370680') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); }"
RUN php composer-setup.php -- --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

# Install build essentials, rsync and unzip
RUN apt-get install -y build-essential rsync unzip

# Install pip and aws tools
WORKDIR /opt/pip
ADD https://bootstrap.pypa.io/get-pip.py ./
RUN python get-pip.py
RUN pip install awscli

WORKDIR /opt/buildagent

CMD ["startup"]
