import requests
import sys

url = 'https://discord.com/api/v9/users/@me'

def main(token):
  header = {'Authorization': token}
  req = requests.get(url, headers=header)
  params = ['id', 'username', 'locale', 'premium_type', 'email', 'mfa_enabled']
  
  if req.status_code == 200:
    data = req.json()
    for x in params:
      print(x + ': ' + str(data[x]))
  else:
    print('Token not found')

if __name__ == '__main__':
  main(sys.argv[1])