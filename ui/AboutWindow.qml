import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.0

ApplicationWindow {
    id: root
    width: 500
    height: 300
    minimumWidth: 500
    minimumHeight: 300
    maximumHeight: minimumHeight
    maximumWidth: minimumWidth
    flags: Qt.Tool


    Image {
        id: image
        source: "qrc:///images/brain.png"
        width: 300
        height: 300
    }

    Text {
        anchors.left: image.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 10
        anchors.right: parent.right
        wrapMode: Text.WordWrap
        text: qsTr("<b>BrainDICOM</b> is Open Source DICOM Viewer writteln in C++, Qt5/QML, and DCMTK.")
    }

    onVisibilityChanged: {
        if (visible==true) {
            setX( ( Screen.width - width ) / 2)
            setY( ( Screen.height - height ) / 2)
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.openUrlExternally("https://github.com/MaksymTymkovych/BrainDICOM/");
        }
    }

}
