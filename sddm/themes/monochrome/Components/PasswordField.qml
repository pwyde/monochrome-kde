import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: passwordField
  focus: true
  selectByMouse: true
  placeholderText: "Password"
  placeholderTextColor: config.textPlaceholder
  echoMode: TextInput.Password
  // passwordCharacter: "•"
  passwordMaskDelay: config.PasswordShowLastLetter
  selectionColor: config.textDefault
  renderType: Text.NativeRendering
  font.family: config.Font
  font.pixelSize: config.FontSize
  font.bold: false
  color: config.textDefault
  horizontalAlignment: TextInput.AlignHLeft
  background: Rectangle {
    id: passFieldBackground
    color: config.lineeditBgNormal
    border.color: config.lineeditBorderNormal
    border.width: 1
    radius: 2
    opacity: config.opacityDefault
  }
  states: [
    State {
      name: "hovered"
      when: passwordField.hovered
      PropertyChanges {
        target: passFieldBackground
        border.color: config.lineeditBorderHovered
      }
    },
    State {
      name: "focused"
      when: passwordField.activeFocus
      PropertyChanges {
        target: passFieldBackground
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
