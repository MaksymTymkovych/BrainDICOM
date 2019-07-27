import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import Qt.labs.settings 1.1

import "." as Ui
import ".." as App

RowLayout {
    property bool tagPanelVisible: true
    property bool imagePanelVisible: true
    property bool propertyPanelVisible: true
    property string imageSource: ""
    property real zoom: 1.0


    property bool tableViewTagIdVisible: true
    property bool tableViewVRVisible: true
    property bool tableViewVMVisible: true
    property bool tableViewLengthVisible: true
    property bool tableViewDescriptionVisible: true
    property bool tableViewValueVisible: true

    anchors.fill: parent
    spacing: 0


    onImageSourceChanged: {
        mainImage.x = 0
        mainImage.y = 0
        tform.xScale = 1
        tform.yScale = 1
    }


    TableView {
        visible: tagPanelVisible
        Layout.fillHeight: true
        Layout.preferredWidth: 680
        Layout.maximumWidth: 700
        Layout.minimumWidth: 300

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            onClicked: {
                if(mouse.button != Qt.RightButton) return;
                tableViewPopup.x = mouseX
                tableViewPopup.y = mouseY
                tableViewPopup.open()
            }
        }


        headerDelegate: Rectangle {
            height: 22
            color: Ui.Theme.backgroundColor
            Text {
                color: Ui.Theme.fontColor
                text: styleData.value
                width: parent.width
                height: parent.height
                font.pointSize: 18
                minimumPointSize: 3
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: false
            }
            border {
                width: 1
                color: (styleData.selected)?"skyblue":"black"
            }
        }




        style: TableViewStyle{

            textColor: Ui.Theme.fontColor

            backgroundColor: Ui.Theme.panelBackgroundColor
            alternateBackgroundColor: Qt.lighter(Ui.Theme.panelBackgroundColor,1.2)

            corner: Rectangle {
                color: Ui.Theme.panelBackgroundColor

            }

            scrollBarBackground:Rectangle {
                color: Ui.Theme.panelBackgroundColor
                implicitWidth: 18
                implicitHeight: 18
                border.color: Qt.lighter(Ui.Theme.panelBackgroundColor,1.25)
                border.width: 1
            }


            handle: Rectangle {
                implicitWidth: 18
                implicitHeight: 18
                color:  Qt.darker(Ui.Theme.panelBackgroundColor, 1.5)
            }

            incrementControl: Rectangle {

                color: styleData.pressed ? Qt.darker(Ui.Theme.panelBackgroundColor, 1.5) : Ui.Theme.panelBackgroundColor
                implicitHeight: 18
                implicitWidth: 18
                Text {

                    font.family: fontAwesome.name
                    color: styleData.pressed ? Qt.darker(Ui.Theme.fontColor, 1.5) : Ui.Theme.fontColor
                    font.pixelSize: 18
                    text: " \uf0da"
                    rotation: styleData.horizontal ? 0 : 90
                    width: 18
                }

            }

            decrementControl: Rectangle {

                color: styleData.pressed ? Qt.darker(Ui.Theme.panelBackgroundColor, 1.5) : Ui.Theme.panelBackgroundColor
                implicitHeight: 18
                implicitWidth: 18
                Text {

                    font.family: fontAwesome.name
                    color: styleData.pressed ? Qt.darker(Ui.Theme.fontColor, 1.5) : Ui.Theme.fontColor
                    font.pixelSize: 18
                    text: " \uf0da"
                    rotation: styleData.horizontal ? 180 : 270
                    width: 18
                }

            }

            minimumHandleLength: 30
        }



        TableViewColumn {
            role: "tagId"
            title: "Tag Id"
            width: 100
            visible: tableViewTagIdVisible
        }

        TableViewColumn {
            id: tableViewVR
            role: "vr"
            title: "VR"
            width: 50
            visible: tableViewVRVisible
        }

        TableViewColumn {
            id: tableViewVM
            role: "vm"
            title: "VM"
            width: 50
            visible: tableViewVMVisible
        }

        TableViewColumn {
            id: tableViewLength
            role: "length"
            title: "Length"
            width: 70
            visible: tableViewLengthVisible
        }

        TableViewColumn {
            id: tableViewDescription
            role: "description"
            title: "Description"
            width: 200
            visible: tableViewDescriptionVisible
        }

        TableViewColumn {
            id: tableViewValue
            role: "value"
            title: "Value"
            width: 200
            visible: tableViewValueVisible
        }

        model: dicomTagsModel


    }

    Rectangle {
        z:-1
        visible: imagePanelVisible
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 300

        color: Ui.Theme.panelBackgroundColor
        border.color: Ui.Theme.panelBorderColor
        border.width: 2

        Image {
            id: mainImage

            asynchronous: true
            onStatusChanged: {
                  if (status == Image.Ready) {
                      mainImage.width = sourceSize.width
                      mainImage.height = sourceSize.height
                  }
            }
            source: imageSource===""?"":"image://dcm/"+imageSource.replace('file:///','')



            transform: Scale {
                id: tform
            }

            MouseArea {
                anchors.fill: parent

                property double factor: 1.25

                drag.target: mainImage
                drag.axis: Drag.XAndYAxis

                onWheel: {
                    if (wheel.modifiers & Qt.ControlModifier) {


                        if(wheel.angleDelta.y > 0)
                            var zoomFactor = factor
                        else
                            zoomFactor = 1/factor

                        var realX = wheel.x * tform.xScale
                        var realY = wheel.y * tform.yScale

                        mainImage.x += (1 - zoomFactor) * realX
                        mainImage.y += (1 - zoomFactor) * realY

                        tform.xScale *=zoomFactor
                        tform.yScale *=zoomFactor

                        //var dx = (mouseX - mainImage.x) * (tform.xScale - 1),
                        //    dy = (mouseY - mainImage.y) * (tform.yScale - 1);
                        //mainImage.x = mainImage.x - dx
                        //mainImage.y = mainImage.y - dy
                    }
                }

                onMouseXChanged:  {
                    statusBar.xPos = Math.trunc(mouse.x)
                }
                onMouseYChanged:  {
                    statusBar.yPos = Math.trunc(mouse.y)
                }
            }
        }
    }



    Rectangle {
        visible: propertyPanelVisible
        Layout.fillHeight: true
        Layout.preferredWidth: 300

        Layout.minimumWidth: 200
        color: Ui.Theme.panelBackgroundColor
        border.color: Ui.Theme.panelBorderColor
        border.width: 2
    }



    FontLoader { id: fontAwesome; source: "qrc:///fonts/fontawesome-webfont.ttf" }
}
