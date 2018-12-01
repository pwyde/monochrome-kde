# Monochrome KDE

## About
A dark theme for the KDE Plasma 5 desktop environment inspired by black and white photography.

The theme includes the following:
- Aurorae Theme
- Konsole Colour Scheme
- Kvantum Theme
- Plasma Colour Scheme
- Plasma Desktop Theme
- Yakuake Skin

## Install Instructions

At the time of writing there are no packages available. Install the theme manually using `git clone` or the provided install [script](install.sh). See instructions below. This method works on all distributions.

### Monochrome KDE Installer

The installation script will automatically download the latest version from the repository and copy the needed files to `/usr/share`.

**Install**

```
wget -qO- https://gitlab.com/pwyde/monochrome-kde/raw/master/install.sh | sh
```

**Uninstall**

```
wget -qO- https://gitlab.com/pwyde/monochrome-kde/raw/master/install.sh | uninstall=true sh
```

## Credits
Some graphical elements and artwork in this project is based on other popular themes for the KDE Plasma 5 desktop.

- **Breeze** Plasma theme by [KDE Visual Design Group](https://www.kde.org/plasma-desktop)
- **Materia KDE** Plasma theme by [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/materia-kde)
- **Arc KDE** Plasma theme by [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/arc-kde)
- **Papirus** icon theme by [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)

The installation [script](install.sh) is a modified version of the [original](https://github.com/PapirusDevelopmentTeam/materia-kde/blob/master/install.sh) script file supplied with the **Materia** and **Arc** KDE Plasma 5 theme by [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme).

## Licenses
This project is licensed under the **GNU General Public License v3.0**. See the [LICENSE](LICENSE) file for more information. Graphical elements and artwork based on other projects are licensed under the following:

- **Breeze**: LGPL
- **Materia KDE**: GPLv3
  - **Plasma Desktop Theme**: GPLv3
- **Arc KDE**: GPLv3
  - **Plasma Desktop Theme**: CCPL:by-sa
- **Papirus**: GPLv3
