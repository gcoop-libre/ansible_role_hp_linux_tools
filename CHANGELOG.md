# [_ANSIBLE_ROLE_HP_LINUX_TOOLS CHANGELOG_](https://gitlab.com/gcoop-libre/ansible_role_hp_linux_tools)

 - this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html)

## [`Unreleased - 2023-12-15`](https://gitlab.com/gcoop-libre/ansible_role_hp_linux_tools/-/compare/v0.2.5...develop)

### `CHANGELOG`

- add CHANGELOG.md from v0.1.0 to v0.2.4

### `README`

- add v0.2.4 in Tags Summary
- add Tags Summary section

## [`v0.2.5 - 2023-12-15`](https://gitlab.com/gcoop-libre/ansible_role_hp_linux_tools/-/compare/v0.2.4...v0.2.5) _add support for multiple versions of HP Linux Tools (currently versions 3.21 and 3.22), improve network interface and PCI device ID detection and better validations, and include test results from HP G5 and G6_

### `defaults/defaults`

- get the latest version of HP Linux Tools
- add all variables to support multiple versions of HP Linux Tools (currently versions 3.21 and 3.22)
- remove hardcoded hplt_flash_name
- by default disable clean HP Linux Tools directory

### `defaults/dmi`

- add tested HP ProDesk 400 G6 Desktop Mini PC (bios_date=11/04/2021, bios_version=S23 Ver. 02.09.02)

### `defaults/file`

- gets the URL for the selected version of HP Linux Tools
- gets the filename for the selected version of HP Linux Tools
- gets the checksum for the selected version of HP Linux Tools
- set sp111455.tgz as a checksum file to download HP Linux Tools v3.22

### `defaults/hpuefi`

- gets the path of the hpuefi kernel module tarball for the selected version of HP Linux Tools
- gets the filename of the hpuefi kernel module tarball for the selected version of HP Linux Tools
- remove hardcoded hplt_hpuefi_name
- by default, disables searching for the latest hpuefi tarball
- define the pattern to find hpuefi tarball
- gets the path of the hpuefi kernel module for the selected version of HP Linux Tools
- define path for mkdevhpuefi binary

### `defaults/lspci`

- remove old and duplicated values of hplt_lspci_eth_status and hplt_lspci_eth_device
- by default, disables the task from failing when the contents of hplt_lspci_eth_status are not found in the lspci output.
- by default, enable the task to fail when the contents of hplt_lspci_eth_status are found in the lspci output
- define hplt_lspci_eth_status as a regular expression, defaulting to 'ASPM.*Enabled;'
- get network card PCI device ID from ansible_facts
- get default IPv4 network card interface name from ansible_facts

### `defaults/repsetup`

- gets the path of the hp-flash and hp-repsetup for the selected version of HP Linux Tools
- by default, disables searching for the latest hp-repsetup binary
- gets the path of the hp-flash tarball for the selected version of HP Linux Tools
- gets the filename of the hp-flash tarball for the selected version of HP Linux Tools
- by default, disables searching for the latest hp-flash tarball
- define the pattern to find hp-flash tarball
- remove hardcoded hplt_repsetup_checksum

### `README`

- add tag summary, best playbook example, tested hardware, hp-repsetup results and ASPM statuses reported by lspci

### `task/lspci`

- add task to fail when content of hplt_lspci_eth_status is found in lspci output using regex_search only when hplt_lspci_eth_status_fail_found is enabled

### `tasks/build`

- replace path of hpuefi kernel module for the selected version of HP Linux Tools

### `tasks/file`

- set the filename and path for the latest hp-repsetup binary when hplt_hp_repsetup_bin_find_last is enabled
- find the latest hp-repsetup binary when hplt_hp_repsetup_bin_find_last is enabled
- find latest hp-repsetup binary when hplt_hp_repsetup_bin_find_last is enabled
- set the filename and path for the latest hp-flash tarball when hplt_hp_flash_find_last is enabled
- find latest hp-flash tarball when hplt_hp_flash_find_last is enabled
- set the filename and path for the latest hpuefi kernel module tarball when hplt_hpuefi_mod_find_last is enabled
- find latest hpuefi kernel module tarball when hplt_hpuefi_mod_find_last is enabled
- change the variable in the task name to clarify which hp-flash tarball is extracted
- change file source path and file variables to extract hp-flash tarball
- change file source path and file variables to extract hpuefi tarball
- change the variable in the task name to clarify which hpuefi tarball is extracted
- specify the URL and name of the tarball file to download
- add a task to ensure that the HP Linux tools directory exists for the current distribution
- change the task name to clarify which version of HP Linux Tools is downloaded
- add a task to clean the old HP Linux tools directory when hplt_clean is enabled
- change the task name to clarify and ensure the HP Linux tools directory exists

### `tasks/lspci`

- improve conditional to fail when not found in lspci output using regex_search
- fail when content of hplt_lspci_eth_device_status is not found in lspci output only when hplt_lspci_eth_status_fail_not_found is enabled
- display lspci information filtered by the regular expression defined in hplt_lspci_eth_status
- add quotes to content of hplt_lspci_eth_status in task name fail when not found

### `tests/wol-wait-lspci`

- add get network facts after hardware validation

## [`v0.2.4 - 2023-12-11`](https://gitlab.com/gcoop-libre/ansible_role_hp_linux_tools/-/compare/v0.2.3...v0.2.4) _add support for config options with/without BIOS Admin Password, add tasks to reset/update BIOS Admin Password, by default download HPSETUP-ASPM-DISABLE.TXT to disable PCI Express Power Management_

- tasks/main: includes update tasks when hplt_update_tasks is enabled and hplt_reset_tasks is disabled
- tasks/update: add BIOS Admin Password task update
- tasks/main: includes reset tasks when hplt_reset_tasks is enabled and hplt_update_tasks is disabled
- defaults/repsetup: by default, disable include update tasks
- defaults/repsetup: by default, enable hplt_repsetup_reset_fail to test reset BIOS Admin Password
- defaults/repsetup: by default, disable hplt_repsetup_hpsetup_upd, set hplt_repsetup_hpsetup_upd_failed for invalid update password, and enable hplt_repsetup_update_fail to test failed update.
- defaults/repsetup: define hplt_repsetup_command_upd to update/change current BIOS Admin Password using hplt_repsetup_password_new
- tasks/repsetup: convert to hplt_repsetup_password_current string to validate if invalid
- tasks/repsetup: add task to enable hplt_repsetup_hpsetup_set_bios when All BIOS options programmed successfully after using Admin Password
- tasks/repsetup: rename task to clarify enable hplt_repsetup_hpsetup_set_bios when All BIOS options programmed successfully after without Admin Password
- tasks/repsetup: add task to fail when hplt_repsetup_password_current is invalid
- tasks/repsetup: add task to fail when not all BIOS options programmed successfully
- tasks/main: includes tasks to reset the BIOS Admin Password when hplt_reset_tasks is enabled
- tasks/reset: add tasks to reset BIOS Admin password and fail when it fails
- tasks/repsetup: show hplt_repsetup_hpsetup access_denied value in tasks name of set HPSETUP
- defaults/repsetup: by default enable hplt_repsetup_hpsetup_set_all to fail when not All BIOS options programmed successfully
- defaults/repsetup: by default disable hplt_repsetup_hpsetup_set_bios to validate All BIOS options programmed successfully
- tasks/repsetup: add task to enable hplt_repsetup_hpsetup_set_bios when All BIOS options programmed successfully
- tasks/repsetup: add task to fail when found Access Denied in BIOS set HPSETUP without Admin Password
- tasks/repsetup: add task to configure BIOS from HPSETUP without Admin Password
- tasks/repsetup: add task to fail when found Access Denied in BIOS set HPSETUP using Admin Password
- tasks/repsetup: add task to configure BIOS from HPSETUP using Admin Password
- tasks/repsetup: remove tasl for BIOS set HPSETUP
- tasks/repsetup: add task to enable hplt_repsetup_hpsetup_pwd_admin when Admin Password test is successful
- tasks/repsetup: add task to test/set admin password to check if hplt_repsetup_password_current is valid
- task/repsetup: rename the task to clarify and ensure hp-repsetup is executable
- defaults/repsetup: by default do not run Admin Password reset tasks
- defaults/repsetup: disable hplt_repsetup_reset_admin and hplt_repsetup_reset_fail to validate when the reset is successful and/or fails
- defaults/repsetup: by default set hplt_repsetup_password_new with hplt_repsetup_password_current to keep the same Admin Password
- defaults/repsetup: set hplt_repsetup_password_invalid to 'ansible_vault' to validate the Admin Password
- defaults/repsetup: set hplt_repsetup_hpsetup_rst_already to '(Invalid Parameter)' and disable hplt_repsetup_hpsetup_rst to validate the Admin Password reset
- defaults/repsetup: set hplt_repsetup_hpsetup_pwd_success to 'Admin password updated successfully' and disable hplt_repsetup_hpsetup_pwd_admin for Admin Password test
- defaults/repsetup: define hplt_repsetup_hpsetup_set_success with 'All BIOS options programmed successfully'
- defaults/repsetup: by default fail when found 'PCI Express Power Management(Access Denied)' after set HPSETUP
- defaults/repsetup: by default download https://osiux.com/HPSETUP-ASPM-DISABLE.TXT to disable PCI Express Power Management
- defaults/repsetup: define hplt_repsetup_command_tst using hplt_repsetup_password_current twice for test Admin Password
- defaults/repsetup: define hplt_repsetup_command_rst using hplt_repsetup_password_current (Default=Admin) for reset Admin Password
- defaults/repsetup: add space to avoid error E206 according to ansible-lint

## [`v0.2.3 - 2023-10-06`](https://gitlab.com/gcoop-libre/ansible_role_hp_linux_tools/-/compare/v0.2.2...v0.2.3) _add wol-wait-lspci playbook for WakeOnLAN, wait for SSH and verify lspci output, add wol-wait-system-info playbook for WakeOnLAN, wait for SSH and get and show System Info, improve README, ansible-lint and gitlab-ci_

### `ansible-lint`

- force string in skip_list

### `gitlab-ci`

- add ansible-awx-wst-hpt-sys in ansible-awx stage to execute wst_hpt_sys_v0.2.3
- bump AWX_GITLAB_JOB_LAUNCH to wst_hpt_bio_v0.2.3 in ansible-lint stage
- add wol-wait-system-info.yml playbook in ansible-lint stage
- add wst_hpt_pci_v0.2.3 in ansible-awx stage
- add wol-wait-lspci.yml playbook to verify lspci output

### `README`

- add Hardware Tested
- add playbooks overview

### `tasks/lspci`

- fail when hplt_lspci_eth_status not found when hplt_lspci_eth_device_register is defined
- failt when hplt_lspci_eth_status not found only when the conditionals are defined
- obtaining information from lspci only when the conditionals are defined

### `tests/ansible-lint`

- force string in skip_list

### `tests/test`

- rename playbook name to Install HP Linux Tools

### `tests/wol-wait-lspci`

- end play on invalid system_vendor when hplt_dmi_system_vendor and hplt_dmi_valid_system_vendor are defined
- add wol-wait-lspci playbook for WakeOnLAN, wait for SSH and verify lspci output

### `tests/wol-wait-system-info`

- add wol-wait-system-info playbook for WakeOnLAN, wait for SSH and get and show System Info

## [`v0.2.2 - 2023-09-29`](https://gitlab.com/gcoop-libre/ansible_role_hp_linux_tools/-/compare/v0.2.1...v0.2.2) _add wol-wait-install playbook for WakeOnLAN, wait for SSH and install HP Linux Tools only when match with system_vendor_

### `gitlab-ci`

- bump wst_hpt_bio to version v0.2.2 in ansible-awx stage
- add wol-wait-install.yml playbook in ansible-lint stage

### `tests/wol-wait-install`

- remove host variables in name of tasks
- get hardware facts before validate system_vendor
- get all facts after validate system_vendor
- get hardware facts to validate system_vendor
- disable gather_facts
- replace tabs with whitespaces
- add wol-wait-install playbook for WakeOnLAN, wait for SSH and install HP Linux Tools

## [`v0.2.1 - 2022-08-10`](https://gitlab.com/gcoop-libre/ansible_role_hp_linux_tools/-/compare/v0.2.0...v0.2.1) _add dmi-validate playbook for test and ignore fail on invalid (bios_date|bios_version|product_name|system_vendor)_

### `gitlab-ci`

- split ansible-awx into ansible-awx-wst-hpt-bio and ansible-awx-wst-hpt-dmi stages
- add PLAYBOOK dmi-validate and AWX_GITLAB_JOB_LAUNCH wst_hpt_bio_v0.1.0 in ansible-lint and ansible-awx stages
- explicit PLAYBOOK and AWX_GITLAB_JOB_LAUNCH in ansible-lint and ansible-awx stages

### `tests/dmi`

- add dmi-validate playbook for test and ignore fail on invalid (bios_date|bios_version|product_name|system_vendor)

## [`v0.2.0 - 2022-03-30`](https://gitlab.com/gcoop-libre/ansible_role_hp_linux_tools/-/compare/v0.1.1...v0.2.0) _Release v0.2.0_

### `ansible-lint`

- add 305 to skip_list

### `defaults/apt`

- sort variables based on keys
- enable hplt_apt_extra_install and define hplt_apt_extra_packages

### `defaults/dmi`

- define conditionals to validate compatible hardware

### `gitlab-ci`

- add stages (ansible-lint|ansible-syntax-check|ansible-awx)
- add awx-config.sh

### `Makefile`

- update rules, add support awx job launch

### `pre-commit`

- add shell-lint
- add end-of-file-fixer, trailing-whitespace and ansible-lint

### `tasks/apt`

- add install extra packages

### `tasks/dmi`

- fail on invalid (bios_date|bios_version|product_name|system_vendor)

### `tasks/main`

- add DMI tasks

## [`v0.1.1 - 2022-03-17`](https://gitlab.com/gcoop-libre/ansible_role_hp_linux_tools/-/compare/v0.1.0...v0.1.1) _add symbolic link to role in tests_

### `tests`

- add symbolic link to role gcoop-libre.hp_linux_tools

## [`v0.1.0 - 2021-12-30`](https://gitlab.com/gcoop-libre/ansible_role_hp_linux_tools/-/compare/d3dacbc...v0.1.0) _first version tested in Ubuntu Bionic_

- add first public version
