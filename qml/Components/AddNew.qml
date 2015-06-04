import QtQuick 2.2
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItem

ListItem.Standard {
    id: addNewButton

    property alias text: text.text

    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: units.gu(2)
        anchors.rightMargin: units.gu(2)

        AbstractButton {
            anchors.fill:parent
            Item {
                anchors.leftMargin: units.gu(1)
                anchors.left: icon.right
                anchors.right: parent.right
                anchors.top:parent.top
                anchors.bottom: parent.bottom
                Label {
                    id: text
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    fontSize: "medium"
                }
            }
            Icon {
                id: icon
                height: text.paintedHeight;
                width: height
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                name: "add"
            }
        }
    }
}
