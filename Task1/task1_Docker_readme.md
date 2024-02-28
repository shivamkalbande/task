#Task 1: Docker, Docker Hub

##Task Overview

- Create a Dockerfile for a simple web application (e.g. a Node.js or 
Python app)
- Build the image using the Dockerfile and run the container
- Verify that the application is working as expected by accessing it in a 
web browser
- Push the image to a public or private repository (e.g. Docker Hub)

---

Refrence URL
`https://tecadmin.net/how-to-create-and-run-a-flask-application-using-docker/`


sudo mkdir flask-app 
 cd flask-app/

 sudo apt install python3.10-venv
 python3 -m venv venv1
 sudo python3 -m venv venv1
 source venv1/bin/activate 
apt install python3-pip
pip install Flask 
pip freeze > requirements.txt
cd flask-app/ 
vim app.py


from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'Hello'

@app.route('/welcome')
def welcome():
    return 'Welcome'

if __name__ == '__main__':
    app.run(debug=True)

sudo vi Dockerfile
FROM python:3-alpine

# Create app directory
WORKDIR /app

# Install app dependencies
COPY requirements.txt ./

RUN pip install -r requirements.txt

# Bundle app source
COPY . .

EXPOSE 5000
CMD [ "flask", "run","--host","0.0.0.0","--port","5000"]

cd flask-app/

 flask run --host 0.0.0.0 --port 5000

 docker build -t flask-app .
 sudo docker images



