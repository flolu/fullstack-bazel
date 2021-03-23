SHELL := /usr/bin/env bash

.PHONY: auto-all
auto-all: setup

.PHONY: setup
setup:
	@source scripts/install-requirements.sh
	@source scripts/setup-project.sh
	@source scripts/ensure-credentials.sh

.PHONY: ensure-credentials
ensure-credentials:
	@source scripts/ensure-credentials.sh


.PHONY: plan-infrastructure
plan-infrastructure: ensure-credentials
	cd infrastructure && \
	terraform plan

.PHONY: create-infrastructure
create-infrastructure: ensure-credentials
	@echo "This will take ~10 minutes"
	@source scripts/create-infrastructure.sh

.PHONY: update-infrastructure
update-infrastructure: ensure-credentials
	@source scripts/update-infrastructure.sh

.PHONY: destroy-infrastructure
destroy-infrastructure: ensure-credentials
	@source scripts/destroy-infrastructure.sh


.PHONY: test-all
test-all: lint check-dependencies test test-integration

.PHONY: lint
lint:
	@source scripts/lint.sh

.PHONY: check-dependencies
check-dependencies:
	@source scripts/check-dependencies.sh

.PHONY: test
test:
	@source scripts/test.sh

.PHONY: test-integration
test-integration:
	@source scripts/test-integration.sh


.PHONY: client
client:
	@source scripts/start-client.sh

.PHONY: client-ssr
client-ssr:
	@source scripts/start-client-ssr.sh

.PHONY: server
server:
	@source scripts/start-server.sh


.PHONY: deploy
deploy:
	@source scripts/deploy.sh