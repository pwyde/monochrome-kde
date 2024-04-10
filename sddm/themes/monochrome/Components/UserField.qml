import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: userField
  selectByMouse: true
  echoMode: TextInput.Normal
  selectionColor: config.textDefault
  renderType: Text.NativeRendering
  font {
    family: config.Font
    pixelSize: config.FontSize
    bold: false
  }
  color: config.textDefault
  horizontalAlignment: Text.AlignHLeft
  placeholderText: "Username"
  placeholderTextColor: config.textPlaceholder
  text: userModel.lastUser
  background: Rectangle {
    id: userFieldBackground
    color: config.lineeditBgNormal
    border.color: config.lineeditBorderNormal
    border.width: 1
    radius: 2
    opacity: config.opacityDefault
  }
  states: [
    State {
      name: "hovered"
      when: userField.hovered
      PropertyChanges {
        target: userFieldBackground
        border.color: config.lineeditBorderHovered
      }
    },
    State {
      name: "focused"
      when: userField.activeFocus
      PropertyChanges {
        target: userFieldBackground
        border.color: config.lineeditBorderFocused
      }
    }
  ]
  transitions: Transition {
    PropertyAnimation {
      properties: "color"
      duration: 300
    }
  }
}
