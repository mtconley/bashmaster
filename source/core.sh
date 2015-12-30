bashmaster(){
    ACTION="NONE"
    b='\033[1;5;255m'
    n='\033[0;5;255m'
    for i in "$@"; do
        case $i in
            get=*)
                FILENAME="${i#*=}"
                ACTION="get"
                shift # past argument=value
            ;;
            patch=*)
                FILENAME="${i#*=}"
                ACTION="patch"
                shift
            ;;
            from=*)
                BRANCH_NAME="${i#*=}"
                shift
            ;;
            list)
                git branch
                shift
            ;;
            home)
                name=`uname -n`
                git checkout $name
            ;;
            master)
                git chekout master
            ;;
            -h|--help*)
                echo -e 'usage:'
                echo -e '   to GET file from branch:'
                echo -e '       bashmaster get=<filename> from=<branch>'
                echo -e '   to PATCH file from branch'
                echo -e '       bashmaster patch=<filename> from=<branch>'
                echo -e '   to LIST available branches'
                echo -e '       bashmaster list'
                echo -e '   to checkout HOME branch'
                echo -e '       bashmaster home'
                echo -e '   to checkout MASTER branch'
                echo -e '       bashmaster master'

                shift
            ;;
         esac
    done
    case ${ACTION} in
        get)
            `git checkout ${BRANCH_NAME} ${FILENAME}`
        ;;
        patch)
            `git checkout --patch ${BRANCH_NAME} ${FILENAME}`
        ;;
    esac
}
