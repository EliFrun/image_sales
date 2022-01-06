import requests

body = {}

response = requests.get("http://localhost:8080/image")

print(response.status_code)

print(response.content)



