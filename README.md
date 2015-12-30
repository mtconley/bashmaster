#Installation
```
git clone https://github.com/mtconley/bashmaster.git
cd bashmaster/source
bash install.sh
```

Bashmaster must be installed from the `source` directory as demonstrated above

##Examples
```
bashmaster checkout branch1
bashmaster home
bashmaster get=dotfiles/scripts/z.sh from=master
bashmaster patch=dotfiles/configs/bash_alias_extend from=branch3
bashmaster list
```

###TODO
* Clean up argument parsing
    * how options are accessed
    * how files are found