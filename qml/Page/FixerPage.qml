import QtQuick 2.2
import QtQuick.Window 2.2
import Ubuntu.Components 1.1

import "../../js/SettingsController.js" as SettingsController


Page {
    title: ""
    visible: false

    function initFixer()
    {
        var colorDurationArray = SettingsController.SettingsController.getColorDurationList();
        var fixerDuration = SettingsController.SettingsController.getFixerDuration();
        fixerTimer.colorToDisplay=1; //because 0 is set
        fixerTimer.msElapsed=0;
        fixerTimer.msMax=fixerDuration;
        fixerTimer.colorDurationArray=colorDurationArray;
        fixerTimer.interval=colorDurationArray[0].duration;
        fixerRectangle.color=colorDurationArray[0].color;

    }

    function startFixer()
    {
        if(!fixerTimer.running)
        {
            fixerTimer.start()
        }
    }

    Component.onCompleted: {
        initFixer();
    }

    Timer  {
        id: fixerTimer
        interval: 50;
        running: false;
        repeat: true;
        property var colorDurationArray;
        property int colorToDisplay: 0        
        property int msElapsed: 0
        property int msMax: 0

        onTriggered: {
            console.log(msElapsed);
            console.log(msMax);
            msElapsed+=fixerTimer.interval;

            fixerRectangle.color=colorDurationArray[colorToDisplay].color;
            fixerTimer.interval=colorDurationArray[colorToDisplay].duration;

            colorToDisplay++

            if(colorToDisplay>=colorDurationArray.length)
            {
                colorToDisplay=0
            }
            if(msMax != 0 && msElapsed >= msMax)
            {
                fixerTimer.stop();
                initFixer();                
                mainWindow.visibility=Window.Windowed
                main_PageStack.pop()
            }
        }
    }

    Rectangle {
        id: fixerRectangle
        color: "#FFFFFF"
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            onClicked: {
                 mainWindow.visibility=Window.Windowed
                 main_PageStack.pop()
                 fixerTimer.stop()
            }
        }
    }
}
