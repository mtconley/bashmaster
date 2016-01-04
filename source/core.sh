bashmaster(){
    ACTION="NONE"
    b='\033[1;5;255m'
    n='\033[0;5;255m'
    for i in "$@"; do
        case $i in
            get=*)
                FILENAME="$BASH_DIR/dotfiles/scripts/${i#*=}"
                ACTION="get"
                shift # past argument=value
            ;;
            patch=*)
                FILENAME="$BASH_DIR/dotfiles/scripts/${i#*=}"
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
                echo -e "   GET - to$b GET$n file from branch:"
                echo -e "       bashmaster get=<filename> from=<branch>"
                echo -e "   PATCH - to$b PATCH$n file from branch"
                echo -e "       bashmaster patch=<filename> from=<branch>"
                echo -e "   LIST - to$b LIST$n available branches"
                echo -e "       bashmaster list"
                echo -e "   CURRENT - to display$b CURRENT$n branch"
                echo -e "       bashmaster current"
                echo -e "   HOME - to checkout your$b HOME$n branch"
                echo -e "       bashmaster home"
                echo -e "   MASTER - to checkout the$b MASTER$n branch"
                echo -e "       bashmaster master"
                echo -e "   CHECKOUT - to$b CHECKOUT$n a branch"
                echo -e "       bashmaster checkout=<branch>"

                shift
            ;;
         esac
    done
    case ${ACTION} in
        get)
            (cd $BASH_DIR && git checkout ${BRANCH_NAME} ${FILENAME})
        ;;
        patch)
            echo '---> ENTER 'e' TO PATCH; ENTER 'n' TO EXIT <---'
            (cd $BASH_DIR && git checkout --patch ${BRANCH_NAME} ${FILENAME})
        ;;
    esac
}
