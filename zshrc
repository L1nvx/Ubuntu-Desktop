setxkbmap latam

function mkt(){
    mkdir nmap tmp repos enum privesc
}

function scan(){
    target $1
    sudo nmap --min-rate 5000 -p-  --privileged -sS -Pn -n -v $1 -oN nmap/all-tcp-ports.txt
    ports=$(cat nmap/all-tcp-ports.txt | grep -oP "\d+/tcp" | cut -d / -f 1 | tr "\n"  "," |sed 's/,$//g')
    sudo nmap -T4 -p$ports -A -Pn -n -v $1 -oN nmap/all-tcp-versions.txt


}
function target(){
    echo $1 > /tmp/target.txt
}
alias nc="ncat"
alias server="python3 -m http.server"
alias ffuf="ffuf  -mc all -H \"User-Agent: Mozilla/5.0 (Linux; Android 5.1; iris 600 Build/LMY47I; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/43.0.2357.121 Mobile Safari/537.36\" -c -v"
alias sqlmap="python ~/sqlmap-1.7/sqlmap.py --random-agent"
alias feroxbuster="feroxbuster -A --no-state"
alias john="~/john/run/john"
alias j="john --wordlist=/home/l1nvx/SecLists/Passwords/Leaked-Databases/rockyou.txt"
