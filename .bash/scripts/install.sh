install() {
    if [ -e setup.py ]; then
        command python setup.py install
    elif [ "${1: -3}" == ".py" ]; then
        location=`python-config --prefix`
        target="$location/lib/python2.7/site-packages/$1"
        command mv $1 $target
        echo "$1 has been installed"
    else
        echo "setup.py does not exist in this directory"
    fi
}