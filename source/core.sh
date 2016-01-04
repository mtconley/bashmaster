bashmaster(){
    ACTION="NONE"
    SCRIPTS="$BASH_DIR/dotfiles/scripts"
    CONFIGS="$BASH_DIR/dotfiles/configs"
    for i in "$@"; do
        case $i in
            get=*)
                FILE=${i#=}
                FILENAME=`get_filepath $FILE $SCRIPTS $CONFIGS`
                ACTION="get"
                shift # past argument=value
            ;;
            patch=*)
                FILE=${i#=}
                FILENAME=`get_filepath $FILE $SCRIPTS $CONFIGS`
                ACTION="patch"
                shift
            ;;
            from=*)
                BRANCH_NAME="${i#*=}"
                shift
            ;;
            list)
                (cd $BASH_DIR && git branch)
                shift
            ;;
            home)
                name=`uname -n`
                (cd $BASH_DIR && git checkout $name)
                source $BASH_DIR/dotfiles/.bash_run
                cd - > /dev/null
                shift
            ;;
            master)
                (cd $BASH_DIR && git checkout master)
                source $BASH_DIR/dotfiles/.bash_run
                cd - > /dev/null
                shift
            ;;
            checkout=*)
                (cd $BASH_DIR && git checkout "${i#*=}")
                source $BASH_DIR/dotfiles/.bash_run
                cd - > /dev/null
                shift
            ;;
            current)
                (cd $BASH_DIR && git branch | grep -e ^\*)
                shift
            ;;
            -h|--help)
                echo -e "usage: bashmaster"
                echo -e "   GET - to `bold GET` file from branch:"
                echo -e "       bashmaster get=<filename> from=<branch>"
                echo -e "   PATCH - to `bold PATCH` file from branch"
                echo -e "       bashmaster patch=<filename> from=<branch>"
                echo -e "   LIST - to `bold LIST` available branches"
                echo -e "       bashmaster list"
                echo -e "   CURRENT - to display `bold CURRENT` branch"
                echo -e "       bashmaster current"
                echo -e "   HOME - to checkout your `bold HOME` branch"
                echo -e "       bashmaster home"
                echo -e "   MASTER - to checkout the `bold MASTER` branch"
                echo -e "       bashmaster master"
                echo -e "   CHECKOUT - to `bold CHECKOUT` a branch"
                echo -e "       bashmaster checkout=<branch>"

                shift
            ;;
            *)
                error  "ERROR: An error has occured, please try again."
                error  "       type 'bashmaster --help' for more hints"
         esac
    done
    case ${ACTION} in
        get)
            now=`date +%Y-%m-%d-%H:%M`
            (cd $BASH_DIR && git checkout ${BRANCH_NAME} ${FILENAME})

        ;;
        patch)
            echo '---> ENTER 'e' TO PATCH; ENTER 'n' TO EXIT <---'
            (cd $BASH_DIR && git checkout --patch ${BRANCH_NAME} ${FILENAME})

        ;;
    esac
}

file_in_dir(){
    FILE=$1
    DIR=$2
    if [[ -f "$2/$1" ]]; then
        return 0
    else
        return 1
    fi
}

get_filepath(){
    FILE=$1
    FLAG=0
    for DIR in "${@:2}"; do
        file_in_dir $FILE $DIR && echo $DIR/$FILE && FLAG=1
    done
    if [ $FLAG -eq 0 ]; then
        error "ERROR: File, $FILE, cannot be found"
        return 1
    else
        return 0
    fi
}

bold(){ echo -e "\033[1;255m$@\033[0m"; }
error() { echo -e "\033[0;31m$@\033[0m"; }
