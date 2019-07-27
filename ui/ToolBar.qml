import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import "." as Ui

ToolBar {
    Row {
        anchors.fill: parent

        Ui.ToolButton {
            id: toolButtonMove
            ToolTip.text: qsTr("Move Image")
            ico: "\uf0b2"
        }

        ToolSeparator {}

        Ui.ToolButton {
            id: toolButtonOther
            ToolTip.text: qsTr("Text2")
        }
    }

    background: Rectangle {
        color: Ui.Theme.backgroundColor

    }
}
