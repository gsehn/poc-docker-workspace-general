docker run \
  -it \
  --rm \
  --privileged \
  --env-file .env \
  -v ~/gd/poc:/home/$USER/poc \
  -v ~/workspaces:/home/$USER/workspaces \
  -v ~/.ssh:/home/$USER/.ssh:ro \
  -v ~/Library/Caches/Yarn:/home/$USER/.cache/yarn \
  -v ~/.gitconfig:/home/$USER/.gitconfig \
  -v /var/run/docker.sock:/var/run/docker.sock \
  workspace-general:latest
