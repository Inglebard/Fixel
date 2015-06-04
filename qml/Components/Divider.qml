import QtQuick 2.2
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItem

/* extract from Dekko app :*/
Rectangle {
    height: childrenRect.height
    color: "#d4d3d5"
    anchors {
        left: parent.left
        right: parent.right
    }
    property alias text: sectionLabel.text
    property alias showDivider: divider.visible

    Label {
        id: sectionLabel
        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            right: parent.right
            rightMargin: units.gu(2)
        }
        height: units.gu(4)
        fontSize: "medium"
        font.weight: Font.DemiBold
        verticalAlignment: Text.AlignVCenter
        
    }
    ListItem.ThinDivider {
        id: divider
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
}
