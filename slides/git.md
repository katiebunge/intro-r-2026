---
title: "Version Control: `git` Good"
subtitle: "*from PSU TREC's Intro to R Workshop*"
author: "Iris Rademacher"
date: "March 18th, 2026"
---

# Introduction

## [Version control](https://en.wikipedia.org/wiki/Version_control)

### TL;DR

> Version control refers to keeping track of changes made to computer files over time.

### Examples

* MS Word's Track Changes
* Google Docs' View History
* Big_Project-FINAL (1).docx

## Version Control System (VCS)

### TL;DR

> A VCS is a piece of software that automates various aspects of version control.

### Change management

A VCS can help answer questions about your code, such as:

* What changes have been made?
* When?
* By whom?
* Why?

> It is common when writing software to make a change to the code, then realize it has stopped working in some way but you don't remember exactly what you changed.

### Collaboration and communication

VCS workflows can facilitate documentation and attribution. For example:

* A change often requires a human-written description
* Changes are associated with the name and contact information of their author
* You can keep track of multiple versions of the code at once and move work between them

> Be kind to your future self, as you may be your own most frequent collaborator! When documenting your changes, try to include all the information you will want to know when you are revisiting this project three months from now.

## [`git`](https://git-scm.com/)

### TL;DR

> `git` is a VCS in the form of a program that keeps track of changes made to all files in a given folder. It is primarily used to access past versions of files or combine different versions of them that have had changes made in parallel.

### History lesson

* Open source software originally written by Linus Torvalds
* Designed as a version control solution for the Linux kernel
* Widely adopted by people who code for a living

### Interface

`git` is intended to be used from the command line, but point-and-click-style (and adjacent) clients also exist. For example:

* [GitHub Desktop](https://github.com/apps/desktop)
* [RStudio (!)](https://docs.posit.co/ide/user/ide/guide/tools/version-control.html#getting-started)

## [GitHub](https://docs.github.com/en)

### TL;DR

> GitHub is a cloud provider for storing and looking at code that you are managing with `git`.

### History lesson

* Originally its own company, now owned by Microsoft 
* Known for hosting the code for many open source projects

### Features

GitHub has visual tools for:

* Collaboration
* Project management
* User support
* Building runnable software from code

### Alternatives

There are other `git` cloud providers out there that are less ... vertically-integrated. Some of them are even open source projects themselves!

* [GitLab](https://docs.gitlab.com/)
* [Codeberg](https://docs.codeberg.org/)

These platforms often have [instructions](https://docs.gitlab.com/user/project/import/github/) for [moving your code over](https://docs.codeberg.org/advanced/migrating-repos/) from GitHub.

## Command line

### TL;DR

> The command line is a way of giving your computer instructions by typing them out (effectively, writing short programs, or "scripts"). This can be more efficient and make automation easier than navigating a point-and-click UI, but worse for more visual use cases.

# `git` workflow

## Command line basics

Let's take a look at some common commands that are included with `bash`.

### Access

* Windows
  * `Start Menu > Git Bash`
    * This is an emulation of the command line that is installed by default on macOS and Linux
    * Windows has its own command prompt but it is harder to use with `git`
* macOS
  * `Spotlight Search (Cmd+Space) > Terminal`
* Linux
  * You know what you're doing (if you don't, `"Windows" key > Terminal`, probably)

> Hint: Press `Tab` to try and autocomplete a command or filename you have started typing out.

### Navigation

```bash
# Prints a list of the files in the current folder
ls
# Prints the name of the current folder
pwd
# Moves to the given folder
cd my-folder/sub-folder
# . means the current folder
ls .
# .. means the parent folder of the current folder
cd ..
```

### File inspection

```bash
# Prints the contents of the given file
cat foo.txt
# Prints the given string
echo "hello"
# Prints the value of the variable VAR
echo $VAR
```

### File manipulation

> DANGER!!! It is relatively easy to **permanently** overwrite or delete files using these commands. Approach with care, and don't be afraid to ask for help.

```bash
# Copies the given file to the given folder or destination file 
cp file1 my-folder/
cp file1 my-folder/copied-file
# Moves the given file to the given folder or destination file
mv file1 my-folder/
mv file1 my-folder/renamed-file
# Deletes the given file
rm file1
```

> If a destination file that already exists is provided to `cp` or `mv`, it will be overwritten. Files overwritten by `cp` or `mv` or deleted by `rm` are not sent to the Trash, but instead fully erased.

## `git` vocabulary

* Repository: a folder that `git` is keeping track of
  * Root: the base folder of the repository
* Commit: a snapshot of all the files in the repository at a given time
* Branch: a name (e.g. `main`) referring to a commit
  * Default branch: the branch that is considered "canonical"
* Fork: a copy of an entire repository (including e.g. past commits)
* Remote: a URL pointing to another copy of the repository
  * Upstream: the "canonical" copy of the repository

## GitHub setup

### New repository

* Click on your profile icon in the top right
* Select `Repositories` from the dropdown
* Click the `New` button near the top right

### Existing repository

* Navigate to the repository
* Click the `Fork` button near the top right
* On the next page, click the `Create fork` button

### Download code (1/2)

> This approach requires that you have [set up an SSH key for GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

* Navigate to the repository
* Click the green `Code` button near the top right
* switch to the `SSH` tab
* Copy the link

## Command line setup

### Configure `git`

```bash
git config --global user.name "Firstname Lastname"
# Should match the email you used when signing up for GitHub
git config --global user.email "email@example.com"
```

### Download code (2/2)

```bash
# cd to the folder where you would like to put your copy of the repository (as a subfolder)
cd my-repositories
# Creates a subfolder with your copy of the repository with the same name as the repository
git clone git@github.com:my-username/intro-r-2026
```

### Configure upstream

```bash
# Registers the main repository locally under the name "upstream"
git remote add upstream git@github.com:PSUTrec/intro-r-2026
# Gets a local copy of the main repository's branches (doesn't automatically reconcile your changes with them)
git fetch upstream
```

## Updating the code

### Inspecting changes

```bash
# What files have changed since the last commit
git status
# What changes have been made within those files
git diff
# If you have already run git add on some files, they will only show up as "staged"
git diff --staged
```

### Looking at history

```bash
# Lists commit messages and authors
git log
# Adds in a diff-like view of the changes for each commit
git log -p
# Commit name and author name that last modified each line of the file
git blame my-file
```

### Switching to a branch

```bash
# Creates a new branch that will be kept separate from the default one
git switch -c my-branch
# Switches to an existing branch
git switch main
```

### Creating a commit

```bash
# Adds this entire folder to the list of things to commit
git add .
# Adds a single file
git add my-file
# Saves a snapshot of all added files as they currently are
git commit -m "a short description of the changes"
```

### Syncing your work

```bash
# Switch to whatever branch your work is on
git switch my-branch
# Get the latest changes from the main repository
git fetch upstream main
# Combine your code with the code in the main repository automatically
git merge upstream/main
# Sends a copy of your current branch to your fork on GitHub
git push origin HEAD
```

> If the output of `git merge` tells you there are merge conflicts, you can resolve them by editing the files with a text editor and reconciling the differences yourself

## Contributing changes on GitHub

* Navigate to your fork on GitHub
* Click the `Contribute` button above the list of files in the repository
* Click the `Open pull request` button in the dropdown
* Write up a description of your changes
* Click the `Create pull request` button
* Someone with the correct permissions on the repository can then approve your changes, or request that you make even more changes before they accept them

# Demonstration

Let's take a look at some of this in action.

# Activity

> Try to do the following exercises with a partner (each of you should do each step). Consult the slides as needed, and please ask for help if you get stuck!

* Make a fork of the `PSUTrec/intro-r-2026` repository on GitHub
* Clone it to your computer
* Make some changes on the `main` branch
* Push them to your fork
* Create a pull request targeting your partner's fork
* Approve your partner's changes and merge them into your fork's `main` branch

# Appendices

## Further reading

* [Common `git` patterns/workflows](https://happygitwithr.com/workflows-intro)
* [Resolving merge conflicts](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-using-the-command-line)
* [Exporting R Markdown files for GitHub](https://rmarkdown.rstudio.com/github_document_format.html)
* [Rendering Quarto files with GitHub Pages](https://quarto.org/docs/publishing/github-pages.html)

## How can I turn this Markdown file into an HTML slideshow?

You will need to [install `pandoc`](https://pandoc.org/installing.html). This varies in difficulty across operating systems and installation methods, so I would encourage you to take a break, approach from a different direction, and/or ask for help if you get stuck.

Once you have `pandoc`, run the following `bash` commands from the root of the repository:

```bash
mkdir -p slides/output
pandoc -t slidy \
  --template slides/template.html \
  --slide-level=3 \
  --embed-resources \
  --standalone \
  -o slides/output/git.html \
  slides/git.md
```

You can then [view the HTML file in a web browser](https://www.geeksforgeeks.org/html/how-to-access-an-html-document-in-a-browser/), and print it to a PDF if you would like.
