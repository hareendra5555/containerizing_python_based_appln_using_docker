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
