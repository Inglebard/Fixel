import QtQuick 2.2
import QtQuick.Window 2.2
import Ubuntu.Components 1.1


Page {
    title: ""
    visible: false

    Timer  {
        id: fixerTimer
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
                 main_PageStack.pop()
                 fixerTimer.stop()
            }
        }
    }
    function startFixer() {
        if(!fixerTimer.running)
        {
            fixerTimer.start()
        }
        main_PageStack.push(fixerPage)
        mainWindow.visibility=Window.FullScreen
    }
}
