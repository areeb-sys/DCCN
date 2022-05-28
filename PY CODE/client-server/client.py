import socket

HEADER = 64
PORT = 5050
SERVER = '192.168.56.1'
ADDR = (SERVER, PORT)
FORMAT = 'utf-8'
DISCONNECT_MESSAGE = 'DISCONNECTED!'

cli = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
cli.connect(ADDR)


def send(msg):
    messg = msg.encode(FORMAT)
    msg_length = len(messg)
    send_length = str(msg_length).encode(FORMAT)
    send_length += b' ' * (HEADER - len(send_length))
    cli.send(send_length)
    cli.send(messg)
    print(cli.recv(2048).decode(FORMAT))


send('Hello ')
input()
send('Hello BOII')
input()
send('HYEEE')

send(DISCONNECT_MESSAGE)
