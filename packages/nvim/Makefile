# Makefile for Neovim Development Container

# Name of the Docker image
IMAGE_NAME=development-nvim
# Makefile

# Dynamically get the current user's UID and GID
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)
USERNAME=$(shell whoami)

# Build the Docker image with the current user's UID and GID
build:
	docker volume create $(IMAGE_NAME)
	docker build --build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) --build-arg USERNAME=$(USERNAME) -t $(IMAGE_NAME) .
explore:
	docker run -it $(IMAGE_NAME) /bin/bash
.PHONY: build
