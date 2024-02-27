##Task 2: AWS, Jenkins, Docker, CICD, NodeJS

###Task Overview



1. Setting up AWS Infrastructure:
2. Installing and Configuring Jenkins:
3. Setting up Docker:
4. Creating Node.js Application:
5. Implementing CICD Pipeline:


###Prerequisites

**Minimum hardware requirements:**

- 256 MB of RAM
- 1 GB of drive space (although 10 GB is a recommended minimum if running Jenkins as a Docker container)

**Recommended hardware configuration for a small team:**

- 4 GB+ of RAM
- 50 GB+ of drive space
- Comprehensive hardware recommendations:
- Hardware: see the Hardware Recommendations page

**Software requirements:**

- Java - Openjdk version "17.0.9" 2023-10-17
- Docker - Docker version 24.0.5
- Jenkins - v2.440.1
- NodeJS - v12.22.9
- npm - v8.5.1
- Linux operating system - AWS Ubuntu server 22.04
  


### 1.Setting up AWS Infrastructure:

Reference URL
>https://www.jenkins.io/doc/book/installing/linux/


- Create a key pair using Amazon EC2. If you already have one, you can skip to step 3.

![alt text](images/keypair.png)

- Create a security group for your Amazon EC2 instance and add inbound rules as below. If you already have one, you can skip to step 4.

![alt text](images/sg2.png)

- Launch an Amazon EC2 instance.

![alt text](images/ec2.png)

###2. Installing and Configuring Jenkins:

  Referance URL
  >https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/

![alt text](terraversion.png)
To install jenkins run below  command in terminal :
```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update  
sudo apt-get install jenkins
```
- Jenkins requires Java to run, yet not all Linux distributions include Java by default. Additionally, not all Java versions are compatible with Jenkins.
- Install JDK 17 on ubuntu  by running the following commands in the terminal:

```bash
sudo apt update
sudo apt install fontconfig openjdk-17-jre
java -version
openjdk version "17.0.8" 2023-07-18
OpenJDK Runtime Environment (build 17.0.8+7-Debian-1deb12u1)
OpenJDK 64-Bit Server VM (build 17.0.8+7-Debian-1deb12u1, mixed mode, sharing)
```


After running above command it will show your jenkins admin password .Copy that password for further use.

Open http://your_EC2_IP_address:8080 on the browser , You should see the Jenkins welcome page.

Now we need to setup docker plugin by following these steps :

- Go to Manage Jenkins -> Manage Plugins -> Available tab -> Docker Integr    ation ->Install without restart.
- Go to Manage Jenkins -> Manage Plugins -> Available tab -> Search Docker -> Click on Get It button -> Restart Jenkins Server    
  



- Clean up tutorial resources.

![alt text](terraversion.png)


###3. Setting up Docker:
Install docker on Ubuntu ec2 instance  using the following commands:



###4. Creating Node.js Application:

Install nodejs and npm  on EC2 instance:

```bash 
sudo apt install nodejs
sudo apt install npm
```
![alt text](images/npminstall.png)

Creating a simple "Hello, World!" Node.js web application involves several steps:
1.	Initialize the project:
•	Create a new directory for your project.

![alt text](images/initilize.png)

•	Open a terminal or command prompt and navigate to the directory you just created.
•	Run npm init -y to initialize a new Node.js project with default settings.

![alt text](images/npminit.png)

2.	Install Express (optional, but recommended for web applications):
•	Express is a popular web framework for Node.js that simplifies the process of creating web applications.
•	Run npm install express to install Express as a dependency for your project.

![alt text](images/npnexpress.png)

3.	Create the main application file:
•	Create a JavaScript file (e.g., app.js) in your project directory.
•	Open app.js in a text editor.
•	Write the code for your "Hello, World!" web application using Express. Below is a simple example:

![alt text](images/viapp.png)

Your project directory should look like this.

![alt text](images/projectdir.png)

Write your Hello world application as below.

app.js
```javascript
// Import the Express module
const express = require('express');

// Create an Express application
const app = express();

// Define a route handler for the root URL
app.get('/', (req, res) => {
  res.send('Hello, World!');
});

// Start the server and listen on port 8000
app.listen(8000, () => {
  console.log('Server is running on port 8000');
});

```

![alt text](images/appjs.png)

4.	Run the application:
•	In the terminal, navigate to your project directory.
•	Run node app.js to start the Node.js application.
node app.js

![alt text](images/runjs.png)

5.	Access the application:
•	Open a web browser and navigate to http://your-ec2public:8000.
•	You should see the message "Hello, World!" displayed in the browser.

![alt text](images/browser.png)

###5. Implementing CICD Pipeline:

To create a Dockerfile for your "Hello, World!" Node.js web application, you'll follow these steps:
1.	Create a Dockerfile: In your project directory, create a file named Dockerfile.

```bash
sudo vi Dockerfile
```

2.	Open the Dockerfile in a text editor and add the following content:
sudo vi Dockerfile
 
 ![alt text](images/appjs.png)

DockerfileCopy code

```hcl
# Use the official Node.js image with the LTS version
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Expose port 8000 to the outside world
EXPOSE 8000

# Command to run the application
CMD ["node", "app.js"]
```

3.	Save the Dockerfile.
This Dockerfile specifies a multi-stage build process:
•	It uses the official Node.js image with the LTS version as the base image.
•	It sets the working directory inside the container to /app.
•	It copies package.json and package-lock.json to the working directory and installs dependencies using npm install.
•	It copies the rest of the application code to the working directory.
•	It exposes port 0000 of the container to the outside world.
•	It specifies the command to run the application (node app.js).


With this Dockerfile, you can now build a Docker image for your Node.js application by running docker build . in the project directory. After the image is built, you can run a container based on the image using 
docker run -d -p 8000:8000 <image_id>
 This will start your Node.js application inside a Docker container, and you'll be able to access it at http://your-aws-ec2-publicip:8000.
