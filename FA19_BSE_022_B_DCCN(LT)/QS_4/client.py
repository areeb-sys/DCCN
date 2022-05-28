import socket
import threading

name = input('Choose a Name: ')

client_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_sock.connect(('127.0.0.1', 5555))


def receive():
    while True:
        try:
            msg = client_sock.recv(1024).decode('ascii')
            if msg == 'NICK':
                client_sock.send(name.encode('ascii'))
            else:
                print(msg)
        except:
            print('An error occured!')
            client_sock.close()
            break

def write():
    while True:
        msg = f'{name}: {input("")}'
        client_sock.send(msg.encode('ascii'))

receive_thread = threading.Thread(target=receive)
receive_thread.start()

write_thread = threading.Thread(target=write)
write_thread.start()
