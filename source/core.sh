bashmaster(){
    ACTION="NONE"
    SCRIPTS="$BASH_DIR/dotfiles/scripts"
    CONFIGS="$BASH_DIR/dotfiles/configs"
    for i in "$@"; do
        case $i in
            get=*)
                FILE="${i#*=}"
                FILENAME=`get_filepath $FILE $SCRIPTS $CONFIGS || echo false`
                ACTION="get"
                shift # past argument=value
            ;;
            patch=*)
                FILE="${i#*=}"
                FILENAME=`get_filepath $FILE $SCRIPTS $CONFIGS || echo false`
                ACTION="patch"
                shift
            ;;
            from=*)
                BRANCH_NAME="${i#*=}"
                shift
            ;;
            list | ls)
                ( cd $BASH_DIR && git branch | grep -v master )
                shift
            ;;
            home)
                name=`uname -n`
                ( cd $BASH_DIR && git checkout $name )
                resource
                shift
            ;;
            master)
                ( cd $BASH_DIR && git checkout master )
                resource
                shift
            ;;
            checkout=*)
                ( cd $BASH_DIR && git checkout "${i#*=}" )
                resource
            ;;
            current)
                ( cd $BASH_DIR && git branch | grep -e ^\* )
                shift
            ;;
            update)
                name=`uname -n`
                now=`date +%Y-%m-%d-%H:%M`
                ( cd $BASH_DIR && git checkout master )
                ( cd $BASH_DIR && git pull origin master )
                ( cd $BASH_DIR && git checkout $name )
                ( cd $BASH_DIR && git checkout master ./source/core.sh )
                ( cd $BASH_DIR && git add ./source/core.sh )
                ( cd $BASH_DIR && git commit -m "$now: update core.sh from master" )
            ;;
            -h|--help)
                echo -e "usage: bashmaster"
                echo -e "   GET - to `bold GET` file from branch:"
                echo -e "       bashmaster get=<filename> from=<branch>"
                echo -e "   PATCH - to `bold PATCH` file from branch:"
                echo -e "       bashmaster patch=<filename> from=<branch>"
                echo -e "   LIST - to `bold LIST` available branches:"
                echo -e "       bashmaster list"
                echo -e "   CURRENT - to display `bold CURRENT` branch:"
                echo -e "       bashmaster current"
                echo -e "   HOME - to checkout your `bold HOME` branch:"
                echo -e "       bashmaster home"
                echo -e "   MASTER - to checkout the `bold MASTER` branch:"
                echo -e "       bashmaster master"
                echo -e "   CHECKOUT - to `bold CHECKOUT` a branch:"
                echo -e "       bashmaster checkout=<branch>"
                echo -e "   UPDATE - to `bold UPDATE` core functionality"
                echo -e "       bashmaster update"

                shift
            ;;
            *)
                error  "ERROR: An error has occured, please try again."
                error  "       type 'bashmaster --help' for more hints"
         esac
    done
    case ${ACTION} in
        get)
            if [ "${FILENAME}" != "false" ]; then
                now=`date +%Y-%m-%d-%H:%M`
                ( cd $BASH_DIR && git checkout ${BRANCH_NAME} ${FILENAME} && echo "$FILE added successfully")
                ( cd $BASH_DIR && git add ${FILENAME} ) 1> /dev/null
                ( cd $BASH_DIR && git commit -m "$now: add file, ${FILENAME}, from branch, ${BRANCH_NAME}" ) 1> /dev/null
            else
                error "The filename, $FILE, does not exist"
            fi
        ;;
        patch)
            if [ "${FILENAME}" != "false" ]; then
                now=`date +%Y-%m-%d-%H:%M`
                echo '---> ENTER 'e' TO PATCH; ENTER 'n' TO EXIT <---'
                ( cd $BASH_DIR && git checkout --patch ${BRANCH_NAME} ${FILENAME} )
                ( cd $BASH_DIR && git add ${FILENAME} )
                ( cd $BASH_DIR && git commit -m "$now: patch file, ${FILENAME}, from branch, ${BRANCH_NAME}" )
            else
                error "The filename, $FILE, does not exist"
            fi
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
        return 1
    else
        return 0
    fi
}

resource(){
    source $BASH_DIR/dotfiles/.bash_run
    cd - > /dev/null
}


bold(){ echo -e "\033[1;255m$@\033[0m"; }
error() { echo -e "\033[0;31m$@\033[0m"; }
