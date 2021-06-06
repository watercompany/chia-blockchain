SHELL			:= /bin/bash
PROJECT			:= chia-blockchain
GIT_TAG			:= $(shell git log -1 --pretty=format:"%h")
DOCKER_IMG		:= ${PROJECT}:${GIT_TAG}
.DEFAULT_GOAL	:= help

user=
password=
.PHONY: docker-login
docker-login: ## Login to Docker Hub
	docker login -u $(user) -p $(password)

.PHONY: docker-build
docker-build: ## Build the Docker image
	docker build --tag $(DOCKER_IMG) --rm=false Docker

user=
.PHONY: docker-push
docker-push: ## Push the latest Docker image to DockerHub
	docker tag $(DOCKER_IMG) $(user)/$(DOCKER_IMG)
	docker push $(user)/$(DOCKER_IMG)

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
