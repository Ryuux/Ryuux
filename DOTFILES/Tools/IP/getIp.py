import requests
import sys
        
def ip(ip: str) -> None:
  req = requests.get(f'http://ip-api.com/json/{ip}')
  
  if req.status_code == 200:
    for params in req.json():
      print(f"{params}: {req.json()[params]}")
        
if __name__ == "__main__":
  ip(sys.argv[1])  