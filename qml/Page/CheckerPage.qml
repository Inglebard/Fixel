import QtQuick 2.2
import QtQuick.Window 2.2
import Ubuntu.Components 1.1
import "../../js/SettingsController.js" as SettingsController

Page {
    title: ""
    visible: false

    function initChecker() {
        checkerRectangle.color = SettingsController.SettingsController.getCheckerColor();
    }

    Component.onCompleted:
    {
        initChecker();
    }

    Rectangle {
        id: checkerRectangle
        color: "#000000"
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            onClicked: {
                 mainWindow.visibility=Window.Windowed
                 main_PageStack.pop()
            }
        }
    }
}
