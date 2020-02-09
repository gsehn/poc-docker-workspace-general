#!/bin/bash

# AWS Credentials
cat <<EOT >> ~/.aws/credentials
[default]
aws_access_key_id=$AWS_ACCESS_KEY_ID
aws_secret_access_key=$AWS_SECRECT_ACCESS_KEY
EOT

cat <<EOT >> ~/.aws/config
[default]
region=$AWS_REGION
output=json
EOT

cat <<EOT >> ~/.ssh/config
Host *
   AddKeysToAgent yes
   IdentityFile ~/.ssh/id_rsa
EOT

echo ■ Starting ssh-agent
eval $(ssh-agent)
echo ■ Adding ssh keys
ssh-add
echo

sudo chmod 666 /var/run/docker.sock

/bin/bash