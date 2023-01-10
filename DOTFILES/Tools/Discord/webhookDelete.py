import requests
import sys

def webhook(webhook: str) -> None:
  req = requests.get(webhook)
  
  if req.status_code  == 200:
    requests.delete(webhook)
    print('Webhook deleted')
  else:
    print('Webhook delete error')
  
if __name__ == "__main__":
  webhook(sys.argv[1])