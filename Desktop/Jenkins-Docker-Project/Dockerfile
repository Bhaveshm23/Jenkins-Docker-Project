FROM ubuntu:latest
WORKDIR /app
COPY . /app
#installing python
RUN apt-get -y update && apt-get install -y python
# RUN app.py when container launches
CMD ["python", "app.py"]
