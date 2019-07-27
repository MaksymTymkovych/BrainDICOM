import QtQuick 2.0
import QtQuick.Controls 2.13

import Qt.labs.settings 1.1

import '.' as Ui


Popup {

    FontLoader { id: fontAwesome; source: "qrc:///fonts/fontawesome-webfont.ttf" }

    x: 100
    y: 100
    width: 200
    height: 240
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle {
        anchors.fill: parent
        color: Ui.Theme.backgroundColor
    }

    Component {
        id: popupMenuDelegate

        Item {
            id: checkBox
            property bool isChecked: checked
            implicitWidth: 200
            implicitHeight: 40

            Row {
                opacity: mouseArea.containsMouse ? 1.1 : 1.0
                scale:  mouseArea.containsMouse ? 1.1 : 1.0
                smooth: mouseArea.containsMouse


                Text {
                    font.family: fontAwesome.name
                    color: mouseArea.containsMouse ? Ui.Theme.fontColorHighlighted : Ui.Theme.fontColor
                    font.pixelSize: 18
                    text: checkBox.isChecked ? "\uf046" : "\uf096"
                    width: 20

                }
                Text {
                    text: qsTr(name)
                    color: mouseArea.containsMouse ? Ui.Theme.fontColorHighlighted : Ui.Theme.fontColor
                    font.family: "Lato"
                    font.pixelSize: 14
                }

            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    checked = !checked
                    tableViewPopup.close()
                    if (name==="TagId") {
                        contentPanel.tableViewTagIdVisible = checked
                    } else if (name==="VR") {
                        contentPanel.tableViewVRVisible = checked
                    } else if (name==="VM") {
                        contentPanel.tableViewVMVisible = checked
                    } else if (name==="Length") {
                        contentPanel.tableViewLengthVisible = checked
                    } else if (name==="Description") {
                        contentPanel.tableViewDescriptionVisible = checked
                    } else if (name==="Value") {
                        contentPanel.tableViewValueVisible = checked
                    }
                }
            }


        }

    }

    ListModel {
        id: tableViewContextMenuModel

        property bool tagIdVisible: true
        property bool vrVisible: true
        property bool vmVisible: true
        property bool lengthVisible: true
        property bool descriptionVisible: true
        property bool valueVisible: true

        property bool completed: false

        Component.onCompleted: {
            append({"name": "TagId",checked: tagIdVisible})
            append({"name": "VR",checked: vrVisible})
            append({"name": "VM",checked: vmVisible})
            append({"name": "Length",checked: lengthVisible})
            append({"name": "Description",checked: descriptionVisible})
            append({"name": "Value",checked: valueVisible})
            completed = true
        }

        onTagIdVisibleChanged: {
            if(completed) setProperty(0, "checked", tagIdVisible);
        }

        onVrVisibleChanged: {
            if(completed) setProperty(1, "checked", vrVisible);
        }

        onVmVisibleChanged: {
            if(completed) setProperty(2, "checked", vmVisible);
        }

        onLengthVisibleChanged: {
            if(completed) setProperty(3, "checked", lengthVisible);
        }

        onDescriptionVisibleChanged: {
            if(completed) setProperty(4, "checked", descriptionVisible);
        }

        onValueVisibleChanged: {
            if(completed) setProperty(5, "checked", valueVisible);
        }
    }

    ListView {
        width: 180; height: 400
        interactive: false

        model: tableViewContextMenuModel
        delegate: popupMenuDelegate

    }

    Settings {
        property alias tableViewTagIdVisible: tableViewContextMenuModel.tagIdVisible
        property alias tableViewVRVisible: tableViewContextMenuModel.vrVisible
        property alias tableViewVMVisible: tableViewContextMenuModel.vmVisible
        property alias tableViewLengthVisible: tableViewContextMenuModel.lengthVisible
        property alias tableViewDescriptionVisible: tableViewContextMenuModel.descriptionVisible
        property alias tableViewValueVisible: tableViewContextMenuModel.valueVisible
    }




}
