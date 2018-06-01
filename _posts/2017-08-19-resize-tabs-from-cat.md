---
layout: post
title: "How To Resize Tabs Character Output from \"cat\" comand"
category: en
tags: tutorial snippet
---
This command will resize tabs size into 4 character.

```bash
cat filename | expand -t4
```

Change `-t4` with whatever size you want e.g `-t8` for tabs with 8 character.
