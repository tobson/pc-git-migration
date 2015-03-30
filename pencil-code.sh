#!/bin/bash

# Absolute path to SVN repo
svnrepo=$(realpath $1)

# Relative path to Git repo
gitrepo=$2

# Initialize bare Git repository
bare=$2.git

# Temporary directory
# temp=/tmp/git-migration-$RANDOM
temp=temp

# Initialize bare repository
rm -rf $bare
git init --bare $bare

# Clone local SVN repository
rm -rf $temp
git svn clone -T trunk -A authors.txt --no-metadata file://$svnrepo $temp

cd $temp

git push file://$(realpath ../$bare) master

# List branches
branches=(anelastic reform-thermodynamics)

# Fetch branches
svn_branches=(${branches[@]/%/-branch})
git config --add svn-remote.svn.branches \
  "branches/{$(IFS=,; echo "${svn_branches[*]}")}:refs/remotes/origin/*"
git svn fetch

# Push branches
for branch in ${branches[@]}
do
  git push file://$(realpath ../$bare) \
    origin/$branch-branch:refs/heads/$branch
done

cd -
