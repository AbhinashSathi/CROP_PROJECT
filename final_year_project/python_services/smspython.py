#+14582248810
#sidAC5f59871801f530762715e5db7575ea2d
#auth_tokena1f5ead745c02c492fda0950c5b48cd3
from twilio.rest import Client
import os
def sms():
    account_sid = "AC5f59871801f530762715e5db7575ea2d"
    auth_token = "a1f5ead745c02c492fda0950c5b48cd*"#3
    client = Client(account_sid, auth_token)
    message = client.messages.create(from_="+14582248810",body ="A Bird 🦜 Captured in Farm'\n'<--check App for detials-->'\n' iPhone:https://tinyurl.com/4xza47w7 '\n' android:https://cropproject/ ",to ="+91***********")
    print(message)
    print("\n\t\t\tSMS Done")
