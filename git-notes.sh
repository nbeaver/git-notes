# Just in case someone thinks this should be run as a shell command,
# exit immediately.
exit 1
# Show what your global is.
git config --global --list
# or
less ~/.gitconfig

# Modify global config, e.g. change default git push to send only the current branch.
git config --global push.default current

# Show what local config of current repo.
git config --list
# Local config
less .git/config

# Put all files in the staging area ("index"). This action is called "staging".
git add .
# Stage all tracked, modified files
git add --update
# Add a file even if it is listed in .gitignore.
git add -f ignored-file
# Add parts (a.k.a. "chunks") of a file.
git add -p myfile

# See which files are in staging area
git status
# See short summary of status, useful for scripts
git status --porcelain
# Include branch and remote information but still be short
git --short --branch
# See changes between the last commit and what is staged for a commit
git diff --cached
# See changes between the last commit and the working directory, regardless of whether or not they have been staged
git diff HEAD
# See the changes between the working directory and the staging area, i.e. what is changed but not staged for a commit
git diff
# See changes by word.
git diff --word-diff
# See changes by word and wrap long lines
PAGER='' git diff --word-diff
# Or just press -S while viewing diff

# Oops, we didn't want that in the staging area, but we still want to keep the modified copy.
# (Basically the unstage command.)
git reset HEAD myfile.txt
# We want to undo (revert) local changes, erasing the changed file and going back to the last commit.
git checkout myfile.txt

# Commit files in staging area
git commit
# Commit files in staging area and leave a commit message
git commit -m 'message'
# Automatically commit and stage all modified files in directory, even if they haven't been staged.
git commit -am 'message'
# Show the commit history
git log
# Prettier commit history
git log --graph
# Show commits, including the diff
git log -p
# Show all commit, but only the last two commits
git log -p -2
# Show git log, including names of files and if they were modified, added, or deleted.
git log --name-status
# A = Added
# C = Copied
# D = Deleted
# M = Modified
# R = Renamed
# T = have their Type (i.e. regular file, symlink, submodule, ...) changed
# U = Unmerged
# X = Unknown
# B = have had their pairing Broken

# Do a case-insensitive pickaxe search on all commits for the word 'noodles'.
git log -p -S noodles -i

# Fix an incorrect commit message or commit.
git commit --amend

# You can also use -m, but the previous way brings up the previous commit message in your favorite editor.
git commit --amend -m "Fixed message."

# Do a soft reset of last commit
git reset --soft HEAD~1

# Show available branches
git branch

# Name of current branch.
git rev-parse --abbrev-ref HEAD
git symbolic-ref --short HEAD
# http://stackoverflow.com/questions/6245570/how-to-get-current-branch-name-in-git

# Make a new branch
git branch name_of_branch

# Switch to a branch
git checkout name_of_branch

# Make a new branch and switch to it
git checkout -b branch

# Delete a branch
git branch -d name_of_branch

# Rollback to an old commit while staying on the same branch.
# https://stackoverflow.com/questions/2007662/rollback-to-an-old-commit-using-git
git checkout [revision] .

# Remove from git staging area and the working directory permanently.
# If it's in an old commit, though, it will still be there after this.
git rm myfile.txt
# If you just want to remove it from the staging area and leave it in the working directory, use this instead:
git rm --cached myfile.txt
# Or you can remove all text files like this:
git rm --cached \*.txt
# Git will complain if you try to remove a file it doesn't know about. Use this to remove all files:
git rm --cached --ignore-unmatch *
# Or this:
git rm --cached

# Setting up a remote repository on a server. Technically it doesn't have to end with .git, but it's less easily mistaken for a normal directory if you do.
git init --bare tidier-pdfimages.git
# Creates a folder tidier-pdfimages.git/ with the contents of .git/ in a normal repository
# Done for now with the remote machine. Now just add a remote on your laptop (or whatever you want to push to the server with).

#  Add a remote repository
git remote add origin git@github.com:user/repository.git # uses SSH, which is good since you can set up SSH keys instead of entering a password every time.
git remote add origin git@github.com:nbeaver/custom-units.git # example
git remote add origin https://github.com/user/repository.git # uses HTTPS, which will require entering a password a lot.
git remote add chloride ssh://nbeaver@chloride.phys.iit.edu:/home/nbeaver/git-repositories/tidier-pdfimages.git # absolute paths
git remote add chloride nbeaver@chloride.phys.iit.edu:git-repositories/tidier-pdfimages.git # relative paths; you have to drop the leading ssh:// part

# Push to a remote repository (in this case, push the master branch)
git push -u origin master
git push -u chloride master
# Change the url for a remote repository
# It is better to use SSH than https, since you won't have to log in every time, like this:
git remote set-url origin "git@github.com:nbeaver/name-of-repo.git"
# Not this:
git remote set-url origin "https://github.com/nbeaver/name-of-repo.git"
# Show the url for a remote repository without logging in.
git remote show -n origin
# Show all about a remote repository without logging in.
git remote show origin

# List existing remote repositories
git remote
git remote --verbose
git remote -v

# Remove an existing remote called "origin"
git remote rm origin

# List all files ever tracked by the git repository
git ls-tree --full-tree -r HEAD
# List just the files being tracked right now
git ls-files


# Simple merging, e.g. merge into master branch.
git checkout master
git merge my_branch_name
# Pull in only some of the files.
git checkout my_branch_name -- ~/path/to/myfile.txt
# http://stackoverflow.com/questions/610208/how-to-retrieve-a-single-file-from-specific-revision-in-git/610315#610315

# Merging a pull request
git checkout my_branch
# Pull from remote repository and branch
git pull https://github.com/christopherdavidwhite/commutator-table.git master
# Then checkout master and merge if it's good. Finally, push it back to the remote repository of choice, e.g.:
git checkout master
git merge christopherdavidwhite-master
git push origin master

# Easily sync to GitHub pages:
http://brettterpstra.com/2012/09/26/github-tip-easily-sync-your-master-to-github-pages/

# Making a new Github repository from the command line
# http://stackoverflow.com/questions/2423777/is-it-possible-to-create-a-remote-repo-on-github-from-the-cli-without-ssh
curl -u 'nbeaver' https://api.github.com/user/repos -d '{"name":"REPO"}'
# Remember replace USER with your username and REPO with your repository/application name!
git remote add origin git@github.com:nbeaver/REPO.git
git push origin master
# From Github's instructions
git remote add origin git@github.com:nbeaver/pyCV.git
git push -u origin master

# Make a repository via the command line
curl -u 'williamcotton' https://api.github.com/user/repos -d '{"name":"RunLoop"}'
# http://williamcotton.com/how-to-publish-open-source-code

# Pulling from a remote repository.
git clone https://github.com/nbeaver/commutator-table.git
# Pulling over ssh. These both create a folder called 'tidier-pdfimages' with the repository inside; neither creates 'tidier-pdfimages.git' as a folder.
git clone nbeaver@chloride.phys.iit.edu:git-repositories/tidier-pdfimages.git
git clone nbeaver@chloride.phys.iit.edu:git-repositories/tidier-pdfimages

# How to tell someone who just want to see your progress:
# Just clone once and then pull.

# Remove untracked files.
git clean -f
# Do a dry run first.
git clean -fn

# Merge a single file in current branch from another
# https://ochronus.com/git-tips-from-the-trenches/
git checkout <OTHER_BRANCH> -- path/to/file

# See a graphical diff with diffuse
diffuse -m
# See a word diff that suppresses common lines and words (useful for very long lines)
git difftool --extcmd='wdiff -3'
# Throw in a less pager
git difftool --extcmd='wdiff -3la'
# Note that using -S with less will wrap/unwrap lines
# Diff character-by-character
git diff --color-words='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+'
# Use meld
git difftool --tool=meld myfile.txt
# Use diffuse
git difftool -t diffuse myfile.txt

# Get rid of a file from every commit in the current branch as well as deleting it from the current directory.
git filter-branch --tree-filter 'rm -f passwords.txt' HEAD
# Once you're sure you've done the right thing.
rm -rf .git/refs/originals
# Or, to get rid of this error message:
# Cannot create a new backup.
# A previous backup already exists in refs/original/
# Force overwriting the backup with -f
git filter-branch -f --tree-filter 'rm -f passwords.txt' HEAD
# Get rid of a file from every commit in the entire repository as well as deleting it from the current directory.
git filter-branch --tree-filter 'rm -f passwords.txt' HEAD
# http://dalibornasevic.com/posts/2-permanently-remove-files-and-folders-from-a-git-repository

# Get rid of every file except one, and prune the commits that didn't affect that file.
# Warning: may not work if filenames have spaces or special characters.
# Warning: will get rid of your .gitignore.
# TODO: check if this works when files have been renamed.
git filter-branch --prune-empty --index-filter 'git ls-tree -z --name-only --full-tree $GIT_COMMIT | grep -zv "^git-notes.txt$" | xargs -0 git rm --cached -r' -- --all
# http://stackoverflow.com/questions/2797191/how-to-split-a-git-repository-while-preserving-subdirectories

# Now, thoroughly scrub the repo.
git reflog expire --expire=now --all
git gc --aggressive --prune=now
git repack -A -d
# http://stackoverflow.com/questions/10656794/why-do-large-files-still-exist-in-my-packfile-after-scrubbing-them-with-filter

# Archive files
git archive -o latest.zip HEAD
# http://git-scm.com/docs/git-archive#_examples

# Notes on concatenating git repositories.
# http://ben.straubnet.net/post/939181602/git-grafting-repositories
# First, got to more recent repo.
# In this case, the old repo is in ``../old``.
git fetch ../old master:ancient_history
# Note the SHA1 hashes of the oldest on master and the latest on ancient_history.
git rev-list master | tail -n 1
git rev-parse ancient_history
# Now add it to grafts, using >> so it doesn't overwrite exisiting grafts.
echo d7737bffdad86dc05bbade271a9c16f8f912d3c6 463d0401a3f34bd381c456c6166e514564289ab2 >> .git/info/grafts
# Next, convert the grafts into "real history" so git clone works.
# Put the commit history into a file called ``export``.
git fast-export --all > ../export
# Make a new folder to put the shiny new repo into.
mkdir ../nuevo-complete
cd ../nuevo-complete
# Initialize the repo and import the history.
git init
git fast-import < ../export
# I also had to do a git checkout at this point for some reason.
git checkout

# Ignore all vim swap file (.swp, .swo, .swn...)
.*.sw?
# https://stackoverflow.com/questions/4824188/git-ignore-vim-temporary-files

# https://help.github.com/articles/ignoring-files/
git config --global core.excludesfile ~/.gitignore_global

# Check the repo for errors.
git fsck
# If you've got a lot of dangling blobs and are impatient:
git gc --prune="0 days"
# https://stackoverflow.com/questions/9955713/git-dangling-blobs

# Show SHA1 of last commit.
git rev-parse HEAD
# Verify it's correct.
git rev-parse --verify HEAD
# Show shortened version.
git rev-parse --short HEAD
# http://stackoverflow.com/questions/949314/how-to-retrieve-the-hash-for-the-current-commit-in-git
# http://stackoverflow.com/questions/5694389/get-the-short-git-version-hash

# Show version string and part of SHA1.
git describe --tags
# http://stackoverflow.com/questions/5694389/get-the-short-git-version-hash

# Simple workflow without collaborators.
# On branch master.
git checkout -b develop
# ... do work, make commits.
git checkout master
git merge develop
git checkout develop
# http://nvie.com/posts/a-successful-git-branching-model/

# Make a GitHub pages website.
# Starting from master branch:
git checkout -b gh-pages
git remote add origin git@github.com:nbeaver/user-supplied-ad-preferences.git
git push -u origin gh-pages
git branch -d master
xdg-open http://nbeaver.github.io/user-supplied-ad-preferences
# If you want to keep the master branch,
# set Github's default branch to be "gh-pages".
# https://pages.github.com/
# http://www.xanthir.com/b4Zz0
# Otherwise, remove the master branch.


# Show oldest commit (probably).
git rev-list HEAD | tail -n 1

# Show root commit(s).
git rev-list --max-parents=0 HEAD

# Show date of a commit in a standard format.
git show -s --format=%ci 144feb8bb29a4e1031cf188403a614c9f4ee8838

# Combine the two.
git show -s --format=%ci "$(git rev-list --max-parents=0 HEAD)"
