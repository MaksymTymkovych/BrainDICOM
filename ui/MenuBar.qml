import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 2.12 as Controls

import Qt.labs.settings 1.1

import "." as Ui


MenuBar {
    delegate: MenuBarItem {
            id: menuBarItem
            contentItem: Text {
                text: menuBarItem.text
                font.pixelSize: Ui.Theme.pixelSize
                color: menuBarItem.highlighted ? Ui.Theme.fontColorHighlighted : Ui.Theme.fontColor
                scale: menuBarItem.highlighted ? 1.1 : 1.0
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideMiddle
            }
            background: Rectangle {
                implicitWidth: 40
                implicitHeight: 40
                color: menuBarItem.highlighted ? Ui.Theme.backgroundColorHighlighted : Ui.Theme.backgroundColor
                scale: menuBarItem.highlighted ? 1.1 : 1.0
            }
        }

        background: Rectangle {
            anchors.fill: parent
            color: Ui.Theme.backgroundColor
        }


    Menu {
        id: fileMenu
        title: qsTr("File")

        Ui.MenuItem {
            id: loadDICOMItem
            objectName: "loadDICOMButton"
            text: qsTr("Load DICOM")
            onClicked: {
                fileDialog.open()
            }
        }

        Ui.MenuSeparator {}

        Ui.MenuItem {
            objectName: "exitButton"
            text: qsTr("Exit")
            onTriggered: Qt.quit()
        }
    }

    Menu {
        id: editMenu
        title: qsTr("Edit")

        Ui.MenuCheckBoxItem {
            id: moveImageMenu
            objectName: "moveImageMenu"
            text: qsTr("Move")
            checked: true
            onCheckedChanged:  {
                checked = true
            }
        }
    }

    Menu {
        id: viewMenu
        title: qsTr("View")

        Ui.MenuCheckBoxItem {
            id: toolBarMenu
            objectName: "toolBarButton"
            text: qsTr("Tool Bar")
            checked: toolBar.visible
            onCheckedChanged: {
                toolBar.visible = checked
            }
        }

        Ui.MenuCheckBoxItem {
            id: propertiesPanelMenu
            objectName: "propertiesPanelButton"
            text: qsTr("Properties Panel")
            checked: contentPanel.visible
            onCheckedChanged: {
                contentPanel.propertyPanelVisible = checked
            }
        }

        Ui.MenuCheckBoxItem {
            id: dicomTagsPanelMenu
            objectName: "dicomTagsPanelButtom"
            text: qsTr("Dicom tags Panel")
            checked: contentPanel.tagPanelVisible
            onCheckedChanged: {
                contentPanel.tagPanelVisible = checked
            }
        }

        Ui.MenuCheckBoxItem {
            id: statusBarMenu
            objectName: "statusBarButton"
            text: qsTr("Status Bar")
            checked: statusBar.visible
            onCheckedChanged: {
                statusBar.visible = checked
            }

        }

    }

    /*
    Ui.Menu {
        id: toolsMenu
        title: qsTr("Tools")
    }
    */

    Menu {
        id: helpMenu
        title: qsTr("Help")

        Ui.MenuItem {
            objectName: "aboutButton"
            text: qsTr("About")
            onClicked: {
                var component = Qt.createComponent("AboutWindow.qml")
                var window = component.createObject("root")
                window.show()
            }
        }
    }


    Settings {
        property alias toolBarVisible: toolBarMenu.checked
        property alias statusBarVisible: statusBarMenu.checked
        property alias dicomTagsPanelVisible: dicomTagsPanelMenu.checked
        property alias propertiesPanelVisible: propertiesPanelMenu.checked
    }


}
