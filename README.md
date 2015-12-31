#Bashmaster
Working on small teams, many scripts and shortcuts start to crop up to engage common systems and problems.  `bashmaster` is a way to manage all of these tools and share them among peers without losing control of your own system configuration.  It is written entirely in bash for bash 3.2 but will start to move toward bash 4 compatibility.

##Installation
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
##Other Features
Any file ending in "_ignore" will be igonred.  This means a file placed in the `configs` directory titled `bash_export_ignore`, can be used to store api keys without exposing yourself.
```
    configs
    ├── bash_alias
    ├── bash_alias_extend
    ├── bash_export
    ├── bash_export_ignore
    └── bash_profile
```

###TODO
* Clean up argument parsing
    * how options are accessed
    * how files are found
