# https://hub.docker.com/_/httpd
FROM httpd:2.4

RUN apt-get update && apt-get install -y libapache2-mod-python

# Temporary dev tools (temporary dependencies)
RUN apt-get install -y curl vim


RUN MOD="$(cat /etc/apache2/mods-available/python.load)" \
  perl -i -pe 's/^<IfModule unixd_module>$/"$ENV{MOD}\n\n$_"/e' \
  /usr/local/apache2/conf/httpd.conf

RUN mkdir /var/www && echo '\n\
Alias "/service" "/var/www"\n\
<Directory /var/www/>\n\
    Options Indexes FollowSymLinks MultiViews\n\
    AllowOverride All\n\
    Order allow,deny\n\
    Allow from all\n\
    Require all granted\n\
    AddHandler mod_python .py\n\
    PythonHandler example\n\
    PythonDebug On\n\
</Directory>\n\
' >> /usr/local/apache2/conf/httpd.conf

# Temporary dev config
RUN echo "alias conf='vim /usr/local/apache2/conf/httpd.conf +$'" >> ~/.bashrc
RUN echo "alias get='curl http://localhost/service/example.py'" >> ~/.bashrc

