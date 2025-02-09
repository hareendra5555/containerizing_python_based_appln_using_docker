# Flask Calculator - Dockerized

## Overview
This is a simple Flask-based web application that performs basic arithmetic operations (addition, subtraction, multiplication, division). The application is containerized using Docker and deployed on an AWS EC2 instance.

## Features
- Web-based calculator UI (HTML, JavaScript, and Flask backend)
- Dockerized for easy deployment
- Hosted on an AWS EC2 instance
- Publicly available on Docker Hub

---

## Prerequisites

Before you begin, ensure you have the following:

- An **AWS EC2 instance** (Amazon Linux 2 or Ubuntu)
- **Docker installed** on the EC2 instance
- A **Docker Hub account**
- **Git installed** on the EC2 instance

---

## Step 1: Launch an EC2 Instance
1. Go to the [AWS Console](https://aws.amazon.com/console/), navigate to **EC2**, and launch an instance.
2. Select **Amazon Linux 2** or **Ubuntu** as your OS.
3. Choose an instance type (**t2.micro** for free-tier eligibility).
4. Configure **security group**:
   - Allow **port 22 (SSH)** for remote access.
   - Allow **port 5000 (Flask app)** for HTTP access.
5. Launch the instance and **connect via SSH**:
   ```sh
   ssh -i your-key.pem ec2-user@your-ec2-ip
   ```

---

## Step 2: Install Docker on EC2

### For **Amazon Linux 2**:
```sh
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
```
Then, **reconnect** to apply changes.

### For **Ubuntu**:
```sh
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu
```

---

## Step 3: Install Python and Flask

If your EC2 instance does not have Python installed:
```sh
sudo yum install python3 -y  # Amazon Linux
sudo apt install python3 -y  # Ubuntu
```
Then, install Flask:
```sh
pip3 install flask
```

---

## Step 4: Clone the Repository from GitHub
On your EC2 instance, clone the repository:
```sh
git clone https://github.com/your-github-username/FlaskCalculator.git
cd FlaskCalculator
```

---

## Step 5: Create the Dockerfile

Inside your **FlaskCalculator** directory, create a file named `Dockerfile`:
```sh
nano Dockerfile
```
Paste the following content:
```dockerfile
# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy application files to the container
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir flask

# Expose the application port
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]
```
Save and exit (`CTRL + X`, then `Y`, then `Enter`).

---

## Step 6: Build and Run the Docker Container

### 1. **Build the Docker Image**
```sh
docker build -t flask-calculator .
```

### 2. **Run the Container**
```sh
docker run -d -p 5000:5000 flask-calculator
```

### 3. **Verify the Running Container**
```sh
docker ps
```

---

## Step 7: Access Flask App
- Open a browser and visit:
  ```
  http://your-ec2-ip:5000
  ```
- If it's not accessible, **update your EC2 security group**:
  - Allow **port 5000** for **0.0.0.0/0** (for testing, restrict later).

---

## Step 8: Push Image to Docker Hub

### 1. **Login to Docker Hub**
```sh
docker login
```
Enter your **Docker Hub username** and **password**.

### 2. **Tag the Image**
Replace `your-docker-username` with your **actual Docker Hub username**.
```sh
docker tag flask-calculator your-docker-username/flask-calculator
```

### 3. **Push the Image**
```sh
docker push your-docker-username/flask-calculator
```

Your image is now **publicly available** on Docker Hub!

---

## Step 9: Pull & Run the Image on Another Machine (Optional)

To run the container on another machine or EC2 instance:
```sh
docker pull your-docker-username/flask-calculator
docker run -d -p 5000:5000 your-docker-username/flask-calculator
```

Now, your app is running from Docker Hub! 🚀

---


