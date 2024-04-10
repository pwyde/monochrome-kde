/*
 *   Copyright 2016 David Edmundson <davidedmundson@kde.org>
 *   Modified 2019 by Patrik Wyde <patrik@wyde.se>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.2

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import QtQuick.Controls 1.3 as QQC

// Additional imports.
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.4

// Replaced PlasmaComponents.ToolButton with original Qt Quick control.
ToolButton {
    id: root
    property int currentIndex: -1
    
    // If not commented the clickable area of the ToolButton is reduced to almost nothing.
    //implicitWidth: minimumWidth

    visible: menu.items.length > 1

    style: ButtonStyle {
        label: Item {
            implicitHeight:  buttonContent.implicitHeight
            implicitWidth: buttonContent.implicitWidth
            RowLayout {
                id: buttonContent
                anchors.fill: parent

                // Utilize the IconItem control in PlasmaCore as it proved to be the best option
                // for icon placement in the ToolButton.
                PlasmaCore.IconItem {
                    id: sessionToolButtonIcon
                    source: "/usr/share/sddm/themes/monochrome/components/artwork/desktop-session.svg"
                    // Force icon size to 22x22.
                    implicitHeight: 22
                    implicitWidth: implicitHeight
                }
                Label {
                    id: sessionToolButtonLabel
                    color: config.fontColor
                    font.family: config.font
                    font.pointSize: config.fontSize
                    font.underline: root.activeFocus
                    text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Desktop Session: %1", instantiator.objectAt(currentIndex).text || "")
                }
            }
        }
        background: Rectangle {
            id: sessionToolButtonBackground
            border.width: 1
            radius: 2
            border.color: control.hovered ? "#30ffffff" : "#00000000"
            color: "#00000000"
        }
    }
    
    Component.onCompleted: {
        currentIndex = sessionModel.lastIndex
    }

    menu: QQC.Menu {
        id: menu
        // Custom style to Menu control.
        style: MenuStyle {
            font.family: config.font
            font.pointSize: config.fontSize

            frame: Rectangle {
                border.color: "#323234"
                color: "#1e1e20"
            }

            // Style selected/hovered MenuItem.
            itemDelegate.background: Rectangle {
                visible: styleData.selected && styleData.enabled
                color: "#323234"
            }

            // Style text in MenuItem.
            itemDelegate.label: Label {
                text: formatMnemonic(styleData.text, styleData.underlineMnemonic)
                color: config.fontColor
            }
        }
        Instantiator {
            id: instantiator
            model: sessionModel
            onObjectAdded: menu.insertItem(index, object)
            onObjectRemoved: menu.removeItem( object )
            delegate: QQC.MenuItem {
                text: model.name
                onTriggered: {
                    root.currentIndex = model.index
                }
            }
        }
    }
}
