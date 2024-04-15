# Use an official Python runtime as the base image
FROM python:3.8.13-slim

# Set the working directory in the container
WORKDIR /app

# # Copy the requirements file into the container
# COPY requirements.txt .

# # Install the Python dependencies
# RUN pip install --no-cache-dir -r requirements.txt

# Install conda and additional packages
RUN apt-get update && apt-get install -y wget && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    /opt/conda/bin/conda install -c pytorch pytorch=1.10.0 torchvision cudatoolkit=11.3 -y && \
    /opt/conda/bin/conda install -c conda-forge jupyterlab torchinfo torchmetrics -y && \
    /opt/conda/bin/conda install -c anaconda pip -y && \
    /opt/conda/bin/conda install pandas matplotlib scikit-learn -y

# Copy the rest of the application code into the container
COPY . .

# Set the command to run your application
CMD [ "python", "app.py" ]