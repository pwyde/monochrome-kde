/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *   Modified 2019 by Patrik Wyde <patrik@wyde.se>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5

Rectangle {
    id: root
    color: "#1e1e20"

    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = progressBar;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: logo
            //Match SDDM/lockscreen avatar positioning.
            property real size: units.gridUnit * 8

            anchors.centerIn: parent

            source: "images/kde-logo.svg"

            sourceSize.width: size
            sourceSize.height: size
        }

        Image {
            id: progressRect
            //In the middle of the remaining space.
            y: parent.height - (parent.height - logo.y) / 2 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/rectangle.svg"
            sourceSize.height: units.gridUnit * 2
            sourceSize.width: units.gridUnit * 2

            Rectangle {
                id: progressBar
                radius: 0
                /* 
                 * Changing background color of progress bar to the same color
                 * as the main background. This is part of a workaround to the
                 * issue with the filled area of the progress bar which extends
                 * too much.
                 * 
                 * For more information, see https://gitlab.com/pwyde/monochrome-kde/issues/1
                */
                //color: "#414143"
                color: "#1e1e20"
                anchors.horizontalCenter: parent.horizontalCenter
                height: 4
                width: height*32
                Rectangle {
                    radius: 0
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }
                    /* 
                     * Changing the width of the filled area of the progress bar.
                     * This is part of a workaround to the issue below.
                     * 
                     * https://gitlab.com/pwyde/monochrome-kde/issues/1
                    */
                    //width: (parent.width / 4) * (stage - 1)
                    width: (parent.width / 4.75) * (stage - 1)
                    color: "#6e6e70"
                    Behavior on width { 
                        PropertyAnimation {
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
