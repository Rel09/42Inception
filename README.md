# Inception

This project is a part of the curriculum at 42Quebec, designed to introduce students to Docker and Docker-Compose. 

## Description

The objective was to set up a Docker-Compose environment using either Alpine or Debian Buster. The environment consists of three Docker containers: MariaDB, PhpFPM & WordPress, and NGINX. Two volumes were created, one for MariaDB and another for NGINX & WordPress/PhpFPM, along with a network. Custom Dockerfiles were utilized within Docker-Compose.

## Technologies Used

- Docker
- Docker-Compose
- Alpine Linux or Debian Buster
- MariaDB
- PhpFPM
- WordPress
- NGINX

## What I've Learned

In this project, I gained valuable insights into the differences between using Alpine Linux and Debian Buster in Docker environments. Debian Buster's utilization of APT made the installation process of PhpFPM, WordPress, and NGINX much simpler compared to Alpine. Although Alpine was notably faster in compilation, it required additional libraries to ensure everything worked seamlessly. Overall, this project provided an excellent opportunity to learn about the practical applications of Docker and its significance in modern development workflows.
