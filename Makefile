# Makefile that builds go-hello-world, a "go" program.

# PROGRAM_NAME is the name of the GIT repository.
PROGRAM_NAME := $(shell basename `git rev-parse --show-toplevel`)
DOCKER_IMAGE_NAME := local/$(PROGRAM_NAME)
DOCKER_CONTAINER_NAME := $(PROGRAM_NAME)
GIT_VERSION := $(shell git describe --always --tags --abbrev=0)
GIT_ITERATION := $(shell git rev-list HEAD | wc -l)

.PHONY: help
help:
	@echo "Build $(PROGRAM_NAME) version $(GIT_VERSION)-$(GIT_ITERATION)".
	@echo "Targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs


.PHONY: build
build:
	mkdir -p ./target
	docker build \
		--build-arg PROGRAM_NAME=$(PROGRAM_NAME) \
		--build-arg GIT_VERSION=$(GIT_VERSION) \
		--build-arg GIT_ITERATION=$(GIT_ITERATION) \
		--tag $(DOCKER_IMAGE_NAME) \
		.


.PHONY: compile
compile: build
	docker create \
		--name $(DOCKER_CONTAINER_NAME) \
		$(DOCKER_IMAGE_NAME)
	docker cp $(DOCKER_CONTAINER_NAME):/$(PROGRAM_NAME)-$(GIT_VERSION)-$(GIT_ITERATION).x86_64.rpm ./target/
	docker cp $(DOCKER_CONTAINER_NAME):/$(PROGRAM_NAME)_$(GIT_VERSION)-$(GIT_ITERATION)_amd64.deb ./target/
	docker cp $(DOCKER_CONTAINER_NAME):/root/gocode/bin/$(PROGRAM_NAME) ./target/
	docker rm  --force $(DOCKER_CONTAINER_NAME)


.PHONY: run
run:
	docker run \
	    --interactive \
	    --tty \
	    --name $(DOCKER_CONTAINER_NAME) \
	    $(DOCKER_IMAGE_NAME)


.PHONY: clean
clean:
	docker rm --force $(DOCKER_CONTAINER_NAME) || true
	rm -rf ./target
