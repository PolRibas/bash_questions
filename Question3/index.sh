# qrencode -t PNG -o qrcode.png 'Hello World!'
# versiones 11 10 9 8 7

input="./urls.txt"

while IFS=" " read line; do
    echo $line
    version=10
    for version in 11 10 9 8 7; do
        for ECC in L M Q H; do
            curl 'http://qr.calm9.com/en/' \
                -H 'Connection: keep-alive' \
                -H 'Pragma: no-cache' \
                -H 'Cache-Control: no-cache' \
                -H 'Upgrade-Insecure-Requests: 1' \
                -H 'Origin: http://qr.calm9.com' \
                -H 'Content-Type: application/x-www-form-urlencoded' \
                -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36' \
                -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
                -H 'Referer: http://qr.calm9.com/en/' \
                -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' \
                -H 'Cookie: __utmc=134289713; __utmz=134289713.1623267425.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utmt=1; __utma=134289713.1841456596.1623267425.1623267425.1623267425.1; __gads=ID=8b92ce6d0c7b5daa-220f8103dcc80098:T=1623267425:RT=1623267425:S=ALNI_MYd7AQteqTB-kuaCMsNge2bsmdycQ; __utmb=134289713.3.10.1623267425' \
                --data-raw 'Lang=en&Type=URI&Size=3&Version=${version}&Ecc=${ECC}&Ext=.png&URI-Type=on&Subject=&Link=${line}&Link-Type=on' \
                --compressed \
                --insecure
            
        done
    done
done <"$input"
