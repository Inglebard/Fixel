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
            id: main_PageStack
            Component.onCompleted: {
                push(mainPage)
            }
            MainPage {
                id: mainPage
            }
            FixerPage
            {
                id: fixerPage
            }
            CheckerPage
            {
                id: checkerPage
            }
            Connections {
                target:  mainPage.goFixerButton
                onClicked: {
                    fixerPage.startFixer();
                }
            }
        }
    }
}
