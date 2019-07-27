import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

import "." as Ui

ToolButton {
    id: toolButton
    property string ico: "\uf188"
    checkable: true
    checked: true
    FontLoader { id: fontAwesome; source: "qrc:///fonts/fontawesome-webfont.ttf" }

    focusPolicy: Qt.NoFocus

    anchors.verticalCenter: parent.verticalCenter

    ToolTip.visible: hovered
    contentItem: Item {
        Text {
            font.family: fontAwesome.name
            color: parent.highlighted ? Ui.Theme.fontColorHighlighted : Ui.Theme.fontColor
            font.pixelSize: Ui.Theme.pixelSize
            text: toolButton.ico
        }
    }

    width: Ui.Theme.toolButtonWidth
    height: Ui.Theme.toolButtonHeight

    background: Rectangle {
        color:  Ui.Theme.backgroundColor
        border.color: toolButton.checked ? Ui.Theme.fontColor : Ui.Theme.backgroundColor
        radius: 5
    }
}
