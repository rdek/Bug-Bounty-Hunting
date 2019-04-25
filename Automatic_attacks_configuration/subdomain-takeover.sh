#!/bin/bash

# https://github.com/OWASP/Amass - bruteforce subdomains
echo "exporting snap PATH\n"
export PATH=$PATH:/snap/bin
echo "installing amass\n"
sudo snap install amass
echo "starting subdomain finder\n"
amass -src -ip -brute -min-for-recursive 3 -d ${1} -o ${1}_amass.txt
echo "converting from trashyy output to subdomains list\n"
cat ${1}_amass.txt | awk '{ print $2 }' > subdomains_${1}.txt
# https://github.com/m4ll0k/takeover - subdomain takeover checker
echo "cloning takeover checker tool...\n"
git clone https://github.com/m4ll0k/takeover.git; cd takeover
echo "checking takeovers possibility\n"
python takeover.py --sub-domain-list ../subdomains_${1}.txt --set-output ${1}_takeovers.log

