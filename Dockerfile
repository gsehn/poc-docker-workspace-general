FROM ubuntu:18.04

ARG USER

# Update packages and install basics
RUN apt-get update
RUN apt-get install -y \
  git \
  vim \
  wget \
  openssl \
  unzip \
  curl \
  sudo \
  make \
  xclip \
  less \
  python3 \
  python3-pip \
  golang

# Create user and home
RUN useradd -m $USER
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers
RUN cat /etc/sudoers
USER ${USER}
WORKDIR /home/${USER}

# Copy assets to home (i.e. .bashrc, .bash_aliases, etc)
COPY --chown=guenther.sehn assets/. .

# Install - Terraform
RUN wget https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
RUN unzip terraform*.zip
RUN sudo mv terraform /usr/local/bin/
RUN terraform --version 

# Install - Node Manager (n) and latest Node version
ENV N_PREFIX=/home/${USER}/n
RUN curl -L https://git.io/n-install > install_n.sh
RUN chmod +x install_n.sh
RUN yes | ./install_n.sh
RUN export PATH=$PATH:/home/$(whoami)/n/bin

# Install - AWS CLI
# RUN chown -R guenther.sehn /home/${USER}
RUN sudo pip3 install awscli --upgrade

RUN go build git-prompt.go

ENTRYPOINT [ "/bin/bash" ]