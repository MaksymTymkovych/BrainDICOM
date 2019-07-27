import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls


import "." as Ui

Controls.MenuItem {
    FontLoader { id: fontAwesome; source: "qrc:///fonts/fontawesome-webfont.ttf" }
    id: menuItem
    checkable: true
    contentItem: Row {
        spacing: 5
        Text {
            font.family: fontAwesome.name
            color: parent.highlighted ? Ui.Theme.fontColorHighlighted : Ui.Theme.fontColor
            font.pixelSize: Ui.Theme.pixelSize
            scale: menuItem.highlighted ? 1.1 : 1.0
            text: menuItem.checked ? "\uf046" : "\uf096"
            width: 20
        }
        Text {
            text: " "+menuItem.text
            font.pixelSize: Ui.Theme.pixelSize
            color: parent.highlighted ? Ui.Theme.fontColorHighlighted : Ui.Theme.fontColor
            scale: menuItem.highlighted ? 1.1 : 1.0
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideMiddle
        }
    }
    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        color: menuItem.highlighted ? Ui.Theme.backgroundColorHighlighted : Ui.Theme.backgroundColor
        scale: menuItem.highlighted ? 1.1 : 1.0
    }

}
