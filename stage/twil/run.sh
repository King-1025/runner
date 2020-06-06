#!/usr/bin/env bash

function app()
{

export TWILIO_ACCOUNT_SID=ACb4b25cbb014368506605a73f0103a0aa 
export TWILIO_API_KEY=SK32e05ab06300ba9a1d65420a168b00c0
export TWILIO_API_SECRET=TNjZJPXFMdImosL7UEMhU3UbN7mPzrLh

export TWILIO_AUTH_TOKEN=5e2340593d725183868abb909786b346

#setup &&
	python3 ./main.py 
}

function setup()
{
#   sudo apt update -y && sudo apt install libsecret-1-dev -y
   npm install twilio-cli -g
   pip install Flask>=0.12
   pip install twilio~=6.0.0
   pip install requests
}

app $*
