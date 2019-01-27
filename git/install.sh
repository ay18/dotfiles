ssh-keygen -t rsa -b 4096 -C $EMAIL
pbcopy < ~/.ssh/id_rsa.pub
