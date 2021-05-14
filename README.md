# JumpCloud
Jumpcloud QA Assignment 

**Note:** I have also uploaded batch files that I used for testing various scenarios for POST method including positive & negative testing. Scenarios are listed below (#1-9).

**Password Hashing Application Specification**

**Tested following scenarios as stated.**

● When launched, the application should wait for http connections.  			                  YES, working as expected.

● It should answer on the PORT specified in the PORT environment variable.		              YES, working as expected.

● It should support three endpoints:							                                          YES, working as expected.
○ A POST to /hash should accept a password. It should return a job identifier
immediately. It should then wait 5 seconds and compute the password hash.
The hashing algorithm should be SHA512.

○ A GET to /hash should accept a job identifier. It should return the base64		            YES, working as expected.
encoded password hash for the corresponding POST request.

○ A GET to /stats should accept no data. It should return a JSON data structure		          YES, working as expected.
for the total hash requests since the server started and the average time of a
hash request in milliseconds.

● The software should be able to process multiple connections simultaneously.		            YES, working as expected.

● The software should support a graceful shutdown request. Meaning, it should allow any	    YES, working as expected.
in-flight password hashing to complete, reject any new requests, respond with a 200 and
shutdown.

● No additional password requests should be allowed when shutdown is pending.		            YES, working as expected.


**Ran below testing scenarios in windows command prompt**

1. POST -- curl -X POST -H "application/json" http://127.0.0.1:8088/hash -d "{\"password\":\"angrymonkey\"}"
Result: Added escape character back slashed (\) to run the command and received expected response. Without escape character, was getting Malformed Input error.

2. GET --  curl -H "application/json" http://127.0.0.1:8088/hash/1
Result: It returned the incrypted password. Working as expected. 


3. GET --  curl http://127.0.0.1:8088/stats
Result: It returned the Totalrequests and averagetime as expetced. 


4. POST -- curl -X POST -d "shutdown" http://127.0.0.1:8088/hash
Result: Added escape character double quotes ("") instead signal quote, as was getting Malformed Input error.


5. Ran mutltiple POST requests together; application ran those correctly.


6. Application closed and received valid response
Result:
C:\Users\ThinkPad\Documents\broken-hashserve\broken-hashserve>curl -X POST -d "shutdown" http://127.0.0.1:8088/hash -Li
HTTP/1.1 200 OK
Date: Mon, 10 May 2021 03:20:16 GMT
Content-Length: 0
Content-Type: text/plain; charset=utf-8

7. Ran mutltiple POST requests together; intiated shutdown. It rejected pending requests and stopped processing further.

8. Negative test: Submitted POST request using batch file with blank password; it returned Malformed Input error.
Result:
C:\WINDOWS\system32>curl -X POST -H "application/json" http://127.0.0.1:8088/hash -d "{\"password\":\")(*  & \"}"
Malformed Input
'\"}"' is not recognized as an internal or external command,
operable program or batch file.

9. Other Negative tests: Submitted several different POST requests using batch files where I tested using special characters, alpha-numeric, 
extra long password, and short password in password field.
Result: There were all submitted without error.


10. I submitted same request 6 times with same password. I see application storing same encrypted password 6 times. So its creating duplicate records. I am not sure how the backend database is storing it.
Ex: Stat ID # 6: NN0PAKtieayiTY8/Qd53AeMzHkbvZDdwYYiDnwtDdv/FIWvcy1sKCb7qi7Nu8Q8Cd/MqjQeyCI0pWKDGp74A1g==

Ex: Stat ID # 1: NN0PAKtieayiTY8/Qd53AeMzHkbvZDdwYYiDnwtDdv/FIWvcy1sKCb7qi7Nu8Q8Cd/MqjQeyCI0pWKDGp74A1g==


11. In related to previous test (#10); returning stats in "TotalRequest" is it referring to number of new requests or number of records? 
 I am getting response as {"TotalRequests":6,"AverageTime":0}. So, it seems its adding same requests as "new" request and also average time is not updating sometimes.

