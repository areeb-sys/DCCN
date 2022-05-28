# mailling program
import smtplib
from email import encoders
from email.message import Message
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase

server = smtplib.SMTP_SSL('smtp.gmail.com', 465)

server.ehlo()

with open('password.txt', 'r') as f:
    password = f.read()

server.login('fa19-bse-022@cuilahore.edu.pk', password)

msg = MIMEMultipart()
msg['From'] = 'Areeb Ahmed'
msg['To'] = 'areebnaseer290@gmail.com'
msg['Subject'] = 'Testing mail tester 1'

with open('message.txt', 'r') as f:
    message = f.read()

msg.attach(MIMEText(message, 'plain'))

filename1 = 'test-pass.jpg'

attachment = open(filename1, 'rb')

p = MIMEBase('application', 'octet-stream')

p.set_payload(attachment.read())

encoders.encode_base64(p)

p.add_header('Content-Disposition', 'attachment', filename=filename1)

msg.attach(p)


text = msg.as_string()
server.sendmail('fa19-bse-022@cuilahore.edu.pk', 'areebnaseer290@gmail.com', text)
