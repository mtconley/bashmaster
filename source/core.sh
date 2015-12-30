bashmaster(){
    ACTION="NONE"
    b='\033[1;5;255'
    n='\033[0;5;255'
    for i in "$@"; do
        case $i in
            get=*)
                FILENAME="${i#*=}"
                ACTION="get"
                shift # past argument=value
            ;;
            patch*)
                FILENAME="${i#*=}"
                ACTION="patch"
                shift
            ;;
            from*)
                BRANCH_NAME="${i#*=}"
                shift
            ;;
            -h|--help*)
                echo -e 'usage:'
                echo -e '   to $bGET$n file from branch:'
                echo -e '       bashmaster get=<filename> from=<branch>'
                echo -e '   to $bPATCH$n file from branch'
                echo -e '       bashmaster patch=<filename> from=<branch>'
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
