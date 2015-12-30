#Installation
```
git clone https://github.com/mtconley/bashmaster.git
cd bashmaster/source
bash install.sh
```

Bashmaster must be installed from the `source` directory as demonstrated above

##Examples
```
cd ~/
bashmaster checkout=branch1
bashmaster home
bashmaster get=dotfiles/scripts/z.sh from=branch1
bashmaster patch=dotfiles/configs/bash_alias_extend from=branch1
bashmaster list
bashmaster --help
```

###TODO
* Clean up argument parsing
    * how options are accessed
    * how files are found