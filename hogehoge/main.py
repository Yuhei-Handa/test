from http.server import BaseHTTPRequestHandler, HTTPServer


def hello() -> str:
    return "hello"


def server() -> None:
    print("server start on http://localhost:8000/")
    server_address = ("", 8000)
    httpd = HTTPServer(server_address, BaseHTTPRequestHandler)
    httpd.serve_forever()
