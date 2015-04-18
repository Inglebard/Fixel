import QtQuick 2.2
import QtQuick.Window 2.2
import Ubuntu.Components 1.1

Window {
    id: mainWindow
    visible: true

    MainView {
        objectName: "mainView"
        id: mainView
        applicationName: "fixelapp.inglebard"
        automaticOrientation: true
        useDeprecatedToolbar: false
        anchors.fill: parent

        PageStack {
            id: pageStack
            Component.onCompleted: push(mainpage)
            Page {
                id: mainpage
                title: i18n.tr("Fixel")
                visible: false
                Rectangle {
                    id: mainRect
                    anchors.margins: units.gu(2)
                    anchors.fill: parent
                    color: "transparent"

                    Button {
                        id: gofixerbutton
                        objectName: "button"
                        width: parent.width
                        text: i18n.tr("Start")
                        color:"#DD4814"
                        anchors.top:parent.top
                        anchors.topMargin: units.gu(2)
                        onClicked: {
                            if(!fixertimer.running)
                            {
                                fixertimer.start()
                            }
                            pageStack.push(fixerPage)
                            mainWindow.visibility=Window.FullScreen

                        }
                    }

                    Button {
                        id: gocheckbutton
                        objectName: "button"
                        width: parent.width
                        text: i18n.tr("Check")
                        color:"#DD4814"
                        anchors.top:gofixerbutton.bottom
                        anchors.topMargin: units.gu(4)
                        onClicked: {
                            pageStack.push(checkerPage)
                            mainWindow.visibility=Window.FullScreen
                        }
                    }



                    Rectangle {
                        id: rectInfo
                        width:parent.width
                        height: units.gu(5)
                        anchors.bottomMargin: units.gu(2)
                        anchors.bottom: rectWarn.top
                        color: "#D9EDF7"
                        border.color: "#bce8f1"
                        border.width: 5
                        radius: 10


                        Label
                        {
                            id: info
                            objectName: "note"
                            width: parent.width
                            anchors.margins: units.gu(2)
                            anchors.centerIn: parent
                            anchors.fill: parent
                            text: i18n.tr("<html><b>Note : </b>Disable screensaver before start the process.</html>")
                            color: "#31708f"
                            wrapMode: TextEdit.WordWrap
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Rectangle {
                        id: rectWarn
                        width:parent.width
                        height: units.gu(5)
                        anchors.topMargin: units.gu(2)
                        anchors.bottom: parent.bottom
                        color: "#FCF8E3"
                        border.color: "#faebcc"
                        border.width: 5
                        radius: 10

                        Label {
                            id: warn
                            objectName: "warn"
                            width: parent.width
                            anchors.margins: units.gu(2)
                            anchors.fill: parent
                            anchors.centerIn: parent
                            text: i18n.tr("<html><b>Warning : </b>Do not look at the screen during the process.</html>")
                            color: "#8a6d3b"
                            wrapMode: TextEdit.WordWrap
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }
            }
            Page {
                title: ""
                id: fixerPage
                visible: false


                Timer  {
                    id: fixertimer
                    interval: 50;
                    running: false;
                    repeat: true;
                    property int colorToDisplay: 0
                    onTriggered: {
                        switch (colorToDisplay)
                        {
                            case 0:
                               fixerRectangle.color="#FF0000"
                               colorToDisplay++
                            break;
                            case 1:
                               fixerRectangle.color="#00FF00"
                                colorToDisplay++
                            break;
                            case 2:
                            default:
                               fixerRectangle.color="#0000FF"
                               colorToDisplay++
                               colorToDisplay=0
                            break;
                        }
                    }
                }

                Rectangle {
                    id: fixerRectangle
                    color: "#FFFFFF"
                    width:parent.width
                    height:parent.height
                    MouseArea {
                        height: parent.height
                        width: parent.width
                        onClicked: {
                             mainWindow.visibility=Window.Windowed
                             pageStack.pop()
                             fixertimer.stop()
                        }
                    }
                }
            }

            Page {
                title: ""
                id: checkerPage
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
                             pageStack.pop()
                        }
                    }
                }
            }
        }
    }
}
