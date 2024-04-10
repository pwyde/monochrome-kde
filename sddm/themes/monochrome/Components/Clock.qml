import QtQuick 2.15
import SddmComponents 2.0

Loader {
    id: clockLoader
    sourceComponent: Clock {
        id: time
        color: config.textDefault
        timeFont.family: config.Font
        dateFont.family: config.Font
    }

    anchors {
        topMargin: parent.height * 0.12
        top: parent.top
    }

    Component.onCompleted: {
        switch (config.ClockPosition) {
            case "left":
                time.anchors.left = parent.left
                break
            case "right":
                time.anchors.right = parent.right
                break
            case "center":
                time.anchors.horizontalCenter = parent.horizontalCenter
                break
            default:
                console.warn("Unsupported clock position:", config.ClockPosition)
        }
    }
}
