SHELL := /usr/bin/env bash

.DEFAULT_GOAL := help

PYTHON ?= python3
PLUGIN_CREATOR_ROOT ?= $(HOME)/.codex/skills/.system/plugin-creator
SKILL_CREATOR_ROOT ?= $(HOME)/.codex/skills/.system/skill-creator
LOCAL_INSTALLER := ./scripts/install-local.sh

.PHONY: help validate validate-version validate-plugin validate-skills check-diff \
	install-local install-codex install-claude install-gemini install-copilot dry-run

help: ## Show the available targets
	@awk 'BEGIN {FS = ":.*## "; printf "Usage: make <target>\n\nTargets:\n"} \
		/^[a-zA-Z0-9_-]+:.*## / {printf "  %-18s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

validate: validate-version validate-plugin validate-skills check-diff ## Run all project validations

validate-version: ## Check SemVer and synchronized manifest versions
	node scripts/check-version.js

validate-plugin: ## Validate the Codex plugin manifest
	$(PYTHON) $(PLUGIN_CREATOR_ROOT)/scripts/validate_plugin.py .

validate-skills: ## Validate both bundled skills
	$(PYTHON) $(SKILL_CREATOR_ROOT)/scripts/quick_validate.py skills/semver
	$(PYTHON) $(SKILL_CREATOR_ROOT)/scripts/quick_validate.py skills/semver-review

check-diff: ## Check the working tree for whitespace errors
	git diff --check

install-local: ## Install or update the source in every local harness
	$(LOCAL_INSTALLER) all

install-codex: ## Install or update the source in Codex
	$(LOCAL_INSTALLER) codex

install-claude: ## Install or update the source in Claude Code
	$(LOCAL_INSTALLER) claude

install-gemini: ## Link the source in Gemini CLI
	$(LOCAL_INSTALLER) gemini

install-copilot: ## Install or update the source in GitHub Copilot CLI
	$(LOCAL_INSTALLER) copilot

dry-run: ## Preview all local installation commands
	$(LOCAL_INSTALLER) all --dry-run
