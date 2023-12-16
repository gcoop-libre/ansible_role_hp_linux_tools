# Ansible Role: gcoop-libre.hp_linux_tools

This role, download, build, install a _HP Linux Tools_ (`hpuefi-mod`
kernel module) and execute `hp-repsetup` to get and set _BIOS_
configuration from file (`HPSETUP.TXT`).

## Tag Summay

| _date_     | _tag_      | _description_                                                                                                                                                                                                           |
|------------|------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 2023-12-15 | `  v0.2.5` | add support for multiple versions of HP Linux Tools (currently versions 3.21 and 3.22), improve network interface and PCI device ID detection and better validations, and include test results from HP G5 and G6        |
| 2023-12-11 | `  v0.2.4` | add support for config options with/without BIOS Admin Password, add tasks to reset/update BIOS Admin Password, by default download HPSETUP-ASPM-DISABLE.TXT to disable PCI Express Power Management                    |
| 2023-10-06 | `  v0.2.3` | add wol-wait-lspci playbook for WakeOnLAN, wait for SSH and verify lspci output, add wol-wait-system-info playbook for WakeOnLAN, wait for SSH and get and show System Info, improve README, ansible-lint and gitlab-ci |
| 2023-09-29 | `  v0.2.2` | add wol-wait-install playbook for WakeOnLAN, wait for SSH and install HP Linux Tools only when match with system_vendor                                                                                                 |
| 2022-08-10 | `  v0.2.1` | add dmi-validate playbook for test and ignore fail on invalid (bios_date|bios_version|product_name|system_vendor)                                                                                                       |
| 2022-03-30 | `  v0.2.0` | Release v0.2.0                                                                                                                                                                                                          |
| 2022-03-17 | `  v0.1.1` | add symbolic link to role in tests                                                                                                                                                                                      |
| 2021-12-30 | `  v0.1.0` | first version tested in Ubuntu Bionic                                                                                                                                                                                   |

## Requirements

None.

## Role Variables

Available variables with default values in `defaults/main/*.yml`.

## Dependencies

All dependencies are downloaded, installed and configured by this role.

## Example Playbook

If you want to get BIOS configuration:

```yaml
---

- name: install hp_linux_tools
  hosts: [all]

  roles:
    - role: gcoop-libre.hp_linux_tools
```

If you want to download `HPSETUP.TXT` and set _BIOS_ configuration:

```yaml
---

- name: Install HP Linux Tools and disable ASPM in BIOS
  hosts: [all]

  roles:
    - role: gcoop-libre.hp_linux_tools
      hplt_reboot_and_wait: True
      hplt_repsetup_hpsetup_down: True
      hplt_repsetup_hpsetup_file_checksum: e7790575d4646c00b38a57d15f59d73b377c99e706f91bd18d712ba55f3915dc
      hplt_repsetup_hpsetup_file_host: https://osiux.com/
      hplt_repsetup_hpsetup_file_name: HPSETUP-ASPM-DISABLE.TXT
      hplt_repsetup_hpsetup_get: False
```

## Playbooks

|  _playbook_                      | _description_                                          |
|----------------------------------|--------------------------------------------------------|
| `tests/dmi-validate.yml        ` | _Validate DMI (Desktop Management Interface)_          |
| `tests/test.yml                ` | _Install HP Linux Tools_                               |
| `tests/wol-wait-install.yml    ` | _WoL host, wait for Online and install HP Linux Tools_ |
| `tests/wol-wait-lspci.yml      ` | _WoL host, wait for Online and verify lspci output_    |
| `tests/wol-wait-system-info.yml` | _WoL host, wait for Online and show System Info_       |

## Hardware Tested

| _bios_date_  | _bios_version_      | _product_name_                      | _network_                                            |
|--------------|---------------------|-------------------------------------|------------------------------------------------------|
| `12/23/2019` | `R23 Ver. 02.04.01` | _HP ProDesk 400 G5 Desktop Mini_    | _Realtek RTL8111/8168/8411 (rev 15)_                 |
| `04/27/2020` | `R23 Ver. 02.05.01` | _HP ProDesk 400 G5 Desktop Mini_    | _Realtek RTL8111/8168/8411 (rev 15)_                 |
| `11/04/2021` | `S23 Ver. 02.09.02` | _HP ProDesk 400 G6 Desktop Mini PC_ | _Intel Corporation Ethernet Connection (11) I219-LM_ |

## _HP Linux Tools_ suppported versions

The _HP Flash and Replicated Setup Utilities for Linux_ are a free set
of utilities which provide the ability to manage _BIOS_ settings and
update _BIOS_ firmware on _HP_ supported desktop, _Workstation_ and
notebook computers.

| _version_ | _date_       |  _status_ | _file_                                                                        |
|-----------|--------------|-----------|-------------------------------------------------------------------------------|
|   `v3.22` | `2022-10-17` |  _TESTED_ | [`sp143035.tgz`](https://ftp.hp.com/pub/softpaq/sp143001-143500/sp143035.tgz) |
|   `v3.21` | `2020-07-08` |  _TESTED_ | [`sp111455.tgz`](https://ftp.hp.com/pub/softpaq/sp111001-111500/sp111455.tgz) |

## Results of running `hp-repsetup`

The possible results of running `hp-repsetup` with different
combinations of parameters are detailed below:

| _action_        | _current_ | _new_  | _rc_  | _result_  | _message_                                              |
|-----------------|-----------|--------|-------|-----------|--------------------------------------------------------|
| reset password  |   `VALID` |    `/` |   `0` | `SUCCESS` | `Admin password updated successfully.`                 |
| reset password  | `INVALID` |    `/` | `136` |  `FAILED` | `Admin password was not updated: (Access Denied)`      |
| reset password  |   `RESET` |    `/` | `136` |  `FAILED` | `Admin password was not updated: (Invalid Parameter)`  |
| update password |   `VALID` | `SAME` |   `0` | `SUCCESS` | `Admin password updated successfully.`                 |
| update password | `INVALID` |  `NEW` | `136` |  `FAILED` | `Admin password was not updated: (Access Denied)`      |
| update password |   `RESET` |  `NEW` | `136` |  `FAILED` | `Admin password was not updated: (Security Violation)` |
| update password |   `VALID` | `SHORT | `136` |  `FAILED` | `Admin password was not updated: (Security Violation)` |
| update password |     `NEW` |  `NEW` |   `0` | `SUCCESS` | `Admin password updated successfully.`                 |
| set options     |   `VALID` |    `-` |   `0` | `SUCCESS` | `All BIOS options programmed successfully:`            |
| set options     | `INVALID` |    `-` | `135` |  `FAILED` | `(Access Denied)`                                      |
| set options     |   `RESET` |    `-` |   `0` | `SUCCESS` | `All BIOS options programmed successfully:`            |
| get options     |   `RESET` |    `-` |   `0` | `SUCCESS` | `Wrote 19504 bytes to HPSETUP.TXT`                     |
| get options     | `INVALID` |    `-` |   `0` | `SUCCESS` | `Wrote 19688 bytes to HPSETUP.TXT`                     |
| get options     |   `VALID` |    `-` |   `0` | `SUCCESS` | `Wrote 19688 bytes to HPSETUP.TXT`                     |

- `VALID` the password match with the current in _BIOS_

- `INVALID` the password not match with the current in _BIOS_

- `RESET` actually, the _BIOS_ has not have password

- `SAME` the password match with the current password provided

- `NEW` the password is a new password (distinct to current password)

- `SHORT` password has fewer minimum length characters

## _ASPM_

Depending on the _HP_ model and the network card model, the `lspci`
output reports the enabled or disabled status of _ASPM_ in different
ways:

| _krnl_mod_ | _enabled_                   | _disabled_                | _product_name_      | _ethernet_controller_                                                                                |
|------------|-----------------------------|---------------------------|---------------------|------------------------------------------------------------------------------------------------------|
|    `r8169` | `LnkCtl:  ASPM L1 Enabled;` | `LnkCtl:  ASPM Disabled;` | `HP ProDesk 400 G5` | `Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)` |
|   `e1000e` |                         `-` |                       `-` | `HP ProDesk 400 G6` | `Intel Corporation Ethernet Connection (11) I219-LM`                                                 |

## References

- https://ftp.ext.hp.com/pub/caps-softpaq/cmit/whitepapers/HP_Linux_Tools_Users_Guide.pdf
- https://osiux.com/2021-09-27-hp-prodesk-400-g5-desktop-mini-bios-disable-aspm-from-linux-command-line.html

## License

GNU General Public License, GPLv3.

## Author Information

This role was created in 2021 by
 [Osiris Alejandro Gomez](https://osiux.com/), worker cooperative of
 [gcoop Cooperativa de Software Libre](https://www.gcoop.coop/).
