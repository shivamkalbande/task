
Prerequisites
Minimum hardware requirements:

256 MB of RAM

1 GB of drive space (although 10 GB is a recommended minimum if running Jenkins as a Docker container)

Recommended hardware configuration for a small team:

4 GB+ of RAM

50 GB+ of drive space

Comprehensive hardware recommendations:

Hardware: see the Hardware Recommendations page

Software requirements:

Java: see the Java Requirements page

Web browser: see the Web Browser Compatibility page

For Windows operating system: Windows Support Policy

For Linux operating system: Linux Support Policy

For servlet containers: Servlet Container Support Policy


Install Jenkins on on ubuntu ec2 VM.

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update  
sudo apt-get install jenkins