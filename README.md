# Ansible Role: gcoop-libre.hp_linux_tools

This role, download, build, install a _HP Linux Tools_ (`hpuefi-mod`
kernel module) and execute `hp-repsetup` to get and set _BIOS_
configuration from file (`HPSETUP.TXT`).

## Tag Summay

| _date_     | _tag_      | _description_                                                                                                                                                                                                           |
|------------|------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
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

None.

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

- name: Install HP Linux Tools
  hosts: [all]

  roles:
    - role: gcoop-libre.hp_linux_tools
      hplt_repsetup_hpsetup_get: False
      hplt_repsetup_hpsetup_down: True
      hplt_repsetup_hpsetup_file_checksum: 1b0c05bd9ef7bc76147211d148563052d65b142f95ca703a73d5a72660df8397
      hplt_repsetup_hpsetup_file_host: https://example.com
      hplt_reboot_and_wait: True
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

| _bios_date_  | _bios_version_      | _product_name_                   | _network_                            |
|--------------|---------------------|----------------------------------|--------------------------------------|
| `12/23/2019` | `R23 Ver. 02.04.01` | _HP ProDesk 400 G5 Desktop Mini_ | _Realtek RTL8111/8168/8411 (rev 15)_ |
| `04/27/2020` | `R23 Ver. 02.05.01` | _HP ProDesk 400 G5 Desktop Mini_ | _Realtek RTL8111/8168/8411 (rev 15)_ |

## References

- https://ftp.ext.hp.com/pub/caps-softpaq/cmit/whitepapers/HP_Linux_Tools_Users_Guide.pdf
- https://osiux.com/2021-09-27-hp-prodesk-400-g5-desktop-mini-bios-disable-aspm-from-linux-command-line.html

## License

GNU General Public License, GPLv3.

## Author Information

This role was created in 2021 by
 [Osiris Alejandro Gomez](https://osiux.com/), worker cooperative of
 [gcoop Cooperativa de Software Libre](https://www.gcoop.coop/).
