export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
export GEM_HOME="$HOME/gems/3.0.0"
export burp="http://127.0.0.1:8080"
setxkbmap latam

function mkt(){
    mkdir nmap tmp repos enum privesc
}

function scan(){
    target $1
    sudo nmap --min-rate 5000 -p-  --privileged -sS -Pn -n -v $1 -oN nmap/all-tcp-ports.txt
    ports=$(cat nmap/all-tcp-ports.txt | grep -oP "\d+/tcp" | cut -d / -f 1 | tr "\n"  "," |sed 's/,$//g')
    sudo nmap --reason --privileged -T4 -p$ports -A -Pn -n -v $1 -oN nmap/all-tcp-versions.txt


}
function target(){
    echo $1 > /tmp/target.txt
}
function ssh_() {
    ssh-keygen -f $1 -N ''
    xclip -r -selection clip $1.pub
}
alias nc="ncat"
alias server="python3 -m http.server"
alias ffuf="ffuf -noninteractive -fmode and -mmode and -mc all -H \"User-Agent: Mozilla/5.0 (Linux; Android 5.1; iris 600 Build/LMY47I; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/43.0.2357.121 Mobile Safari/537.36\" -c -v"
alias sqlmap="python3 ~/tools/sqlmap/sqlmap.py --random-agent"
alias feroxbuster="feroxbuster -A --no-state"
alias john="~/tools/john/run/john"
alias j="john --wordlist=/home/l1nvx/SecLists/Passwords/Leaked-Databases/rockyou.txt"
alias firefox="~/Escritorio/firefox/firefox-bin"
