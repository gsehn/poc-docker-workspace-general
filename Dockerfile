FROM ubuntu:18.04

ARG USER
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

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
  golang \
  locales

RUN locale-gen en_US.UTF-8

# Create user and home
RUN useradd -m $USER
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers
RUN cat /etc/sudoers
USER ${USER}
WORKDIR /home/${USER}

# Copy assets to home (i.e. .bashrc, .bash_aliases, etc)
COPY --chown=guenther.sehn assets/. .
RUN chmod +x entrypoint.sh

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
RUN mkdir ~/.aws

RUN go build git-prompt.go

# Install Homebrew
RUN yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
# RUN test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
# RUN test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# RUN test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
# RUN echo "eval \$($(brew --prefix)/bin/brew shellenv)" >> ~/.bashrc

# AWS SAM
RUN /home/linuxbrew/.linuxbrew/bin/brew tap aws/tap
RUN /home/linuxbrew/.linuxbrew/bin/brew install aws-sam-cli

ENTRYPOINT [ "./entrypoint.sh" ]