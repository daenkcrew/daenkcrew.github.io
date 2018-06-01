---
layout: post
title: How to Select Fastest Ubuntu Repository Mirror
tags: ubuntu mirror
---
Ubuntu has so many mirror repository we can choose. Sometimes the mirror exists in our country that near with our internet provider.

## Update

> Thank to [this answer][answer] on askubuntu.com we can automatically select fastest (maybe) mirror based on our geographic location.

This configuration will automatically select best mirror based on our geographic location. However, this doesn't necessary mean the fastest server. Add following entry at the top of `/etc/apt/source.list` file. You may delete other entry if you wish.

```shell
deb mirror://mirrors.ubuntu.com/mirrors.txt xenial main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-updates main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-backports main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-security main restricted universe multiverse
```

Change `xenial` part with your ubuntu version such as *trusty, artful, bionic*.

---

> The following is for other option to select ubuntu mirror.

## Requirements

- Python with pip package manager
- Internet connection (obviously)

## Installation

- Installation from pip (python package manager)

```shell
sudo pip install apt-select
```

- Manual installation with git

```shell
git clone https://github.com/jblakeman/apt-select
python apt-select/setup.py install
```

[apt-select-repo]: https://github.com/jblakeman/apt-select

## Usage

Open terminal and run `apt-select` command. By default, if country code is not provided it will select mirror from US (united stated). Available options are:

```
usage: apt-select [-h] [-C [COUNTRY]] [-t [NUMBER]] [-m [STATUS] | -p]
                  [-c | -l]

Find the fastest Ubuntu apt mirrors.
Generate new sources.list file.

optional arguments:
  -h, --help            show this help message and exit
  -C [COUNTRY], --country [COUNTRY]
                        specify a country to test its list of mirrors
                        used to match country list file names found at mirrors.ubuntu.com
                        COUNTRY should follow ISO 3166-1 alpha-2 format
                        default: US
  -t [NUMBER], --top-number [NUMBER]
                        specify number of mirrors to return
                        default: 1
  -m [STATUS], --min-status [STATUS]
                        return mirrors with minimum status
                        choices:
                           up-to-date
                           one-day-behind
                           two-days-behind
                           one-week-behind
                           unknown
                        default: up-to-date
  -p, --ping-only       rank mirror(s) by latency only, disregard status(es)
                        cannot be used with -m/--min-status
  -c, --choose          choose mirror from a list
                        requires -t/--top-num NUMBER where NUMBER > 1
  -l, --list            print list of mirrors only, don't generate file
                        cannot be used with -c/--choose
```

Copy the generated file into `/etc/apt/source.list`.

```shell
# Backup current sources.list
cp /etc/apt/sources.list /etc/apt/sources.list.backup

# Copy the generated file
cp sources.list /etc/apt/sources.list
```

[answer]:https://askubuntu.com/a/9035/562900
