import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.13

import Qt.labs.settings 1.1

import App.Utility 1.0

import "ui" as Ui


ApplicationWindow {
    id: appWindow
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Brain DICOM")

    menuBar: Ui.MenuBar {
        id: menuBar
    }

    header: Ui.ToolBar {
        id: toolBar
    }

    Ui.ContentPanel {
        id: contentPanel
    }

    Ui.TableViewContextMenu {
        id: tableViewPopup
    }

    footer: Ui.StatusBar {
        id: statusBar
    }

    FileDialog {
        id: fileDialog
        onFileUrlChanged: {
            if (Utility.fileExists(fileUrl)) {
                appWindow.title = "Brain DICOM: [" + Utility.extractFileNameFromPath(fileUrl)+"]"
                contentPanel.imageSource = fileUrl
                dicomTagsModel.loadFromFile(fileUrl)
            }
        }
    }

    Settings {
        property alias tableViewTagIdVisible: contentPanel.tableViewTagIdVisible
        property alias tableViewVRVisible: contentPanel.tableViewVRVisible
        property alias tableViewVMVisible: contentPanel.tableViewVMVisible
        property alias tableViewLengthVisible: contentPanel.tableViewLengthVisible
        property alias tableViewDescriptionVisible: contentPanel.tableViewDescriptionVisible
        property alias tableViewValueVisible: contentPanel.tableViewValueVisible
    }
}
