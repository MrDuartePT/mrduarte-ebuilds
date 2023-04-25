## Gentoo Linux Portage overlay for
**[LenovoLegionLinux](https://github.com/johnfanv2/LenovoLegionLinux.git), [legion-linux-utils](https://github.com/Petingoso/legion-fan-utils-linux)**

Maintainer: MrDuartePT / Petingoso / johnfanv2

# Usage
-----
* The easiest way to add this overlay to any gentoo linux install is using eselect repository
```
# emerge eselect-repository dev-vcs/git
```
```
# eselect repository add mrduarte-ebuilds git https://github.com/MrDuartePT/mrduarte-ebuilds.git
```

* Manually:

``` bash
/etc/portage/repos.conf/mrduarte-ebuilds-overlay.conf
-----
[mrduarte-ebuilds]
location = /var/db/repos/mrduarte-ebuilds
sync-type = git
sync-uri = https://github.com/MrDuartePT/mrduarte-ebuilds.git
priority = 50
auto-sync = Yes
```
