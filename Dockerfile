# Use official Node.js image
FROM node:14

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Bundle app source code
COPY . .

# Expose port and run app
EXPOSE 3000
CMD ["node", "app.js"]



 Create a Node.js Sample Application
Set up Node.js:

Install Node.js:

Copy code
sudo apt-get install nodejs npm
Verify installation:

Copy code
node -v
npm -v
Create a Sample Project:

In your WSL terminal, create a directory for your project:

Copy code
mkdir nodeapp && cd nodeapp
Initialize a Node.js project:

Copy code
npm init -y
Create an app.js file:

Copy code
touch app.js
Add the following code to app.js:
javascript
Copy code
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello from Dockerized Node.js app!');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
Install dependencies:

Copy code
npm install express
Step 3: Create a Dockerfile for Node.js App
Create a Dockerfile:

Create a Dockerfile inside the nodeapp directory:

Copy code
touch Dockerfile
Add the following code:
dockerfile
Copy code
# Use official Node.js image
FROM node:14

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Bundle app source code
COPY . .

# Expose port and run app
EXPOSE 3000
CMD ["node", "app.js"]
Build Docker Image:

Build the Docker image using the following command:

Copy code
docker build -t nodeapp .
Run Docker Container:

Run the container:

Copy code
docker run -p 3000:3000 nodeapp
Visit http://localhost:3000 to see your app running!
Step 4: Push Docker Image to Docker Hub (Optional)
Log in to Docker Hub:


Copy code
docker login
Tag and Push the Image:


Copy code
docker tag nodeapp yourusername/nodeapp
docker push yourusername/nodeapp

 Kubernetes Setup and Deployment
Enable Kubernetes in Docker Desktop:

Go to Docker Desktop Settings > Kubernetes and enable Kubernetes.
Confirm it's running by using:

Copy code
kubectl version
Create Kubernetes Deployment YAML:

Create a deployment.yaml file:

Copy code
touch deployment.yaml
Add the following code:
yaml
Copy code
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodeapp-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nodeapp
  template:
    metadata:
      labels:
        app: nodeapp
    spec:
      containers:
      - name: nodeapp
        image: yourusername/nodeapp:latest
        ports:
        - containerPort: 3000
Create a Service for the Deployment:

Add a service.yaml file:
bash
Copy code
touch service.yaml
Add the following content:
yaml
Copy code
apiVersion: v1
kind: Service
metadata:
  name: nodeapp-service
spec:
  type: LoadBalancer
  selector:
    app: nodeapp
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
Deploy the App to Kubernetes:

Apply the deployment:
bash
Copy code
kubectl apply -f deployment.yaml

Expose the service:
bash
Copy code
kubectl apply -f service.yaml

Get the external IP to access the service:
bash
Copy code
kubectl get services

Step 6: Access Your Application
Once the service is up, you can access your Node.js app via the external IP provided by Kubernetes.
Kubernetes Cluster Prerequisites:
WSL 2 enabled with Docker Desktop.
Kubernetes configured with at least 1 node.
kubectl installed to manage your cluster.

Why Use Each Command:
docker build: Builds a Docker image from the Dockerfile.
docker run: Runs a container from the Docker image.
kubectl apply -f: Applies the Kubernetes configuration (deployments and services).
kubectl get services: Retrieves the status and external IP of your service in Kubernetes.
