bashmaster(){
    for i in "$@"; do
        case $i in
            get=*)
            FILENAME="${i#*=}"
            ACTION="get"
            shift # past argument=value
            ;;
            patch*)
            FILENAME="${#*=}"
            ACTION="patch"
            shift
            ;;
            from*)
            BRANCH_NAME="${i#*=}"
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
