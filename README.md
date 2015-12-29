#TODO
* archive original .bash_profile for retrieval
* create branch on install using nodename
* Symlink to individual branches
* Do not allow editing of none nodename branches??

#HOW
* [interactive staging](https://git-scm.com/book/en/v2/Git-Tools-Interactive-Staging)
* `git checkout master $FILE` (To get new file ((scriptkeeper)))
* `git checkout --patch master $FILE` (update existing file (bashmaster))
    * Stage this hunk [y,n,a,d,/,j,J,g,e,?]? ?
    * select e - manually edit the current hunk
