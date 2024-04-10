import "components"

import QtQuick 2.0
import QtQuick.Layouts 1.2

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

// Additional imports.
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

SessionManagementScreen {

    property Item mainPasswordBox: passwordBox

    property bool showUsernamePrompt: !showUserList

    property string lastUserName

    //the y position that should be ensured visible when the on screen keyboard is visible
    property int visibleBoundary: mapFromItem(loginButton, 0, 0).y
    onHeightChanged: visibleBoundary = mapFromItem(loginButton, 0, 0).y + loginButton.height + units.smallSpacing

    signal loginRequest(string username, string password)

    onShowUsernamePromptChanged: {
        if (!showUsernamePrompt) {
            lastUserName = ""
        }
    }

    /*
    * Login has been requested with the following username and password
    * If username field is visible, it will be taken from that, otherwise from the "name" property of the currentIndex
    */
    function startLogin() {
        var username = showUsernamePrompt ? userNameInput.text : userList.selectedUser
        var password = passwordBox.text

        //this is partly because it looks nicer
        //but more importantly it works round a Qt bug that can trigger if the app is closed with a TextField focused
        //DAVE REPORT THE FRICKING THING AND PUT A LINK
        loginButton.forceActiveFocus();
        loginRequest(username, password);
    }

    PlasmaComponents.TextField {
        id: userNameInput
        Layout.fillWidth: true

        style: TextFieldStyle {
            textColor: "#aaaaac"
            selectedTextColor: "#dadadc"
            selectionColor: "#5a5a5c"
            placeholderTextColor: "#5a5a5c"
            background: Rectangle {
                color: "#cb1e1e20"
                radius: 2
                                                //hovered     //normal
                border.color: control.hovered ? "#47ffffff" : "#2fffffff"
                border.width: 1
                implicitHeight: 30
            }
        }
        font.family: config.font
        font.pointSize: config.fontSize
        text: lastUserName
        visible: showUsernamePrompt
        placeholderText: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Username")
        focus: showUsernamePrompt && !lastUserName //if there's a username prompt it gets focus first, otherwise password does

        onAccepted: passwordBox.forceActiveFocus()
    }

    PlasmaComponents.TextField {
        id: passwordBox
        Layout.fillWidth: true

        style: TextFieldStyle {
            textColor: "#aaaaac"
            selectedTextColor: "#dadadc"
            selectionColor: "#5a5a5c"
            placeholderTextColor: "#5a5a5c"
            background: Rectangle {
                color: "#cb1e1e20"
                radius: 2
                                                //hovered     //normal
                border.color: control.hovered ? "#47ffffff" : "#2fffffff"
                border.width: 1
                implicitHeight: 30
            }
        }
        font.family: config.font
        font.pointSize: config.fontSize
        placeholderText: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Password")
        focus: !showUsernamePrompt || lastUserName
        echoMode: TextInput.Password
        revealPasswordButtonShown: true

        onAccepted: startLogin()

        Keys.onEscapePressed: {
            mainStack.currentItem.forceActiveFocus();
        }

        //if empty and left or right is pressed change selection in user switch
        //this cannot be in keys.onLeftPressed as then it doesn't reach the password box
        Keys.onPressed: {
            if (event.key == Qt.Key_Left && !text) {
                userList.decrementCurrentIndex();
                event.accepted = true
            }
            if (event.key == Qt.Key_Right && !text) {
                userList.incrementCurrentIndex();
                event.accepted = true
            }
        }

        Connections {
            target: sddm
            onLoginFailed: {
                passwordBox.selectAll()
                passwordBox.forceActiveFocus()
            }
        }
    }
    PlasmaComponents.Button {
        id: loginButton
        Layout.fillWidth: true

        style: ButtonStyle {
            background: Rectangle {
                border.width: 1
                                                //hovered     //normal
                border.color: control.hovered ? "#727274" : "#606062"
                radius: 2
                gradient: Gradient {                                      //hovered   //normal
                    GradientStop { position: 0 ; color: control.pressed ? "#7a7a7c" : "#5c5c5e" }
                    GradientStop { position: 1 ; color: control.pressed ? "#646466" : "#48484a" }
                }
                implicitHeight: 30
            }
            label: Component {
                id: labelLogin
                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: (parent.width - (textlogin.width + image.width))/2
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    spacing: 0
                    Image {
                        id: image
                        source: control.iconSource
                    }
                    Label {
                        id: textlogin
                        height: parent.height
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "#aaaaac"
                        text: control.text
                        font.family: config.font
                        font.pointSize: config.fontSize
                        font.underline: loginButton.activeFocus
                    }
                }
            }
        }
        text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Login")
        onClicked: startLogin();
    }
}
