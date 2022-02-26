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

# Unstage those chunks interactively.
get reset -p

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

# Grep for just the changed lines.
git diff --word-diff | grep -F '[-[ ]-]{+[*]+}'

# Get patch to submit.
git diff master..fix-typo

# Or just diff master against the current branch:
git diff master..

# Generate a patch from an existing commit.
git format-patch -1 0d3084344f48b4594045f97ecfd16e6dc51ccc3c
# https://stackoverflow.com/questions/6658313/generate-a-git-patch-for-a-specific-commit

# Oops, we didn't want that in the staging area, but we still want to keep the modified copy.
# (Basically the unstage command.)
git reset HEAD myfile.txt
# We want to undo (revert) local changes, erasing the changed file and going back to the last commit.
git checkout myfile.txt

# Checkout an entire directory of files.
git checkout HEAD -- /path/to/dir

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

# Show how many commits have affected each file.
git log --name-only --pretty=format: | sort | uniq -c | less
# See the files with most commits at the top.
git log --name-only --pretty=format: | sort | uniq -c | sort -nr | less

# Commit history of a particular file, including renames.
git log --follow myfile.txt
# Show lines added and name changes as well.
git log --follow --numstat myfile.txt

# Do a case-insensitive pickaxe search on all commits for the word 'noodles'.
git log -p -S 'noodles' -i
# case-insensitive, find all commits where word 'rhubarb' was added or removed (pickaxe search)
git grep -i 'rhubarb' "$(git rev-list --all)"

# Show only tagged commits, such as releases.
git log --no-walk --tags

# Fix an incorrect commit message or commit.
git commit --amend
# https://github.blog/2015-06-08-how-to-undo-almost-anything-with-git/

# You can also use -m, but the previous way brings up the previous commit message in your favorite editor.
git commit --amend -m "Fixed message."

# Update timestamp as well as amending.
git commit --amend --date="$(date -R)"
# http://stackoverflow.com/questions/9110310/update-git-commit-author-date-when-amending

# Do a soft reset (undo) of last commit;
# useful if e.g. your branch and origin/master have diverged.
git reset --soft HEAD~1

# Move commits on master to a different branch.
git branch newbranch    # save current state in a new branch, but stay on master branch.
git reset --hard HEAD~1 # get rid of last commit on current branch
git checkout newbranch  # move to new branch
# https://stackoverflow.com/questions/3719068/move-commits-from-master-onto-a-branch-using-git

# Show available branches
git branch

# Name of current branch.
git rev-parse --abbrev-ref HEAD
git symbolic-ref --short HEAD
# http://stackoverflow.com/questions/6245570/how-to-get-current-branch-name-in-git

# SHA-1 hash of current commit
git rev-parse HEAD
git rev-parse --verify HEAD
# https://stackoverflow.com/questions/949314/how-to-retrieve-the-hash-for-the-current-commit-in-git

# Make a new branch
git branch name_of_branch

# Switch to a branch
git checkout name_of_branch

# Make a new branch and switch to it
git checkout -b my-branch-name

# Rename current branch.
git branch -m new_name_of_branch
# http://stackoverflow.com/questions/6591213/how-to-rename-a-local-git-branch

# Delete a branch
git branch -d name_of_branch

# Rollback to an old commit while staying on the same branch.
# https://stackoverflow.com/questions/2007662/rollback-to-an-old-commit-using-git
git checkout [revision] .

# If you do this:
git checkout [revision]
# you may end up in a detached head state.
#     You are in 'detached HEAD' state. You can look around, make experimental
#     changes and commit them, and you can discard any commits you make in this
#     state without impacting any branches by performing another checkout.
# So get back to the previous setttings by running checkout of the branch you were on.
git checkout master
# https://stackoverflow.com/questions/10228760/fix-a-git-detached-head
# http://gitolite.com/detached-head.html
# http://alblue.bandlem.com/2011/08/git-tip-of-week-detached-heads.html
# http://learnwebtutorials.com/you-are-in-detached-head-state-how-fix

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

# github's "push an existing repository from the command line"
git remote add origin git@github.com:my_user_name/my_project_name.git
git push -u origin master

#  Add a remote repository
git remote add origin git@github.com:user/repository.git # uses SSH, which is good since you can set up SSH keys instead of entering a password every time.
git remote add origin git@github.com:nbeaver/custom-units.git # example
git remote add origin https://github.com/user/repository.git # uses HTTPS, which will require entering a password a lot.
git remote add chloride ssh://nbeaver@chloride.phys.iit.edu:/home/nbeaver/git-repositories/tidier-pdfimages.git # absolute paths
git remote add chloride nbeaver@chloride.phys.iit.edu:git-repositories/tidier-pdfimages.git # relative paths; you have to drop the leading ssh:// part

# Push to a remote repository (in this case, push the master branch)
git push -u origin master
git push -u chloride master

# Push to multiple remotes with a single command.
git remote add all 'git@gitlab.com:nbeaver/vim-config.git'
git remote set-url --add --push all 'git@gitlab.com:nbeaver/vim-config.git'
git remote set-url --add --push all 'git@github.com:nbeaver/vim-config.git'
git push all
# https://stackoverflow.com/questions/849308/pull-push-from-multiple-remote-locations
# https://stackoverflow.com/questions/14290113/git-pushing-code-to-two-remotes
# https://leighmcculloch.com/posts/git-push-to-multiple-remotes-at-once/
# https://jigarius.com/blog/multiple-git-remote-repositories

# Change the url for a remote repository
# It is better to use SSH than https, since you won't have to log in every time, like this:
git remote set-url origin "git@github.com:nbeaver/name-of-repo.git"
# Not this:
git remote set-url origin "https://github.com/nbeaver/name-of-repo.git"
# Useful for messages like:
# "fatal: remote origin already exists."

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

# Rename an existing remote called "origin" to "github"
git remote rename origin github
# https://stackoverflow.com/questions/33840617/how-do-i-rename-a-git-remote
# https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes#_renaming_and_removing_remotes

# Set the default remote repository and branch to push to.
git push -u <remote_name> <local_branch_name>
# https://stackoverflow.com/questions/18801147/changing-the-default-git-remote-push-to-default

# List all files ever tracked by the git repository
git ls-tree --full-tree -r HEAD
# List just the files being tracked right now
git ls-files


# Simple merging, e.g. merge into master branch.
git checkout master
git merge my_branch_name
# Pull in only some of the files.
git checkout my_branch_name -- ~/path/to/myfile.txt
# https://stackoverflow.com/questions/610208/how-to-retrieve-a-single-file-from-specific-revision-in-git/610315#610315

# Creating a pull request.
# Fork the repo on Github.
# Clone it.
git clone git@github.com:nbeaver/pqRand.git
# Make a new branch.
git checkout -b nbeaver
# Make some edits and commit.
git commit -m "Fix Makefile."

# Push to remote repository.
git push --set-upstream origin nbeaver
# Useful for messages like:
# fatal: The current branch suppress-space has no upstream branch.
# To push the current branch and set the remote as upstream, use
# 
#     git push --set-upstream origin suppress-space

# Next, go to github and make the pull request.
# http://stackoverflow.com/questions/16493396/git-master-branch-has-no-upstream-branch
# http://stackoverflow.com/questions/14680711/how-to-do-a-github-pull-request

# Update the master branch.
git checkout master
git pull

# Merging a good branch.
git checkout myfeature
# Do stuff.
git commit -m "Did stuff."
# Do more stuff.
git commit -m "Did more stuff."
# When ready, merge it back into master.
git checkout master
git merge --no-ff myfeature
# Don't need this branch anymore.
git branch -d myfeature
# https://nvie.com/posts/a-successful-git-branching-model/

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

# Cloning from a remote repository.
git clone https://github.com/nbeaver/commutator-table.git
# Cloning over ssh. These both create a folder called 'tidier-pdfimages' with the repository inside; neither creates 'tidier-pdfimages.git' as a folder.
git clone nbeaver@chloride.phys.iit.edu:git-repositories/tidier-pdfimages.git
git clone nbeaver@chloride.phys.iit.edu:git-repositories/tidier-pdfimages

# Clone a repository that fails fsck.
git clone 'https://git.zx2c4.com/cgit'
# Cloning into 'cgit'...
# remote: Enumerating objects: 6986, done.
# remote: Counting objects: 100% (6986/6986), done.
# remote: Compressing objects: 100% (2689/2689), done.
# error: bad config line 5 in blob .gitmodulesB | 763.00 KiB/s
# error: object 51dd1eff1edc663674df9ab85d2786a40f7ae3a5: gitmodulesParse: could not parse gitmodules blob
# fatal: fsck error in packed object
# fatal: index-pack failed
git clone --config transfer.fsckobjects=false --config receive.fsckobjects=false --config fetch.fsckobjects=false 'https://git.zx2c4.com/cgit'
# https://github.com/vim-pandoc/vim-markdownfootnotes/blob/master/README.markdown

# How to tell someone who just wants to see your progress:
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
#     Cannot create a new backup.
#     A previous backup already exists in refs/original/

# Force overwriting the backup with -f
git filter-branch -f --tree-filter 'rm -f passwords.txt' HEAD
# Get rid of a file from every commit in the entire repository as well as deleting it from the current directory.

git filter-branch --tree-filter 'rm -f passwords.txt' -f --prune-empty HEAD
# http://dalibornasevic.com/posts/2-permanently-remove-files-and-folders-from-a-git-repository
# http://stackoverflow.com/questions/5324799/git-remove-commits-with-empty-changeset-using-filter-branch

# Without deleting the file from the current directory.
git filter-branch --tree-filter 'rm  passwords.txt'
# https://stackoverflow.com/questions/1143796/remove-a-file-from-a-git-repository-without-deleting-it-from-the-local-filesyste

# Find a particular file by filename.
git rev-list --objects --all | grep -i passwords.txt

# Get rid of every file except one, and prune the commits that didn't affect that file.
# Warning: may not work if filenames have spaces or special characters.
# Warning: will get rid of your .gitignore.
# TODO: check if this works when files have been renamed.
git filter-branch --prune-empty --index-filter 'git ls-tree -z --name-only --full-tree $GIT_COMMIT | grep -zv "^git-notes.txt$" | xargs -0 git rm --cached -r' -- --all
# http://stackoverflow.com/questions/2797191/how-to-split-a-git-repository-while-preserving-subdirectories

# More than one file.
git filter-branch --prune-empty --index-filter 'git ls-tree -z --name-only --full-tree $GIT_COMMIT | grep -zv "^git-notes.txt$\|^other-notes.txt$" | xargs -0 git rm --cached -r' -- --all

# Better way to do multiple files.
git filter-branch --index-filter 'git read-tree --empty; git reset $GIT_COMMIT -- git-notes.txt other-notes.txt' -- --all -- git-notes.txt other-notes.txt
# http://stackoverflow.com/a/37037151/1608986
# http://stackoverflow.com/questions/7375528/how-to-extract-one-file-with-commit-history-from-a-git-repo-with-index-filter


# Now, thoroughly scrub the repo.
git reflog expire --expire=now --all
git gc --aggressive --prune=now
git repack -A -d
# http://stackoverflow.com/questions/10656794/why-do-large-files-still-exist-in-my-packfile-after-scrubbing-them-with-filter
git reflog expire --expire=now --all && git gc --aggressive --prune=now && git repack -A -d

# This seems to work better?
git filter-branch --index-filter 'git rm --cached --ignore-unmatch passwords.txt'
rm -rf '.git/refs/original/'
git reflog expire --expire=now --all
git repack -A -d
git prune --verbose
# https://stackoverflow.com/questions/2164581/remove-file-from-git-repository-history

# Splitting off a subdirectory into its own repository.
cd parent-repo
git subtree split -P subdirectory -b newbranch # no trailing /
cd ..
mkdir newrepo
cd newrepo
git init
git pull ../parent-repo newbranch
# https://stackoverflow.com/questions/359424/detach-subdirectory-into-separate-git-repository/17864475#17864475

# Archive files
git archive -o latest.zip HEAD
# http://git-scm.com/docs/git-archive#_examples
git archive HEAD -o project.zip

# Notes on how to concatenate/collate/splice/graft/stitch/tack together
# git repositories, one having old history and one having new.
# http://ben.straubnet.net/post/939181602/git-grafting-repositories
# First, got to more recent repo.
# In this case, the old repo is in ``../old``.
cd new
git fetch ../old master:ancient_history
# Output:
#     warning: no common commits
#     remote: Counting objects: 11, done.
#     remote: Compressing objects: 100% (6/6), done.
#     remote: Total 11 (delta 1), reused 11 (delta 1)
#     Unpacking objects: 100% (11/11), done.
#     From ../old
#      * [new branch]      master     -> ancient_history
# Note the SHA1 hashes of the oldest on master and the latest on ancient_history.
git rev-list master | tail -n 1
# d7737bffdad86dc05bbade271a9c16f8f912d3c6
git rev-parse ancient_history
# 463d0401a3f34bd381c456c6166e514564289ab2
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
# https://stackoverflow.com/questions/5724513/in-git-how-do-i-figure-out-what-my-current-revision-is

# Show version string and part of SHA1.
git describe --tags
# http://stackoverflow.com/questions/5694389/get-the-short-git-version-hash
# https://stackoverflow.com/questions/5724513/in-git-how-do-i-figure-out-what-my-current-revision-is

# Simple workflow without collaborators.
# On branch master.
git checkout -b develop
# ... do work, make commits.
git checkout master
git merge develop
git checkout develop
# http://nvie.com/posts/a-successful-git-branching-model/

# Merge conflicts, e.g.
# CONFLICT (modify/delete): TODO.rst deleted in develop and modified in HEAD. Version HEAD of TODO.rst left in tree.
# Automatic merge failed; fix conflicts and then commit the result.
git rebase upstream/master
git rebase --skip
git push -f origin
# https://quaxio.com/git_rebase_conflicts_with_deleted_files/
# http://softwarecave.org/2014/03/03/git-how-to-resolve-merge-conflicts/

# Make a GitHub pages website.
# Starting from master branch:
git checkout -b gh-pages
git remote add origin git@github.com:nbeaver/user-supplied-ad-preferences.git
git push -u origin gh-pages
# if the remote is already added, use this instead.
git checkout -b gh-pages
git push --set-upstream origin gh-pages
git push -u origin gh-pages
git branch -d master
xdg-open 'http://nbeaver.github.io/user-supplied-ad-preferences'
# If you want to keep the master branch,
# set Github's default branch to be "gh-pages".
# Use "Settings" -> "Branches" -> "Default Branch"
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

# Get old version of a file.
git show 6de5ab0b566d9915ef2bae66e2a205efc336316b:readme.rst > old.rst

# Updating to the latest version of the code.
git checkout master
git fetch # or git fetch upstream
git merge --ff-only

# Updating to upstream repo.
git fetch upstream
git checkout master
git merge upstream/master
# https://help.github.com/articles/configuring-a-remote-for-a-fork/
# https://help.github.com/articles/syncing-a-fork/

git clone git@github.com:nbeaver/numpy.git
cd numpy
git remote add upstream git://github.com/numpy/numpy.git
git fetch upstream
git merge upstream/master --ff-only
git checkout -b my-new-feature upstream/master
# Edit the files at this point.
git add my_new_file
git commit -am 'ENH: some message'
# Now push the branch to your own Github repo.
git push origin

# Undelete a branch.
# First, find the revision.
# Running branch -d will show the deleted revision, for example, or
git reflog
# will show the commit messages.
# Now check it out.
git checkout bb9c6d1
# Now make the branch.
git branch name-of-recovered-branch
# https://stackoverflow.com/questions/16398501/how-to-undelete-a-branch-on-github

# 2015-11-18
# Got this error:
# $ git status
# error: object file .git/objects/55/29a651ad640ad5ff9997aa8204bbec66334877 is empty
# error: object file .git/objects/55/29a651ad640ad5ff9997aa8204bbec66334877 is empty
# fatal: loose object 5529a651ad640ad5ff9997aa8204bbec66334877 (stored in .git/objects/55/29a651ad640ad5ff9997aa8204bbec66334877) is corrupt
# First, make a backup.
cd ..
cp -r repo ~/backup-repo-folder/
# Now delete broken objects.
find .git/objects/ -type f -empty -delete
# Now how is the repo?
# $ git status
# fatal: bad object HEAD
# Alright, let's see what should be the head.
tail -n 2 .git/logs/refs/heads/master
# Looks promising.
# 2566184d3db3cc5847ce8478a0887792b68946fa 7a5783acaf9ebe17ed1add42b6e2e4400786d07d Nathaniel Beaver <nathanielmbeaver@gmail.com> 1447262088 -0600	commit: Snapshot.
# 7a5783acaf9ebe17ed1add42b6e2e4400786d07d 5529a651ad640ad5ff9997aa8204bbec66334877 Nathaniel Beaver <nathanielmbeaver@gmail.com> 1447262470 -0600	commit: Snapshot.
git show 5529a651ad640ad5ff9997aa8204bbec66334877
# fatal: bad object 5529a651ad640ad5ff9997aa8204bbec66334877
git show 7a5783acaf9ebe17ed1add42b6e2e4400786d07d
# fatal: bad object 7a5783acaf9ebe17ed1add42b6e2e4400786d07d
git show 2566184d3db3cc5847ce8478a0887792b68946fa
# This one works. So let's make that the new head.
git update-ref HEAD 2566184d3db3cc5847ce8478a0887792b68946fa
# Now, just to be safe.
git fsck --full
# error: c81db952b38acb645b6f6f58eac787ab40c130a8: invalid sha1 pointer in cache-tree
# Hm, I guess we'll have to reset the repo.
rm .git/index
git reset
# Now fsck again.
git fsck --full
# Looks ok. So we just lost a commit, but it could be worse.
# http://stackoverflow.com/a/12371337
# https://stackoverflow.com/questions/11706215/how-to-fix-git-error-object-file-is-empty
# http://kos.gd/posts/git-adventures-loose-object-is-corrupted/
# http://vincesalvino.blogspot.com/2013/08/git-empty-files-corrupt-objects-and.html
# https://stackoverflow.com/questions/4254389/git-corrupt-loose-object

# On remote machine.
mkdir ~/git-repos/bash.git
cd ~/git-repos/bash.git
git --bare init
# On local machine.
git remote add chloride nbeaver@chloride.phys.iit.edu:git-repos/bash.git
git push -u chloride master

# Remove remote.
git remote remove upstream

# Create patch from a single commit.
git format-patch -1 ed8977a09bf2480bfb5c26b9ecc7d37cb60b9e39
# Create patch from two different commits.
git diff OLDSHA1 NEWSHA1

# Clone an SVN repo like a git repo.
git svn clone -s http://svn.csrri.iit.edu/mx/ mx/
# Pull in new differences.
git svn rebase

# Add a config option when cloning a git repo.
git -c transfer.fsckObjects=false clone https://github.com/antirez/redis.git


# On branch master
#
# It took 2.17 seconds to enumerate untracked files. 'status -uno'
# may speed it up, but you have to be careful not to forget to add
# new files yourself (see 'git help status').
# nothing to commit, working directory clean

# Retrieve a deleted file.
git rev-list -n 1 HEAD -- text-files/myfile.txt
# Example: f02aef0659e918a68f4ef3030b6f32e43bc230c8
git checkout f02aef^ -- text-files/myfile.txt

# Make a new local bare repo to push to.
cd myrepo/
git clone --mirror . /path/to/bare-repo.git
# Use a name like 'backup' or 'archive'.
git remote add --mirror=push my-remote-name /path/to/bare-repo.git
git push --mirror my-remote-name
# Get the repo back like it was.
git clone --origin my-remote-name /path/to/bare-repo.git

# Tag latest commit.
git tag -a v0.1
# Tag a commit by hash.
git tag -a v0.1 1a1212dd38a70f2ccc3690ce477f80c254256b7c
git tag --annotate v0.1 1a1212dd38a70f2ccc3690ce477f80c254256b7c
# "Make an unsigned, annotated tag object"

# Check which tags contain a commit.
git tag --contains 1a1212dd38a70f2ccc3690ce477f80c254256b7c

git push --tags
# Push the tags.

# Things to try in a repo with missing files / commits
cat ../fresh/.git/objects/pack/pack-*.pack | git unpack-objects

# Rename master to main.
git branch -m master main
# https://www.git-tower.com/learn/git/faq/git-rename-master-to-main/

# TODO: summarize commands from here:
# https://github.blog/2015-06-08-how-to-undo-almost-anything-with-git/
