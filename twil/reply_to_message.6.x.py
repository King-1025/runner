#!/usr/bin/env python3

# Download the twilio-python library from twilio.com/docs/libraries/python
from flask import Flask, request
from twilio.twiml.messaging_response import MessagingResponse
import json
import os
import logging


logging.basicConfig(level=logging.ERROR)

app = Flask(__name__)

@app.route("/isStart", methods=['GET', 'POST'])
def is_start():
    ff="./values.json"
    ss=json.dumps({"status":"0", "pid":str(os.getpid())})
    if os.path.exists(ff):
       with open(ff, "r") as f:
           ss=str(f.read())
    return ss

@app.route("/receive", methods=['GET', 'POST'])
def receive():
    status=0
    message=request.values
    ss=json.dumps({"status":str(status), "pid":str(os.getpid()), "message":str(message)})
    with open("./values.json", "w") as f:
        f.write(ss)

    resp = MessagingResponse()
    resp.message("oK!")
    return str(resp)

@app.route("/", methods=['GET', 'POST'])
def sms_ahoy_reply():
    """Respond to incoming messages with a friendly SMS."""
    # Start our response
    resp = MessagingResponse()

    # Add a message
    resp.message("Ahoy! Thanks so much for your message.")

    return str(resp)

import sys

if __name__ == "__main__":
    if len(sys.argv) >= 2:
      app.run(debug=False, host="0.0.0.0", port=int(sys.argv[1]))
    else:
      print("port ?")     
