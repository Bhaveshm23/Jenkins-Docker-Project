FROM ubuntu:latest
WORKDIR /app
COPY . /app
#installing python
RUN apt-get -y update && apt-get install -y nginx
# RUN app.py when container launches
CMD ["echo", "Image created"]
