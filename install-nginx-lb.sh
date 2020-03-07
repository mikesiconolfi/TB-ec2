#!/bin/bash
sudo apt -y update
#sudo apt -y upgrade
sudo apt -y install nginx
sudo systemctl start nginx
sudo systemctl enable nginx

sudo cat <<EOM > /etc/nginx/sites-available/default
upstream web {
    zone web 64k;
    server web1.siconolfi.ca;
    server web2.siconolfi.ca;
}

server {
    listen              80;
    #ssl_certificate     /etc/nginx/ssl/company.com.crt;
    #ssl_certificate_key /etc/nginx/ssl/company.com.key;
    #ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;

    location / {
        proxy_pass         http://web;
        proxy_http_version 1.1;
        proxy_set_header   Connection "";
    }
}
EOM
sudo systemctl restart nginx