import requests

body = {
    "transaction": {
        "buyer": 13,
        "seller": 12,
        "image": 12345
    }
}

response = requests.post("http://localhost:8080/transaction", json=body)

print(response.status_code)
print(response.content)
