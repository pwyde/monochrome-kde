import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2

Item {
  property var user: userField.text
  property var password: passwordField.text
  property var session: sessionPanel.session
  property var inputHeight: 144
  property var inputWidth: 256
  Rectangle {
    id: loginBackground
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    height: inputHeight * 1.5
    width: inputWidth * 1.5
    radius: 4
    visible: config.LoginBackground == "true" ? true : false
    color: config.bgDark
    opacity: config.opacityPanel
  }
  Column {
    spacing: 8
    anchors {
      bottom: parent.bottom
      left: parent.left
    }
    PowerButton {
      id: powerButton
    }
    RebootButton {
      id: rebootButton
    }
    SleepButton {
      id: sleepButton
    }
    z: 5
  }
  Column {
    spacing: 8
    anchors {
      bottom: parent.bottom
      right: parent.right
    }
    SessionPanel {
      id: sessionPanel
    }
    z: 5
  }
  Column {
    id: column
    spacing: 8
    z: 5
    width: inputWidth
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    UserField {
      id: userField
      height: 30
      width: parent.width
    }
    RowLayout {
      id: row
      spacing: 8
      anchors {
        verticalCenter: userField
        horizontalCenter: parent.horizontalCenter
      }
      PasswordField {
        id: passwordField
        Layout.preferredWidth: (inputWidth - loginButton.width - row.spacing)
        Layout.preferredHeight: 30
        onAccepted: loginButton.clicked()
      }
      Button {
        id: loginButton
        Layout.preferredWidth: 30
        Layout.preferredHeight: 30
        enabled: user != "" && password != "" ? true : false
        hoverEnabled: true
        icon {
          source: Qt.resolvedUrl("../icons/login.svg")
          color: config.textDefault
        }
        background: Rectangle {
          id: buttonBackground
          gradient: Gradient {
            GradientStop { id: gradientStop0; position: 0.0; color: config.buttonBgNormal }
            GradientStop { id: gradientStop1; position: 1.0; color: config.buttonBgNormal }
          }
          border.color: config.buttonBorderNormal
          border.width: 1
          radius: 2
          opacity: config.opacityDefault
        }
        states: [
          State {
            name: "pressed"
            when: loginButton.down
            PropertyChanges {
              target: buttonBackground
              border.color: config.buttonBorderPressed
              opacity: 1
            }
            PropertyChanges {
              target: gradientStop0
              color: config.buttonBgPressed
            }
            PropertyChanges {
              target: gradientStop1
              color: config.buttonBgPressed
            }
          },
          State {
            name: "hovered"
            when: loginButton.hovered
            PropertyChanges {
              target: buttonBackground
              border.color: config.buttonBorderHovered
              opacity: 1
            }
            PropertyChanges {
              target: gradientStop0
              color: config.buttonBgHovered0
            }
            PropertyChanges {
              target: gradientStop1
              color: config.buttonBgHovered1
            }
          },
          State {
            name: "enabled"
            when: loginButton.enabled
            PropertyChanges {
              target: buttonBackground
            }
            PropertyChanges {
              target: buttonBackground
            }
          }
        ]
        transitions: Transition {
          PropertyAnimation {
            properties: "color"
            duration: 300
          }
        }
        onClicked: {
          sddm.login(user, password, session)
        }
      }
    }
  }
  Connections {
    target: sddm

    function onLoginFailed() {
      passwordField.text = ""
      passwordField.focus = true
    }
  }
}
