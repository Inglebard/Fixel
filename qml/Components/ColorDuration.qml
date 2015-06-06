import QtQuick 2.2
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.1


Item {


    property int mapId: -1
    property alias colorValue: colorValue.text
    property alias durationValue: durationValue.text
    property bool deleted: false


    anchors.margins: units.gu(1)
    anchors.left: parent.left
    anchors.right: parent.right
    height: childrenRect.height

    Row {
        id:rowColor
        anchors {
            left: parent.left
            right: parent.right
        }

        Label {
            id: colorLabel
            text: i18n.tr("Color:")
            width: parent.width / 2
            anchors.verticalCenter: parent.verticalCenter
        }

        TextField {
            id: colorValue
            width: parent.width / 2
            anchors.verticalCenter: parent.verticalCenter
            onActiveFocusChanged: {
                if (activeFocus) {
                    makeMeVisible(colorValue)
                }
            }
            validator: RegExpValidator { regExp: /^#[0-9a-fA-F]{6}$/ }
            placeholderText: i18n.tr("ex: #AA00BB")
        }
    }

    Row {
        id: rowDuration
        anchors {
            left: parent.left
            right: parent.right
            top:rowColor.bottom
            topMargin: units.gu(1)
        }
        Label {
            id: durationLabel
            text: i18n.tr("Duration:")
            width: parent.width / 2
            anchors.verticalCenter: parent.verticalCenter
        }

        TextField {
            id: durationValue
            width: parent.width / 2
            anchors.verticalCenter: parent.verticalCenter
            onActiveFocusChanged: {
                if (activeFocus) {
                    makeMeVisible(durationValue)
                }
            }
            validator: RegExpValidator { regExp: /^[0-9]*$/ }
            placeholderText: i18n.tr("ex: 100(ms)")
        }
    }
    Row {
        id:rowDeleteButton
        anchors {
            left: parent.left
            right: parent.right
            top:rowDuration.bottom
            topMargin: units.gu(1)
        }
        Button {
            id: deleteButton
            width: parent.width
            text: i18n.tr("Delete")
            color:"#DD4814"
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                accordionColorDuration.visible=false;
                deleted=true;
            }
        }
    }
}
