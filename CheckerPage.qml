import QtQuick 2.2
import QtQuick.Window 2.2
import Ubuntu.Components 1.1

Page {
    title: ""
    visible: false

    Rectangle {
        id: checkerRectangle
        color: "#000000"
        width:parent.width
        height:parent.height
        MouseArea {
            height: parent.height
            width: parent.width
            onClicked: {
                 mainWindow.visibility=Window.Windowed
                 main_PageStack.pop()
            }
        }
    }
}
