
password_write_to_file_if_empty() {

    [ -z $PASSWORD_FILE ] && PASSWORD_FILE="$HOME/.tmp/passwd.$$"

    if [ -z ${PASSWORD} ] || [ "${PASSWORD}" == "" ]
    then
        echo "Please provide password:"
        stty -echo
        read PASSWORD
        stty echo
    fi

    touch ${PASSWORD_FILE}
    chmod 600 ${PASSWORD_FILE}
    echo ${PASSWORD} > ${PASSWORD_FILE}

    [ -r ${PASSWORD_FILE} ] && echo "Can't read password file, exiting... " && exit 2
}

password_remove_file() {

    [ -z ${PASSWORD_FILE} ] && rm ${PASSWORD_FILE}

}