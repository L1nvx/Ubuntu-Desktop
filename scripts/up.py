import http.server
import os

class Server(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        # Imprimir nueva conexion
        print(f'[+] Nueva Conexion {self.client_address[0]}:{self.client_address[1]}')
        # Imprimir headers
        print(f''.ljust(50, '-'))
        print(self.requestline)
        print(self.headers)
        print(f''.ljust(50, '-'))
        # Enviar archivo
        path = os.path.join(os.getcwd(), self.path[1:])
        if os.path.exists(path):
            if os.path.isdir(path):
                # Verificar index.html
                if os.path.exists(os.path.join(path, 'index.html')):
                    # Enviar archivo
                    with open(os.path.join(path, 'index.html')) as f:
                        data = f.read()
                    # Enviar headers
                    self.send_response(200)
                    self.send_header('Content-Type', 'text/html')
                    self.send_header('Content-Length', len(data.encode()))
                    self.end_headers()
                    self.wfile.write(data.encode())
                else:
                    self.send_response(404)
                    self.send_header('Content-Type', 'text/html')
                    self.end_headers()
            elif os.path.isfile(path):
                # Enviar archivo
                with open(path) as f:
                    data = f.read()
                # Enviar headers
                self.send_response(200)
                if path.split('.')[-1] == '.js':
                    self.send_header('Content-Type', 'application/javascript')
                elif path.split('.')[-1] == '.html':
                    self.send_header('Content-Type', 'text/html')
                elif path.split('.')[-1] == '.css':
                    self.send_header('Content-Type', 'text/css')
                else:
                    self.send_header('Content-Type', 'application/octet-stream')
                self.send_header('Content-Length', len(data.encode()))
                self.end_headers()
                self.wfile.write(data.encode())
            # Error
            self.send_response(500)
            self.send_header('Content-Type', 'text/html')
            self.end_headers()

    def do_POST(self):
        # Imprimir nueva conexion
        print(f'[+] Nueva Conexion {self.client_address[0]}:{self.client_address[1]}')
        # Imprimir headers
        print(f''.ljust(50, '-'))
        print(self.requestline)
        print(self.headers)
        print(f''.ljust(50, '-'))
        # Ver el cuerpo de la peticion
        if isinstance(self.headers['Content-Length'], str):
            if int(self.headers['Content-Length']) != 0:
                body = self.rfile.read(int(self.headers['Content-Length']))
                print(body)
        # Enviar nada xd
        self.send_response(200)
        self.send_header('Content-Type', 'text/html')
        self.end_headers()
try:
    address = ('0.0.0.0', 8000)
    httpx = http.server.HTTPServer(address, Server)
except KeyboardInterrupt:
    print("[!] exit.")
except Exception as err:
    print(f'[!] {err}')
else:
    httpx.allow_reuse_address = True
    httpx.serve_forever()
finally:
    exit()
