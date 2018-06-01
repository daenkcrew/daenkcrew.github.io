---
layout: post
author: daenkcrew
category: en
tags: linux security
---
The purpose of this configuration is to disable ssh login using password and force user to use `ssh-key` pair instead.
Open `/etc/ssh/sshd_config` file using text editor and change following option.

```bash
PermitRootLogin no          # prevent root login via ssh
PasswordAuthentication no   # deny ssh login using password
PubkeyAuthentication yes    # enable public key authentication

# Explicitly define which user can login via ssh (optional)
# AllowUsers root otheruser
```

> Note: if the option is commented, delete '**#**' at the start of line to enable the option.

After we done editing config file, we need to restart `sshd` service. On ubuntu/debian based distro, we can use command

```bash
sudo service sshd restart
```
