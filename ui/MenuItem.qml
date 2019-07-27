import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls


import "." as Ui

Controls.MenuItem {
    contentItem: Text {
        text: "  "+parent.text
        font.pixelSize: Ui.Theme.pixelSize
        color: parent.highlighted ? Ui.Theme.fontColorHighlighted : Ui.Theme.fontColor
        scale: parent.highlighted ? 1.1 : 1.0
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideMiddle

    }

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        color: parent.highlighted ? Ui.Theme.backgroundColorHighlighted : Ui.Theme.backgroundColor
        scale: parent.highlighted ? 1.1 : 1.0
    }

}
