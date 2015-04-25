import QtQuick 2.2
import Ubuntu.Components 1.1

Page {
    id : aboutPage
    title: i18n.tr("About Fixel")

    Column {
        spacing: units.gu(4)
        anchors.fill: parent
        anchors.topMargin: units.gu(4)
        Item {
            id: icon
            width: parent.width
            height: appIcon.height + units.gu(1)

            UbuntuShape {
                id: appIcon

                width: aboutPage.width/3
                height: width
                anchors.centerIn: parent

                image: Image {
                    source: "Fixel.svg"
                }
            }
        }
        Item {
            id: description

            width: parent.width
            height: name.height + description_text.height + units.gu(4)
            Column {
                anchors.fill: parent
                spacing: units.gu(1)
                Label {
                    id: name

                    text: "Fixel v1.0"
                    anchors.horizontalCenter: parent.horizontalCenter
                    fontSize: "x-large"
                    horizontalAlignment:  Text.AlignHCenter
                }

                Label {
                    id: description_text

                    width: parent.width - units.gu(2)
                    text: i18n.tr("Repair your stuck pixels")
                    anchors.horizontalCenter: parent.horizontalCenter
                    wrapMode: Text.WordWrap
                    horizontalAlignment:  Text.AlignHCenter
                }

                Label {
                    id: website

                    width: parent.width - units.gu(2)
                    text: i18n.tr("Website and support: ") + "<a href='https://github.com/Inglebard/Fixel'>Fixel</a>"
                    wrapMode: Text.WordWrap
                    horizontalAlignment:  Text.AlignHCenter
                    onLinkActivated: Qt.openUrlExternally(link)
                }

                Label {
                    id: license

                    width: parent.width - units.gu(2)
                    text: i18n.tr("License: ") + "<a href='http://opensource.org/licenses/GPL-2.0'>GPL2</a>"
                    wrapMode: Text.WordWrap
                    horizontalAlignment:  Text.AlignHCenter
                    onLinkActivated: Qt.openUrlExternally(link)
                }

            }
        }
    }
}
