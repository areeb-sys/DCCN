import socket
import threading

nickname = input('Choose a nickname: ')

client_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_sock.connect(('127.0.0.1', 5555))


def receive():
    while True:
        try:
            message = client_sock.recv(1024).decode('ascii')
            if message == 'NICK':
                client_sock.send(nickname.encode('ascii'))
            else:
                print(message)
        except:
            print('An error occured!')
            client_sock.close()
            break


def write():
    while True:
        message = f'{nickname}: {input("")}'
        client_sock.send(message.encode('ascii'))


receive_thread = threading.Thread(target=receive)
receive_thread.start()

write_thread = threading.Thread(target=write)
write_thread.start()
