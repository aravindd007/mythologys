#!/bin/bash

echo -e $Yellow "
             _       _                   _       
            | |  _  (_)                 | |      
 ____  _   _| |_| |_ _       _   _  ____| |  ___ 
|    \| | | | (_   _) |     | | | |/ ___) | /___)
| | | | |_| | | | |_| |     | |_| | |   | ||___ |
|_|_|_|____/ \_) \__)_|     |____/|_|    \_|___/ 
                                                 
           @imran407704 aka CyberSecOpS
"

target=$1
printf "Total Targets: $(wc -l $1 | awk '{print $1}')\n"
mkdir -p multiurls
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Waybackurls Started\n"
cat $1 | waybackurls | anew multiurls/waybackurls.txt > /dev/null
printf "✅ Waybackurls data :$(wc -l multiurls/waybackurls.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Gau-Plus Started\n"
cat $1 | gauplus | anew multiurls/plus-gau.txt > /dev/null
printf "✅ Plus-gau data :$(wc -l multiurls/plus-gau.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Gau Data Started\n"
cat $1 | gau --subs| anew multiurls/gau.txt > /dev/null
printf "✅ Gau data :$(wc -l multiurls/gau.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Katana Data Started\n"
katana -u $1 -jc | anew multiurls/katana.txt > /dev/null
printf "✅ Katana data :$(wc -l multiurls/katana.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Hakrawler Data Started\n"
cat $1 | hakrawler -subs -u | anew multiurls/hakrawler.txt > /dev/null
printf "✅ Hakrawler data :$(wc -l multiurls/hakrawler.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Waymore Data Started\n"
python3 /root/tools/waymore/waymore.py -i $1 -mode U
printf "✅ Waymore data :$(wc -l /root/tools/waymore/results/$1/waymore.txt | awk '{print $1}')\n"

cat multiurls/waybackurls.txt multiurls/plus-gau.txt multiurls/gau.txt multiurls/katana.txt multiurls/hakrawler.txt | sort -u | anew multiurls/all-urls.txt > /dev/null

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

printf "Total all-urls :$(wc -l multiurls/all-urls.txt)\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
