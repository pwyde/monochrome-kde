import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: sleepButton.height
  implicitWidth: sleepButton.width
  Button {
    id: sleepButton
    height: 32
    width: 32
    hoverEnabled: true
    icon {
      source: Qt.resolvedUrl("../icons/sleep.svg")
      color: config.textDefault
    }
    background: Rectangle {
      id: sleepButtonBackground
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
        when: sleepButton.down
        PropertyChanges {
          target: sleepButtonBackground
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
        when: sleepButton.hovered
        PropertyChanges {
          target: sleepButtonBackground
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
      }
    ]
    transitions: Transition {
      PropertyAnimation {
        properties: "color"
        duration: 300
      }
    }
    onClicked: sddm.suspend()
  }
}
