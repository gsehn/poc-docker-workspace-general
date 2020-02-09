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
  direnv \
  apt-utils \
  software-properties-common \
  groff \
  locales

RUN add-apt-repository ppa:git-core/ppa
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt update -y
RUN apt upgrade -y
RUN apt install git -y

RUN locale-gen en_US.UTF-8

# Install Docker
RUN curl -sSL https://get.docker.com/ | sh

# Recognize shared SSH keys
RUN echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config


# Create user and home
RUN useradd -m $USER
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers
RUN usermod -aG docker ${USER}
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

# Install - AWS CLI
RUN sudo pip3 install awscli --upgrade
RUN mkdir ~/.aws

# Compile my favorite git-prompt tool
RUN go build git-prompt.go

# Install Homebrew
RUN yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

# AWS SAM
RUN /home/linuxbrew/.linuxbrew/bin/brew tap aws/tap
RUN /home/linuxbrew/.linuxbrew/bin/brew install aws-sam-cli

# Install - Node Manager (n) and latest Node version
ENV N_PREFIX=/home/${USER}/n
RUN curl -L https://git.io/n-install > install_n.sh
RUN chmod +x install_n.sh
RUN yes | ./install_n.sh
RUN export PATH=$PATH:/home/$(whoami)/n/bin

# Install - Node - TypeScript
RUN PATH=$PATH:/home/$(whoami)/n/bin npm i -g typescript

# Install - Global - Yarn 1.X
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt update && sudo apt install --no-install-recommends yarn -y

EXPOSE 3000

ENTRYPOINT [ "./entrypoint.sh" ]