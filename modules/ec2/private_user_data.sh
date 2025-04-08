#!/bin/bash
yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker
docker run -d -p 8080:8080 my-backend-image
