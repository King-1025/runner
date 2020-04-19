import time
import sys
import os
import requests
import json
import signal
import subprocess


if __name__ == "__main__":
   if os.path.exists("./values.json"):
      print("rm ./values.json")
      os.remove("./values.json")

   try:  
        port="5000"
        proc = subprocess.Popen("python3 ./reply_to_message.6.x.py %s" % port , shell=True)
        server_pid = proc.pid
        run_pid=None
        while 1:
         time.sleep(5)
         try:
           r=requests.get("http://0.0.0.0:5000/receive")
           if r.status_code == 200:
              print("data: %s\n" % r.text)
           r=requests.get("http://0.0.0.0:5000/isStart")
           if r.status_code == 200:
              data=json.loads(r.text)
              if not run_pid:
                 proc = subprocess.Popen('which twilio && twilio phone-numbers:update "+15108248999" --sms-url="http://0.0.0.0:5000/receive"', shell=True)
                 run_pid = proc.pid
              if data["status"] == "1":
                 print(data["message"])
                 print("server pid: %s" % str(server_pid))
                 print("run pid: %s" % str(run_pid))
                 if server_pid:
                    os.kill(server_pid, signal.SIGKILL)
                 if run_pid:
                    os.kill(run_pid, signal.SIGKILL)
                 break
         except Exception as e:
             pass
   except Exception as e:
      print(e)
