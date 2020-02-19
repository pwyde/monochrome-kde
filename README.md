# Monochrome KDE

## :information_source: About
<img src="logo.png" alt="monochrome-kde-logo" align="right" />

A dark theme for the KDE Plasma desktop environment inspired by black and white photography.

The complete theme consists of the following components:
- Aurorae Theme
- Konsole Colour Scheme
- Kvantum Theme
- Plasma Colour Scheme
- Plasma Desktop Theme
- Plasma Look and Feel
- Plasma Splash Screen
- SDDM Theme
- Yakuake Skin


## :floppy_disk: Install Instructions
At the time of writing there are no Linux distribution packages available. Install the complete theme manually using `git clone` or the provided install [script](install.sh). See [instructions](#install-script) below. This method works on all Linux distributions.

Individual theme components can also be downloaded from [KDE Store](https://store.kde.org)/[OpenDesktop.org](https://www.opendesktop.org) or using [Plasma System Settings](https://userbase.kde.org/System_Settings).

| **Name**              | **Preview**                                                   | **KDE Store** (tar.gz)                           |
|:----------------------|:-------------------------------------------------------------:|:------------------------------------------------:|
| Aurorae Theme         | [:frame_with_picture:](screenshots/aurorae/preview.png)       | [:floppy_disk:](https://store.kde.org/p/1279082) |
| Konsole Colour Scheme | [:frame_with_picture:](screenshots/konsole/preview.png)       | [:floppy_disk:](https://store.kde.org/p/1279087) |
| Kvantum Theme         | [:frame_with_picture:](screenshots/kvantum/preview.png)       | [:floppy_disk:](https://store.kde.org/p/1279088) |
| Plasma Colour Scheme  | [:frame_with_picture:](screenshots/color-schemes/preview.png) | [:floppy_disk:](https://store.kde.org/p/1279083) |
| Plasma Desktop Theme  | [:frame_with_picture:](screenshots/plasma/preview.png)        | [:floppy_disk:](https://store.kde.org/p/1279077) |
| Plasma Look and Feel  | [:frame_with_picture:](screenshots/plasma/preview.png)        | [:floppy_disk:](https://store.kde.org/p/1361190) |
| Plasma Splash Screen  | [:frame_with_picture:](screenshots/plasma/splash.png)         | [:floppy_disk:](https://store.kde.org/p/1361190) |
| SDDM Theme            | [:frame_with_picture:](screenshots/sddm/preview.png)          | [:floppy_disk:](https://store.kde.org/p/1361190) |
| Yakuake Skin          | [:frame_with_picture:](screenshots/yakuake/preview.png)       | [:floppy_disk:](https://store.kde.org/p/1279089) |

### Install Script
The installation script will automatically download the latest version from the repository and copy the required files to the default location `/usr/share`.

#### Install
```
$ bash install.sh --install
```

#### Uninstall
```
$ bash install.sh --uninstall
```

#### Options
| **Option**         | **Description**                                   |
| ---                | ---                                               |
| `-i`,`--install`   | Install theme in default location (`/usr/share`). |
| `-u`,`--uninstall` | Uninstall theme.                                  |
| `-h`,`--help`      | Display help message including available options. |

## :bulb: Recommendations
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
Change default font for **SDDM** in the `/usr/share/sddm/themes/monochrome/theme.conf` configuration file.

### GTK2/3 Theme (optional)
Build and install the [breeze-gtk](https://cgit.kde.org/breeze-gtk.git/) GTK2/3 theme with the Monochrome KDE colour scheme.

- Install required packages:
  - **GTKEngine**
  - **Sass**
  - **PythonCairo**

Clone the `breeze-gtk` repository with command below.

```
$ git clone https://anongit.kde.org/breeze-gtk.git
```

Execute the `breeze-gtk/src/build_theme.sh` script with the following command and option.

```
$ sh build_theme.sh -c Monochrome
```
This will build the breeze-gtk theme using colours from Monochrome KDE and install it into the `~/.local/share/themes/Monochrome` directory.

Enable the new GTK theme in **System Settings** > **Application Style** > **GNOME/GTK Application Style** > select **Monochrome** for the **GTK2** and **GTK3** theme > **Apply**.

### Disable Client Side Decorations for GTK3 Applications (optional)

Install [gtk3-nocsd](https://github.com/PCMan/gtk3-nocsd) to disable Client Side Decorations for GTK3 applications.

### Plymouth Boot Splash Screen (optional)
Download and install the [Monochrome Plymouth](https://gitlab.com/pwyde/monochrome-plymouth) theme.

## :heart: Credits
Some graphical elements and artwork in this project is based on other popular themes for the KDE Plasma desktop.

- **Breeze** Plasma theme by [KDE Visual Design Group](https://www.kde.org/plasma-desktop)
- **Materia KDE** Plasma theme by [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/materia-kde)
- **Arc KDE** Plasma theme by [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/arc-kde)
- **Papirus** icon theme by [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- **Darkine KDE** SDDM theme by [Rokin](https://github.com/Rokin05/darkine-kde)

## :page_with_curl: Licenses
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

## :ballot_box_with_check: Todo
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
