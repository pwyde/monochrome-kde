# Monochrome KDE - README

<p align="center">
    <img src="preview.png" alt="Preview of Monochrome KDE"/>
</p>

## About
A dark theme for the KDE Plasma 5 desktop environment inspired by black and white photography.

The theme includes the following:

- Aurorae Theme
- Konsole Colour Scheme
- Kvantum Theme
- Plasma Colour Scheme
- Plasma Desktop Theme
- Plasma Look and Feel
- Plasma Splash Screen
- SDDM Theme
- Yakuake Skin

## Install Instructions
At the time of writing there are no packages available. Install the theme manually using `git clone` or the provided install [script](install.sh). See instructions below. This method works on all distributions.

### Install Script
The installation script will automatically download the latest version from the repository and copy the required files to the default location `/usr/share`.

#### Install
```
sh install.sh --install
```

#### Uninstall
```
sh install.sh --uninstall
```

#### Options
| **Option**         | **Description**                                   |
| ---                | ---                                               |
| `-i`,`--install`   | Install theme in default location (`/usr/share`). |
| `-u`,`--uninstall` | Uninstall theme.                                  |
| `-h`,`--help`      | Display help message including available options. |

## Recommendations
For a better visual experience apply the following modifications and settings.

### Widget Style
Download and install the [Kvantum theme engine](https://github.com/tsujan/Kvantum/tree/master/Kvantum).

Run `kvantummanager` > **Change/Delete Theme** > select theme **Monochrome** > **Use this theme**.

### Window Decorations
Change **Aurorae** theme in **System Settings** > **Application Style** > **Window Decorations** > select **Monochrome**.

### Icons
Download and install the [Papirus icon theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme).

### Desktop Effects
Enable **Blur** in **System Settings** > **Desktop Behaviour** > **Desktop Effetcs**.

### SDDM Login Screen (optional)
Change default font for **SDDM** in the `/usr/share/sddm/themes/monochrome/heme.conf` configuration file.

### GTK2/3 Theme (optional)
Build and install the [breeze-gtk](https://cgit.kde.org/breeze-gtk.git/) GTK2/3 theme with the Monochrome KDE colour scheme.

- Install required packages:
  - **GTKEngine**
  - **Sass**
  - **PythonCairo**

Clone the `breeze-gtk` repository with command below.

```
git clone https://anongit.kde.org/breeze-gtk.git
```

Execute the `breeze-gtk/src/build_theme.sh` script with the following command and option.

```
sh build_theme.sh -c Monochrome
```
This will build the breeze-gtk theme using colours from Monochrome KDE and install it into the `~/.local/share/themes/Monochrome` directory.

Enable the new GTK theme in **System Settings** > **Application Style** > **GNOME/GTK Application Style** > select **Monochrome** for the **GTK2** and **GTK3** theme > **Apply**.

### Disable Client Side Decorations for GTK3 Applications (optional)

Install [gtk3-nocsd]((https://github.com/PCMan/gtk3-nocsd) to disable Client Side Decorations for GTK3 applications.

### Plymouth Boot Splash Screen (optional)
Download and install the [Monochrome Plymouth](https://gitlab.com/pwyde/monochrome-plymouth) theme.

## Credits
Some graphical elements and artwork in this project is based on other popular themes for the KDE Plasma 5 desktop.

- **Breeze** Plasma theme by [KDE Visual Design Group](https://www.kde.org/plasma-desktop)
- **Materia KDE** Plasma theme by [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/materia-kde)
- **Arc KDE** Plasma theme by [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/arc-kde)
- **Papirus** icon theme by [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- **Darkine KDE** SDDM theme by [Rokin](https://github.com/Rokin05/darkine-kde)

## Licenses
This project is licensed under the **GNU General Public License v3.0**. See the [LICENSE](LICENSE) file for more information. Graphical elements and artwork based on other projects are licensed under the following:

- **Materia KDE**: GPLv3
  - **Aurorae Theme**: GPLv3
  - **Kvantum Theme**: GPLv3
  - **Plasma Desktop Theme**: GPLv3
- **Arc KDE**: GPLv3
  - **Kvantum Theme**: GPLv3
  - **Plasma Desktop Theme**: CCPL:by-sa
  - **Plasma Splash Screen**: GPLv3
- **Papirus Icon Theme**: GPLv3
- **Breeze**: LGPL
- **Darkine**: GPLv3
  - **SDDM Theme**: CC-BY-SA

## Todo
A list of features and/or components that will be added in the future.

- [x] Aurorae Theme
- [ ] ~~Add GTK2/3 Theme based on Materia or Arc.~~
- [x] Konsole Colour Scheme
  - [x] Change colours to match theme better.
- [x] Kvantum Theme
  - [ ] Create alternative theme with more transparency and blur.
- [x] SDDM Theme
  - [x] Change colours to match theme better.
  - [x] Add custom font support.
  - [x] Change font colour in all elements if possible.
- [x] Plasma Colour Scheme
- [x] Plasma Desktop Theme
- [x] Plasma Look and Feel Theme
- [x] Plasma Splash Screen
  - [x] Re-design due to issue with progress bar.
  - [ ] ~~Replace busy widget spinner with a working progress bar.~~
- [x] [Plymouth Theme](https://gitlab.com/pwyde/monochrome-plymouth)
- [x] Yakuake Skin
