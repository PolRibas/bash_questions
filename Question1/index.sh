#!/bin/bash
OPT_STRING="tcheds:l:"
__usage="
 \n
Options:  \n \n
  \033[0;31m-h  -->  \033[0;32mShow this help message \n
"

OPTIONS="\n
    \033[0;31mA)--> \033[0;32mbuscar en la libreta de direcciones\n
    \033[0;31mB)--> \033[0;32mañadir entradas\n
    \033[0;31mC)--> \033[0;32mborrar o editar entradas\n
    \033[0;31mD)--> \033[0;32mlistar las entradas\n
    \n
  "

while getopts $OPT_STRING opt; do
    case ${opt} in
    h)
        echo ${__usage}
        echo ${OPTIONS}
        ;;
    \?) ;;
    esac
done

createRegister() {
    echo 'tell me the Name:'
    read name
    echo 'tell me the Surname:'
    read surname
    echo 'tell me the Phone:'
    read phone
    echo 'write (1) for save this register'
    read ADDUSER_RETURN_CODE
    if [ "$ADDUSER_RETURN_CODE" -eq "1" ]; then
        echo "\033[0;32m********** Creando Registro **********"
        echo "Name: ${name}, Surname: ${surname}, Phone: ${phone}" >>"./bin/${name}.txt"
    else
        echo "\033[0;31mExit"
    fi

}

while :; do
    echo '\033[0;39m(A, B, C, D) escriba Nueva Opcion: '
    read x
    case ${x} in
    A)
        echo '\033[0;32mBuscar en la libreta\033[0;39m'
        echo 'More details for: '
        read archive
        cat "./bin/${archive}.txt"
        ;;
    B)
        echo '\033[0;32mAñadir entradas\033[0;39m'
        createRegister
        ;;
    C)
        echo '\033[0;32mborrar o editar entradas\033[0;39m'
        echo '\033[0;39mescriba: '
        read key
        rm -rf "./bin/${key}.txt"
        ;;
    D)
        echo '\033[0;32mlistar las entradas\033[0;39m'
        ls -la ./bin
        ;;
    help) echo ${OPTIONS} ;;
    l) echo ${OPTIONS} ;;
    esac
done
