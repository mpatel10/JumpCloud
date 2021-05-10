curl -X POST -H "application/json" http://127.0.0.1:8088/hash -d "{\"password\":\"!@#$%\"}"

curl -X POST -H "application/json" http://127.0.0.1:8088/hash -d "{\"password\":\"\"}"

curl -X POST -H "application/json" http://127.0.0.1:8088/hash -d "{\"password\":\")(*&\"}"

curl -X POST -H "application/json" http://127.0.0.1:8088/hash -d "{\"password\":\"angrymonkeyangrymonkeyangrymonkeyangrymonkeyangrymonkeyangrymonkeyangrymonkeyangrymonkeyangrymonkeyangrymonkeyangrymonkeyangrymonkeyangrymonkey\"}"

curl -X POST -H "application/json" http://127.0.0.1:8088/hash -d "{\"password\":\"a\"}"

curl -X POST -H "application/json" http://127.0.0.1:8088/hash -d "{\"password\":\"+_-=-1234\"}"


PAUSE