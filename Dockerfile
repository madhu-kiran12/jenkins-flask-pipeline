# Use Python base image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy requirements from the app folder
COPY app/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY app/ .

# Expose Flask port
EXPOSE 5000

# Command to run Flask
CMD ["python", "app.py"]

