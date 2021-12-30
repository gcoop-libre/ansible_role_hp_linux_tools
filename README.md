# Ansible Role: gcoop-libre.hp_linux_tools

This role, download, build, install a _HP Linux Tools_ (`hpuefi-mod`
kernel module) and execute `hp-repsetup` to get and set _BIOS_
configuration from file.

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

- name: install hp_linux_tools
  hosts: [all]

  roles:
    - role: gcoop-libre.hp_linux_tools
      hplt_repsetup_hpsetup_get: False
      hplt_repsetup_hpsetup_down: True
      hplt_repsetup_hpsetup_file_checksum: 1b0c05bd9ef7bc76147211d148563052d65b142f95ca703a73d5a72660df8397
      hplt_repsetup_hpsetup_file_host: https://example.com
      hplt_reboot_and_wait: True
```

## References

- https://ftp.ext.hp.com/pub/caps-softpaq/cmit/whitepapers/HP_Linux_Tools_Users_Guide.pdf
- https://osiux.com/2021-09-27-hp-prodesk-400-g5-desktop-mini-bios-disable-aspm-from-linux-command-line.html

## License

GNU General Public License, GPLv3.

## Author Information

This role was created in 2021 by
 [Osiris Alejandro Gomez](https://osiux.com/), worker cooperative of
 [gcoop Cooperativa de Software Libre](https://www.gcoop.coop/).
