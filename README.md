### About

This project parses user requests and performs appropriate tasks
The program stores a list of first_names, last_names and age
The program will perform an action based on the HTTP Verbs

* GET - Will display resource
* POST - Will add resource
* PUT - Will updata resource
* DELETE - Will delete resource

### Examples

```
##Displays all users
GET http://localhost:3000/users HTTP/1.1

##Displays user with that ID
GET http://localhost:3000/users/1 HTTP/1.1

##Displays user with that name
GET http://localhost:3000/users?first_name=s

##Displays users within ID range
GET http://localhost:3000/users?limit=10&offset=10

##Deletes User
DELETE http://localhost:3000/users/1

##Adds User to resource
POST http://localhost:3000/users 'first_name:"Justin",last_name:"Herrick",age:"99"' HTTP/1.1

##Updates user at ID
PUT http://localhost:3000/users/1 'age:"9999999"' HTTP/1.1 
```
