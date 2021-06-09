#!/bin/bash

SRVER_URL=localhost:9200
FILL_NAME=exercicebash2.txt
OPTIONS="
\n\033[0;31mhelp\033[0;39m    ->      Show this message
\n\033[0;31mA\033[0;39m       ->      List full output
\n\033[0;31mB\033[0;39m       ->      Get the registers with more than 60 days
\n\033[0;31mC\033[0;39m       ->      Reindex server backup
\n

"

echo ${OPTIONS}

while :; do
    echo '\033[0;39m(A, B, C) select Option: '
    read x
    case ${x} in
    A)
        input="./${FILL_NAME}"
        while IFS= read -r line; do
            echo "$line"
        done <"$input"
        ;;
    B)
        input="./${FILL_NAME}"
        today=$(date "+%s")
        days_ago=1296000
        while IFS="-" read f1 f2 f3 f4; do
            start_time=$(date -j -f '%Y.%m.%d' ${f3} "+%s")
            let first_register=$today-$days_ago
            if [ ${start_time} -lt ${first_register} ]; then
                echo ${f3}
            fi
        done <"$input"
        ;;
    C)
        $(curl -X POST "${SRVER_URL}/_reindex?pretty" -H 'Content-Type: application/json' -d'
            {
            "source": {
                "index": "my-index-000001"
            },
            "dest": {
                "index": "my-new-index-000001"
            }
        }
        ')
        responseStatus=$?
        echo 'Exit code: ' $responseStatus
        ;;
    D) 
    ;;
    help) echo ${OPTIONS} ;;
    esac
done
