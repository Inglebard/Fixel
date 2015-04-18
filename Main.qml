import QtQuick 2.2
import QtQuick.Window 2.2
import Ubuntu.Components 1.1

Window {
    id: mainWindow
    visible: true

    MainView {
        objectName: "mainView"
        id: mainView
        applicationName: "Fixel.inglebard"
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
                Column {
                    spacing: units.gu(1)
                    anchors.margins: units.gu(2)
                    anchors.fill: parent

                    Label {
                        id: desc
                        objectName: "label"
                        width: parent.width
                        text: i18n.tr("Fixel is a QML app which try to fix stuck pixels")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }


                    Button {
                        id: gofixerbutton
                        objectName: "button"
                        width: parent.width
                        text: i18n.tr("Start")
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
                        onClicked: {
                            pageStack.push(checkerPage)
                            mainWindow.visibility=Window.FullScreen
                        }
                    }

                }
            }
            Page {
                title: i18n.tr("")
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
                title: i18n.tr("")
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
