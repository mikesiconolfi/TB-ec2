#!/bin/bash
sudo apt -y update
#apt -y upgrade
sudo apt -y install nginx
sudo systemctl start nginx
sudo systemctl enable nginx
curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
sudo npm -g install pm2
npm install express --save

sudo cat <<EOM > /home/ubuntu/ecosystem.config.js
module.exports = {
  apps : [{
    name: 'Node App',
    script: '/home/ubuntu/nodeapp/current/app.js',

    // Options reference: https://pm2.keymetrics.io/docs/usage/application-declaration/
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production',
      VERSION: "1.0.0"
    }
  }],

  deploy : {
    production : {
      user : 'ubuntu',
      host : 'localhost',
      ref  : 'origin/master',
      repo : 'https://github.com/mikesiconolfi/TB-webapp.git',
      path : '/home/ubuntu/nodeapp',
      'post-deploy' : 'npm install && npm install express --save && pm2 reload ecosystem.config.js --env production'
    }
  }
};
EOM

sudo cat <<EOM > /etc/nginx/sites-available/default
server {
        listen              80;
        #ssl_certificate     /etc/nginx/ssl/company.com.crt;
        #ssl_certificate_key /etc/nginx/ssl/company.com.key;
        #ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
       
        location / {
            proxy_pass         http://localhost:3000/;
            proxy_http_version 1.1;
            proxy_set_header   Connection "";
        }
    }
EOM

sudo systemctl restart nginx
sudo chown ubuntu:ubuntu /home/ubuntu/ecosystem.config.js
pm2 deploy /home/ubuntu/ecosystem.config.js production setup
pm2 startOrRestart /home/ubuntu/ecosystem.config.js --env production
