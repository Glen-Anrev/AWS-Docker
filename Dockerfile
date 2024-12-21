# Use the official AWS Glue image from the Docker Hub
FROM amazon/aws-glue-libs:glue_libs_4.0.0_image_01

# Install pip and other utilities using yum
USER root
RUN yum update -y && \
    yum install -y python3-pip bash && \
    python3 -m pip install --upgrade pip && \
    yum clean all

# Set up the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt ./

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the entire current directory into the container
COPY . ./

# Set environment variables (optional, replace with actual values or use docker-compose to pass them)
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}