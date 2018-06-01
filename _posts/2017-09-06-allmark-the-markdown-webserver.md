---
layout: post
title: "How To Install Allmark - The Markdown Webserver"
tags: markdown-server
---
allmark is a fast, standalone markdown web server for Linux, Mac OS and Windows written in go.

allmark is a file-system-centric markdown web server. You can **point it at any directory that contains markdown files** and it will immediately start a web-server that serves the rendered HTML content of the markdown file to you.

### Step 1 — Installing allmark webserver

- Download the binary file from [this page](http://allmark.io/bin)
- Select the right version based on your system. If you use desktop computer, you may have 64bit system
- Use `chmod` to add execute permission.
- Copy the downloaded file to `/usr/local/bin/allmark`

All that step can be written to

```bash
curl http://allmark.io/bin/files/allmark_linux_amd64 > allmark
chmod +x allmark
sudo mv allmark /usr/local/bin/allmark
```

## Step 2 — Running allmark webserver

It is recommended to setup configuration wether globally (in your home directory) or locally (on your repository). In this guide, we will config allmark to local repository. Run this command to generate allmark settings.

- Change to your (clonned) repository
- Init the setting command

```bash
cd path/to/your/repository
allmark init
```

- Open `.allmark/config` file with your text editor and search the following line and change the "Enabled" key to `true` to enabling livereload when we are editing the content.

```json
...

"LiveReload": {
    "Enabled": true
},
...

```

- Start allmark server with command. This will automatically open new page on your default web browser to show the content. If not, please open `htttp://localhost:33001` on your browser.

```bash
allmark serve
```

- Now you can start editing the markdown file on your repository.

> **Note :** if you have rename/add/delete file/folder on your repository, you may need to restart your allmark webserver for those changes to take effect.

## Step 3 — Stopping and Restarting allmark webserver

If you want to stop or restart allmark webserver, simply to press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the server. And type command `allmark serve` then press <kbd>Enter</kbd> to start server again.

## Reference

- https://github.com/andreaskoch/allmark
