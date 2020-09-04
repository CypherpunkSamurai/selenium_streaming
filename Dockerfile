FROM ubuntu:latest


RUN apt-get -qq update -y && apt-get -qq upgrade -y



#RUN mkdir -p /app/.heroku/ /app/.profile.d
# Install Apache
#RUN curl --silent --location https://lang-php.s3.amazonaws.com/dist-cedar-14-master/apache-$HTTPD_VERSION.tar.gz | tar xz -C /app/.heroku/php


RUN apt -qq install -y curl gnupg2 wget \
    apt-transport-https \
    python3 python3-pip coreutils \
    ffmpeg mediainfo \    
    xvfb xserver-xephyr vnc4server xfonts-base \
    firefox apache2


# Apache
#RUN mkdir /app/www/
#COPY httpd.conf /app/.heroku/etc/apache2/httpd.conf

# Config 
#/var/www/html to /app/www in /etc/apache/apache2.conf
# sed 's_DocumentRoot /var/www/html_DocumentRoot /usr/share/rt3/html/_' /etc/httpd/conf/httpd.conf
COPY httpd.conf /etc/apache2/httpd.conf


COPY requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt

WORKDIR /app

ENV LANG C.UTF-8



# adds files from your Docker client’s current directory.
COPY . .


CMD ["bash", "-c", "start-streaming.sh"]
