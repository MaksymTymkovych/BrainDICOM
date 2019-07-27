import QtQuick 2.0

import QtQuick.Layouts 1.12

import "." as Ui

Row {
    id: root

    function __update() {
        var totalWidth = 0;
        for (var i = 0; i < children.length - 1; i++) {
            var child = children[i];
            totalWidth += child.width
        }
        var last = children[i];
        last.width = root.width - totalWidth
    }

    onChildrenChanged: __update()
    onVisibleChanged: __update()
    onWidthChanged: __update()

    property string xPos: ""
    property string yPos: ""
    height: 20
    width: parent.width

    Rectangle {
        color: Ui.Theme.panelBackgroundColor
        width: 10
        height: parent.height
    }

    Rectangle {
        id: statusMouseX
        color: Ui.Theme.panelBackgroundColor
        width: 100
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        Text {
            color: Ui.Theme.fontColor
            text: qsTr("Mouse X: ") + xPos
        }
    }

    Rectangle {
        id: statusMouseY
        color: Ui.Theme.panelBackgroundColor
        width: 100
        height: parent.height
        Text {
            color: Ui.Theme.fontColor
            text: qsTr("Mouse Y: ") + yPos
        }
    }

    Rectangle {
        id: statusIntensity
        color: Ui.Theme.panelBackgroundColor
        width: 140
        height: parent.height
        Text {
            color: Ui.Theme.fontColor
            text: qsTr("Intensity: ")
        }
    }

    Rectangle {
        color: Ui.Theme.panelBackgroundColor
        width: 10
        height: parent.height
    }
}
