FROM amazonlinux:latest

#Install dependencies


RUN yum update -y && yum install httpd -y
    
#Expose port 80 on the container
EXPOSE 80

# set the default application that will start when the container start
ENTRYPOINT ["usr/sbin/httpd", "-D", "FOREGROUND"]

