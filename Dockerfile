FROM nginx:1.9

RUN mkdir /etc/nginx/sites-available &&\
    mkdir /etc/nginx/sites-enabled &&\
    touch /etc/nginx/sites-enabled/default

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list
RUN apt-get update
RUN apt-get install -y hhvm
RUN /usr/share/hhvm/install_fastcgi.sh

COPY assets/nginx.default.conf /etc/nginx/sites-available/default.conf
RUN sed -i "s/.*conf\.d\/\*\.conf;/&\n    include \/etc\/nginx\/sites-enabled\/\*;/" /etc/nginx/nginx.conf
RUN unlink /etc/nginx/sites-enabled/default
RUN ln /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.original

RUN apt-get install -y monit
COPY assets/monit.monitrc /etc/monit/conf.d/monitrc
COPY assets/monit.nginx.conf /etc/monit/conf.d/nginx.conf
COPY assets/monit.hhvm.conf /etc/monit/conf.d/hhvm.conf

CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]
#CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
