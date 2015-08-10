# specL
This is a read-only mirror of the Bioconductor SVN repository. Contributions: http://www.bioconductor.org/packages/devel/bioc/html/specL.html. Bug Reports: https://support.bioconductor.org/p/new/post/?tag_val=specL. Package Homepage: http://bioconductor.org/packages/devel/bioc/html/specL


## On how to commit to github
http://www.bioconductor.org/developers/how-to/git-mirrors/

Each time you want to push git commits to svn:
- git checkout devel to switch to the devel branch. (use release-X.X for release branches)
- git svn rebase to get the latest SVN changes.
- git merge master --log to merge your changes from the master branch or skip this step and work directly on the current branch.
- git svn dcommit --add-author-from to sync and commit your changes to svn. You may be prompted here for your SVN username and password.
