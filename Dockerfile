FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get install -y git
RUN apt-get install -y terraform

ENTRYPOINT [ "/bin/bash" ]