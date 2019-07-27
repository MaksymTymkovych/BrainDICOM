import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls

import "." as Ui

Controls.MenuSeparator {
    background: Rectangle {
        color: Ui.Theme.backgroundColor
    }
    contentItem: Item{
        Text {
        }
    }
}

