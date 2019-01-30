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
    id: keyboardButton

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
                    id: keyboardButtonIcon
                    source: "/usr/share/sddm/themes/monochrome/components/artwork/keyboard-language.svg"
                    // Force icon size to 22x22.
                    implicitHeight: 22
                    implicitWidth: implicitHeight
                }
                Label {
                    id: keyboardButtonLabel
                    color: config.fontColor
                    font.family: config.font
                    font.pointSize: config.fontSize
                    font.underline: keyboardButton.activeFocus
                    text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Keyboard Layout: %1", instantiator.objectAt(currentIndex).shortName)
                }
            }
        }
        background: Rectangle {
            id: keyboardButtonBackground
            border.width: 1
            radius: 2
            border.color: control.hovered ? "#30ffffff" : "#00000000"
            color: "#00000000"
        }
    }

    Component.onCompleted: currentIndex = Qt.binding(function() {return keyboard.currentLayout});

    menu: QQC.Menu {
        id: keyboardMenu
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
            model: keyboard.layouts
            onObjectAdded: keyboardMenu.insertItem(index, object)
            onObjectRemoved: keyboardMenu.removeItem( object )
            delegate: QQC.MenuItem {
                text: modelData.longName
                property string shortName: modelData.shortName
                onTriggered: {
                    keyboard.currentLayout = model.index
                }
            }
        }
    }
}
