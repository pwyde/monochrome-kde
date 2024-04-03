# Monochrome KDE - CHANGELOG

## First Release - 30 November 2018

- First release of Monochrome KDE theme, which includes the following components:
  - Aurorae Theme
  - Konsole Colour Scheme
  - Kvantum Theme
  - Plasma Colour Scheme
  - Plasma Desktop Theme
  - Yakuake Skin
  - Install script

## General Improvements - 01 December 2018

  - Added recommendations to README file.
  - Fixed typos in README file.
  - Added LICENSE files.
  - Added preview image of the theme.

## Added Source Files - 02 December 2018

- Added Inkscape source files.
- Added SVG to PNG convert script.

## Yakuake Skin Improvements - 11 December 2018

- Removed drop-shadow in Yakuake to resolve issue with desktop blur effect.
- Relocated application buttons.

## Added SDDM Theme - 19 December 2018

- First release of SDDM theme.

## SDDM Theme Improvements - 05 January 2019

- Implemented various improvements in SDDM theme:
  - Changed background colour.
  - Changed colours in text field to match theme better.
  - Made login button darker.

## Added Plasma Look and Feel Theme - 06 January 2019

- First release of Plasma Look and Feel theme including Plasma Splash screen.

## General Improvements - 07 January 2019

- Fixed markdown formatting in README file.
- Updated license information.

## Plasma Splash Screen Improvements - 11 January 2019

- Replaced progress bar with busy widget, see [this](https://gitlab.com/pwyde/monochrome-kde/issues/1) issue for more information.

## SDDM Theme Improvements - 12 January 2019

- Added custom font support in SDDM configuration file.
- Added SDDM recommendations in README file.

## SDDM Theme Improvements - 30 January 2019

- Added custom font size option in SDDM configuration file.
- Added custom icons and theme colours to ToolButtons on login screen:
  - Virtual keyboard.
  - Plasma session.
  - Keyboard language.
- Added theme colours to all elements on login screen.
- Changed username and password text fields:
  - Background and border is now also semi-transparent as the Plasma Desktop and Kvantum theme.
  - Changed from active to mouse hover behavior.
- Changed from active to mouse hover behavior on login button.

## SDDM Theme Changes - 7 February 2019

- Changed default font to Noto Sans as this font is installed by default with the Plasma Desktop.
- Updated recommendations for SDDM font in README file.

## Install Script - 11 February 2019

- Complete rewrite of installation script.

## GTK2/3 Theme - 18 March 2019

- Added instructions for building [breeze-gtk](https://cgit.kde.org/breeze-gtk.git/) with colours from the Monochrome KDE colour scheme.
- Restructured recommendations section and added sub-headings.

## Konsole Colour Scheme Changes - 14 April 2019

- Modified colour scheme to be compatible with [base16-vim](https://github.com/chriskempson/base16-vim).

## Kvantum Theme Changes - 07 February 2020

- Fixed tab icons in Kvantum theme so it looks better in newer version of Plasma.

## Install Script - 08 February 2020

- Colourized script output.
- Added 'pint_error' function.
- Added ping test before downloading from master branch.
- Minor changes to script syntax.

## Project Logotype - 18 February 2020

- Added a project logotype.

## SDDM Theme Changes - 26 February 2020

- Replaced all coloured icons with a monochrome version.

## Plasma Desktop Theme Changes - 26 February 2020

- Replaced some coloured icons with a monochrome version.
  - Only applies to icons located on panels and menus.

## 20200422 Release - 22 April 2020

- Made project available on [GitHub](https://github.com/pwyde/monochrome-kde) also (mirror from [GitLab](https://gitlab.com/pwyde/monochrome-kde)).
- Updated README file.
- Updated screenshots.
- Packaged and published latest changes to [KDE Store](https://store.kde.org)/[Pling](https://www.pling.com/).

## 20200518 Release - 18 May 2020

- Updated Aurorae theme:
  - Removed gradients.
  - Changed to Materia-style decorations.
  - Added alternative 'Blur' version of theme.
- Updated Kvantum theme:
  - Removed gradients.
  - Added alternative 'Blur' and 'Solid' versions of theme.
- Updated SDDM theme:
  - Changed QtQuick 2.6 -> 2.8 to re-enable round profile picture.
- Updated Plasma Desktop theme:
  - Removed gradients.
- Updated Plasma Global theme:
  - Added SDDM theme.
- Updated Yakuake skin:
  - Replaced skin files; .png -> .svg
  - Fixed plus button.
- Removed project logo, as it did not represent the overall aesthetics of the theme.
- Updated install script to include alternative 'Blur' and 'Solid' versions of the theme.
- Updated screenshots.
- Updated README and CHANGELOG files.
- Packaged and published latest changes to [KDE Store](https://store.kde.org)/[Pling](https://www.pling.com/).

# 20201104 Release - 04 November 2020

- Updated Plasma Desktop theme:
  - Added plasmoidheading widget for Plasma 5.19
  - Colourised notes widget.
  - Updated and added new icons.
- Added test for wget command in install script.
- Implemented automatic cleanup of theme/svgelements cache in user's home directory.
- Updated preview image.
- Updated README and CHANGELOG files.

# 20210222 Release - 22 February 2021

- Fixed issue with SDDM background color not being applied.
- Updated Plasma Look and Feel:
  - Added default settings for toolbar and button icons.
- Updated Plasma Desktop theme:
  - Modified opacity. Theme is now less transparent and darker.
  - Removed gradient in widget background.
  - Added showbackground icon in widget configuration icons.
  - Fixed some graphical issues.
  - Updated panel background to Plasma 5.21

# 20240402 Release - 02 April 2024

- Added Plasma 6 compatibility.
- Fixed minor issues with Plasma theme.
- Updated GTK2/3/4 theme. Build from `breeze-gtk` with the Monochrome KDE colour scheme.
- Updated preview images.

# 20240403 Release - 03 April 2024

- Fixed `X-KPackage-Dependencies` in theme metadata (`metadata.json`).
- Updated install script:
  - Disabled installation of SDDM theme.
  - Changed install prefix from `/usr/share` to `$HOME`.
