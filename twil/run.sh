#!/usr/bin/env bash

function app()
{
  #setup
  cd ./twil && python3 ./main.py 
}

function setup()
{
   sudo apt update -y && sudo apt install libsecret-1-dev -y
   npm install twilio-cli -g
   pip install Flask>=0.12
   pip install twilio~=6.0.0
}

app $*
