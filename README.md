#Installation
```
git clone https://github.com/mtconley/bashmaster.git
cd bashmaster/source
bash install.sh
```

##Examples
```
bashmaster checkout branch1
bashmaster home
bashmaster get=dotfiles/scripts/z.sh from=master
bashmaster patch=dotfiles/configs/bash_alias_extend from=branch3
bashmaster list
```

##TODO
* Allow for branch checkout outside of directory
* Do not allow editing of none home nodename branches??
* set `branch.my_branch.merge` in configuration file??