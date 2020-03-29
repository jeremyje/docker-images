# Copyright 2020 Codecahedron Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

REGISTRY := docker.io/codecahedron
DOCKER := docker
DOCKER_TAG := latest

BUILD_DATE = $(shell date -u +'%Y-%m-%d')
BUILD_VERSION = 1.0.0
VCS_REF = $(shell git rev-parse HEAD)

all: builder ci

builder:
	$(DOCKER) build . -f coder/Dockerfile -t $(REGISTRY)/builder:$(BUILD_DATE) -t $(REGISTRY)/builder:$(DOCKER_TAG) -t $(REGISTRY)/builder:$(VCS_REF) -t $(REGISTRY)/builder:$(BUILD_VERSION)

push: push-builder

push-builder: builder
	$(DOCKER) push $(REGISTRY)/builder:$(BUILD_DATE)
	$(DOCKER) push $(REGISTRY)/builder:$(DOCKER_TAG)
	$(DOCKER) push $(REGISTRY)/builder:$(VCS_REF)
	$(DOCKER) push $(REGISTRY)/builder:$(BUILD_VERSION)

.PHONY : all builder push-builder
