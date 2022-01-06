import requests

body = {
    "users": [
        {
            "user_id": 12,
            "name": "foo bar",
            "balance": 1000.00,
            "api_key": "password"
        },
         {
            "user_id": 13,
            "name": "bar baz",
            "balance": 1000.00,
            "api_key": "password1"
        }
    ]
}

response = requests.post("http://localhost:8080/user", json=body)

print(response.status_code)
print(response.content)



body = {
    "images": [
        {
            "image_id": 12345,
            "name": "foo",
            "owner": 12,
            "price": 30.50,
            "properties": ["foo", "bar", "baz"]
        },
        {
            "image_id": 1234,
            "name": "foo",
            "owner": 12,
            "price": 40.40,
            "properties": ["foo", "bar", "baz"]
        }
    ]
}

response = requests.post("http://localhost:8080/image", json=body)

print(response.status_code)
print(response.content)



