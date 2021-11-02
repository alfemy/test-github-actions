FROM nginx


# Upgrade everything
RUN apt-get update && apt-get upgrade -y

# nginx site conf
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx-site.conf /etc/nginx/sites-available/default

# Add website
COPY /www /usr/share/nginx/html

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]