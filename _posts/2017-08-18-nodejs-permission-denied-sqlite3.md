---
layout: post
title: "NodeJS Permission Denied When Installing \"sqlite3\" Module"
category: en
tags: nodejs troubleshooting
---
I'm trying to create a nodejs app using sqlite as database storage. The problem is I got error message that looks like this

```bash
...

> node-pre-gyp install --fallback-to-build

sh: 1: node-pre-gyp: Permission denied
npm ERR! Linux 3.16.0-30-generic
npm ERR! argv "node" "/usr/bin/npm" "install"
npm ERR! node v0.10.33
npm ERR! npm  v2.5.0
npm ERR! code ELIFECYCLE

...
```

At a glance this seems to be simple permission error. But even after using `sudo` command I still got error when trying to run the app. Even though `sqlite3` module got successfully installed, the error occurred when trying to run the app.

After spend whole day to figure it out, I stumble this [github issue](https://github.com/jansmolders86/mediacenterjs/issues/191). According to [**dashko**](https://github.com/jansmolders86/mediacenterjs/issues/191#issuecomment-101188637) the problem is from partition mounting using `user` flag in `fstab`. My previous *fstab* looks like this

```bash
...

UUID=14AE1D30AE1D0C3C   /my/mount/point  ntfs-3g  auto,users,permissions  0  0

...
```

So I remove the `users` flag from `fstab` to become like this and reboot my system.

```bash
...

UUID=14AE1D30AE1D0C3C   /my/mount/point  ntfs-3g  auto,permissions  0  0

...
```

Trying to follow tutorial from [this site](https://www.npmjs.com/package/sqlite3) and this time I got no error and my app successfully running.

## Reference

- https://github.com/jansmolders86/mediacenterjs/issues/191#issuecomment-101188637
- https://www.npmjs.com/package/sqlite3
