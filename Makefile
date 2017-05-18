# The following env variables need to be set:
# - VERSION
# - GITHUB_USER
# - GITHUB_TOKEN (optional if you have two factor authentication in GitHub)

# Use the version number to figure out if the release is a pre-release
PRERELEASE=$(shell echo $(VERSION) | grep -E 'dev|rc|alpha|beta' --quiet && echo 'true' || echo 'false')
COMPONENTS=common couchdb letsencrypt-standalone php5 users
COMPONENTS_DIR=.
COMPONENTS_PREFIX=ansible-
COMPONENTS_HOST=git@github.com
CURRENT_BRANCH=$(shell git branch | grep '*' | tr -d '* ')

# GitHub settings
UPLOAD_HOST=https://uploads.github.com
API_HOST=https://api.github.com
OWNER=Chialab
REMOTE=origin

ifdef GITHUB_TOKEN
	AUTH=-H 'Authorization: token $(GITHUB_TOKEN)'
else
	AUTH=-u $(GITHUB_USER) -p$(GITHUB_PASS)
endif

DASH_VERSION=$(shell echo $(VERSION) | sed -e s/\\./-/g)

ALL: help
.PHONY: help test need-version bump-version tag-version

help:
	@echo "Ansible Roles Makefile"
	@echo "======================"
	@echo ""
	@echo "release"
	@echo "  Create a new release of Ansible Roles. Requires the VERSION and GITHUB_USER, or GITHUB_TOKEN parameter."
	@echo ""
	@echo "components"
	@echo "  Split each of the public namespaces into separate repos and push the to GitHub."
	@echo ""
	@echo "All other tasks are not intended to be run directly."

# Utility target for checking required parameters
guard-%:
	@if [ "$($*)" = '' ]; then \
		echo "Missing required $* variable."; \
		exit 1; \
	fi;

# Tag a release
tag-release: guard-VERSION
	@echo "Tagging $(VERSION)"
	git tag -s $(VERSION) -m "Ansible Roles $(VERSION)"
	git push $(REMOTE)
	git push $(REMOTE) --tags

# Tasks for publishing separate repositories out of each Ansible role namespace
components-test: $(foreach component, $(COMPONENTS), test-component-$(component))
components: $(foreach component, $(COMPONENTS), component-$(component))
components-tag: $(foreach component, $(COMPONENTS), tag-component-$(component))

test-component-%:
	@echo "Checking syntax for the $* component"
	@ansible-playbook $*/tests/test.yml -i $*/tests/inventory --syntax-check

component-%: test-component-%
	git checkout $(CURRENT_BRANCH) > /dev/null
	- (git remote add $* $(COMPONENTS_HOST):$(OWNER)/$(COMPONENTS_PREFIX)$*.git -f 2> /dev/null)
	- (git branch -D $* 2> /dev/null)
	git checkout -b $*
	git filter-branch --prune-empty --subdirectory-filter $(COMPONENTS_DIR)/$(shell php -r "echo strtolower('$*');") -f $*
	git push -f $* $*:$(CURRENT_BRANCH)
	git checkout $(CURRENT_BRANCH) > /dev/null

tag-component-%: component-% guard-VERSION guard-GITHUB_USER
	@echo "Creating tag for the $* component"
	git checkout $*
	curl $(AUTH) -XPOST $(API_HOST)/repos/$(OWNER)/$*/git/refs -d '{ \
		"ref": "refs\/tags\/$(VERSION)", \
		"sha": "$(shell git rev-parse $*)" \
	}'
	git checkout $(CURRENT_BRANCH) > /dev/null
	git branch -D $*
	git remote rm $*

# Top level alias for doing a release.
release: guard-VERSION tag-release components-tag
