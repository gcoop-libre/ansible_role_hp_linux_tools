SHELL:=/bin/bash

PLAYBOOK      ?= $$([[ -e test.yml ]] && echo 'test.yml' || echo 'main.yml')
ROLE_NAME     ?= $$([[ -e meta/main.yml ]] && awk '/role_name:/ {print $$2}' meta/main.yml)
ROLE_COMPANY  ?= $$([[ -e meta/main.yml ]] && awk '/company:/   {print $$2}' meta/main.yml)
ROLE_OWNER    ?= $$([[ "$(ROLE_COMPANY)" = 'gcoop' ]] && echo gcoop-libre.$(ROLE_NAME))
DEBUG         ?= -vvv
ENV           ?= master
SUDO          ?=
GIT_TYPE      ?= $$(git config --get remote.origin.url | grep -o http)
GIT_HTTP      ?= $$(git config --get remote.origin.url | grep http | rev | cut -d/ -f2- | rev | sed 's/:\//\//g')
GIT_HOST      ?= $$(git config --get remote.origin.url | cut -d: -f1)
GIT_BASE      ?= $$(git config --get remote.origin.url | cut -d: -f2 | cut -d/ -f2)
GIT_URL       ?= $$([[ "$(GIT_TYPE)" = 'http' ]] && echo $(GIT_HTTP) || echo $(GIT_HOST):/$(GIT_BASE))
INVENTORY     ?= inventory
GROUP         ?= wst
HOSTS_SUFFIX  ?= -$(GROUP)
EXTRA_PREFIX  ?= $(GROUP)_
HOSTS         ?= $(INVENTORY)/hosts$(HOSTS_SUFFIX)
VARS          ?= $(INVENTORY)/group_vars/$(EXTRA_PREFIX)extra_vars.yml
EXTRA         ?= $$([[ -e "$(VARS)" ]] && echo '-e @$(VARS)' )
LIMIT         ?=
HOSTS_LIMIT   ?= $$([[ -z "$(LIMIT)" ]] || echo '--limit $(LIMIT)' )
INVENTORY_DIR ?= $$([[ -d tests/roles ]] && echo "tests/$(INVENTORY)" || echo "$(INVENTORY)")
VAULT_ID      ?= dev

playbook: requirements inventory_env
	[[ -d 'tests' ]] && cd tests; ansible-playbook $(DEBUG) -i $(HOSTS) $(HOSTS_LIMIT) $(SUDO) $(EXTRA) $(PLAYBOOK)

playbook_only:
	[[ -d 'tests' ]] && cd tests; ansible-playbook $(DEBUG) -i $(HOSTS) $(HOSTS_LIMIT) $(SUDO) $(EXTRA) $(PLAYBOOK)

requirements:
	[[ -d 'tests/roles' ]] && cd tests;[[ -d 'roles' ]] && cd roles; [[ -e 'requirements.yml' ]] && ansible-galaxy install -r requirements.yml -p . --force || exit 0

inventory:
	[[ -d $(INVENTORY_DIR) ]] || git clone $(GIT_URL)/$(INVENTORY) $(INVENTORY_DIR)

inventory_env: inventory
	cd $(INVENTORY_DIR) && git checkout $(ENV);git pull

pre-commit:
	./pre-commit.sh $(GIT_URL)/external/ansible_lint

lint:
	[[ -d 'tests' ]] && cd tests; ansible-lint $(DEBUG) $(PLAYBOOK)

syntax:
	[[ -d 'tests' ]] && cd tests; ansible-playbook $(DEBUG) -i $(HOSTS) --syntax-check $(PLAYBOOK)

vault:
	./vault_identity_list.sh $(VAULT_ID)
