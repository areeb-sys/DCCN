from contextlib import closing
import socket
import threading

host = '127.0.0.1'
port = 5555

server_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_sock.bind((host, port))
server_sock.listen()

clients = []
names = []


def broadcast(msg):
    for client in clients:
        client.send(msg)


def handle(client):
    while True:
        try:
            msg = client.recv(1024)
            broadcast(msg)
        except:
            index = clients.index(client)
            clients.remove(client)
            client.close()
            nickname = names[index]
            broadcast(f'{nickname} left the chat!'.encode('ascii'))
            names.remove(nickname)
            break


def receive():
    while True:
        client, address = server_sock.accept()
        print(f'Connected With {str(address)}')
        client.send('NICK'.encode('ascii'))
        nickname = client.recv(1024).decode('ascii')
        names.append(nickname)
        clients.append(client)

        print(f'Nickname of the client is {nickname}')
        broadcast(f'{nickname} joined the chat'.encode('ascii'))
        client.send('Connected to server.'.encode('ascii'))

        thread = threading.Thread(target=handle, args=(client,))
        thread.start()


print('Server is listening .....')
receive()
