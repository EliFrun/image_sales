import requests

body = {}

response = requests.delete("http://localhost:8080/user/13")

print(response.status_code)

print(response.content)



