# Welcome to My Users App

## Task
The task of My Users App is to manage user data using Sinatra and SQLite3, implementing CRUD operations and session management.

## Description
My Users App is a Sinatra-based web application that provides endpoints to create, read, update, and delete user data stored in an SQLite3 database. It includes session management for user authentication and authorization.

## Installation
To install and run My Users App locally, follow these steps:

1. Clone the repository:
   ```
   git clone <repository_url>
   cd my_users_app
   ```

2. Install dependencies using Bundler:
   ```
   bundle install
   ```

3. Set up the SQLite3 database:

4. Run the Sinatra application:
  

## Usage
1. To start the server, run:
```bash
bundle exec ruby app.rb -p 8080 -o 0.0.0.0
```

2. In another Terminal, try this commands below:

### Endpoints

#### GET `/users`
- Retrieves all users from the database (without passwords).

Example:
```bash
curl -X GET http://web-va89167dc-8580.docode.fi.qwasar.io/users
```

#### POST `/users`
- Creates a new user in the database. Requires parameters: `firstname`, `lastname`, `age`, `password`, `email`.

Example:
```bash
curl -X POST http://web-va89167dc-8580.docode.fi.qwasar.io/users -d "firstname=Janet" -d "lastname=Musa" -d "age=25" -d "password=securepassword" -d "email=janetmusa@example.com"
```

#### POST `/sign_in`
- Authenticates a user based on email and password, sets a session with `user_id`.

Example:
```bash
curl -i -X POST http://web-va89167dc-8580.docode.fi.qwasar.io/sign_in -d "email=janetmusa@example.com" -d "password=securepassword"
```

#### PUT `/users`
- Updates the password of the logged-in user. Requires `new_password` as a parameter.

Example:
```bash
curl -X PUT http://web-va89167dc-8580.docode.fi.qwasar.io/users -d "new_password=newsecurepassword" --cookie "session_id=<your_session_id>"
```


#### DELETE `/users/:id`
- Deletes a user with the specified `:id` from the database. Requires authentication.

Example:
```bash
curl -X DELETE http://web-va89167dc-8580.docode.fi.qwasar.io/users/1 --cookie "session_id=<your_session_id>"
```

3. To view on browser, use this url:
 ```bash
http://web-va89167dc-8580.docode.fi.qwasar.io
```

### The Core Team
ESTHER NEHEMIAH - OTNI

<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering Schools Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>
