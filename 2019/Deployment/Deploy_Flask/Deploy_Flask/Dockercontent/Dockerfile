## This is to use python as base image
FROM python:3.5-slim

# Use working directory /app
WORKDIR /app

# Copy all the contents of current directory to /app directory
ADD . /app

# Installing required packages
Run pip install --trusted-host pypi.python.org -r requirements.txt

# Open port 80
EXPOSE 5000

#Set environment variable
ENV NAME OpentoAll

# Run Python program
CMD ["python","app.py"] 


