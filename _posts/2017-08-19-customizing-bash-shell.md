---
layout: post
title: "Customizing Bash Terminal - A Backup Snippet"
category: en
tags: snippet
---
## Add Git Branch Name Into PS1

```bash
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;34m\]\h\[\033[01;30m\]\$(parse_git_branch)\[\033[00m\]: "
```

> **Preview Inside Git Repostory**

> ![Inside Git Repository](https://i.imgur.com/d7ZvrK0.png)

## Show Current Directory in Title Bar

```bash
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
```

> **Preview Current Directory on Title Bar**

> ![Outside Git Repository](https://i.imgur.com/0cbxM9w.png)

Instead of showing full path in title bar (`PROMPT_COMMAND`), we will replace our home directory name with `~` character. First we need to get current path with variable `PWD`, then replace home directory name with `~` character.

```bash
# This function will generate current directory name with '~' as replacement
# of home directory name
render_title() {
    # note that instead of '/' character, we use '#' character as separator
    # of sed command
    echo ${PWD} | sed -e "s#${HOME}#~#g"
}

# Now we call function above into PROMPT_COMMAND
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: $(render_title)\007"'
```

> **The Result**

> ![Home Directory Replacement](https://i.imgur.com/ZTAnXst.png)

## My Full ".bashrc" file related to PS1 and PROMPT_COMMAND

```bash
# git branch parser
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# color code
blue() {
    echo "\[\033[01;34m\]"
}
cyan() {
    echo "\[\033[01;36m\]"
}
gray() {
    echo "\[\033[01;30m\]"
}
green() {
    echo "\[\033[01;32m\]"
}
reset() {
    echo "\[\033[00m\]"
}

# formatting
bold() {
    echo "\e[1m"
}
dim() {
    echo "\e[2m"
}

# actual PS1
export PS1="$(cyan)[\t] $(green)\u$(reset)@$(blue)\h$(gray)\$(parse_git_branch): $(cyan)\e[95m\e[2m[\w]$(reset)\n\\$ "

# change ${HOME} with '~'
render_title() {
    echo ${PWD} | sed -e "s#${HOME}#~#g"
}

# actual prompt command
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:$(render_title)\007"'
```
### Final result

> ![Final result](https://i.imgur.com/slLSjCG.png)

### Reference

- https://coderwall.com/p/fasnya/add-git-branch-name-to-bash-prompt
