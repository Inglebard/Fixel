import QtQuick 2.2
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItem

import "../Components"
import "../../js/SettingsController.js" as SettingsController

Page {
    id: globalSettings
    title: i18n.tr("Settings")
    flickable: null

    property QtObject activeItem: null
    property bool settingRDY: false

    property alias duraFixerVal: duraFixerVal.text
    property alias colorCheckerVal: colorCheckerVal.text
    property alias colorDurationList: columColorDuration


    function initSetting() {
        SettingsController.SettingsController.load(globalSettings);
        settingRDY=true;
    }

    function makeMeVisible(item) {
        if (!settingRDY || !item) {
            return
        }

        activeItem = item
        var position = scrollArea.contentItem.mapFromItem(item, 0, activeItem.y);

        // check if the item is already visible
        var bottomY = scrollArea.contentY + scrollArea.height
        var itemBottom = position.y + (item.height * 3) // extra margin
        if (position.y >= scrollArea.contentY && itemBottom <= bottomY) {
            return;
        }

        // if it is not, try to scroll and make it visible
        var targetY = itemBottom - scrollArea.height
        if (targetY >= 0 && position.y) {
            scrollArea.contentY = targetY;
        } else if (position.y < scrollArea.contentY) {
            // if it is hidden at the top, also show it
            scrollArea.contentY = position.y;
        }
        scrollArea.returnToBounds()
    }


    Component.onCompleted:
    {
        initSetting();
    }


    Flickable {
        id: scrollArea
        objectName: "scrollArea"

        clip: true
        flickableDirection: Flickable.VerticalFlick
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: globalSettingsButtons.top
            bottomMargin: units.gu(1)
        }
        contentHeight: contents.height

        //onContentHeightChanged: globalSettings.makeMeVisible(globalSettings.activeItem)
        Column {
            id:contents

            spacing: units.gu(1)
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            Divider {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                text: i18n.tr("Checker screen")
            }

            Item {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: childrenRect.height

                Row {
                    id:rowColorChecker
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: units.gu(2)
                        rightMargin: units.gu(2)
                    }

                    Label {
                        id: colorChecker
                        text: i18n.tr("Checker Color:")
                        width: parent.width/2
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    TextField {
                        id: colorCheckerVal
                        width: parent.width/2
                        anchors.verticalCenter: parent.verticalCenter
                        onActiveFocusChanged: {
                            if (activeFocus) {
                                makeMeVisible(colorCheckerVal)
                            }
                        }
                        validator: RegExpValidator { regExp: /^#[0-9a-fA-F]{6}$/ }
                        placeholderText: i18n.tr("ex: #AA00BB")
                    }
                }
            }

            ListItem.ThinDivider {}
            /*
            Item {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: childrenRect.height
                Row {
                    id:rowrDuraChecker
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: units.gu(2)
                        rightMargin: units.gu(2)
                    }

                    Label {
                        id: duraChecker
                        width: parent.width/2
                        text: i18n.tr("Checker duration:")
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    TextField {
                        id: duraCheckerVal
                        width: parent.width/2
                        anchors.verticalCenter: parent.verticalCenter
                        focus: true
                        onActiveFocusChanged: {
                            if (activeFocus) {
                                makeMeVisible(duraCheckerVal)
                            }
                        }
                        validator: RegExpValidator { regExp: /^[0-9]{1,6}$/ }
                        placeholderText: i18n.tr("ex: 100(ms)")
                    }
                }
            }
            */
            Divider {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                text: i18n.tr("Fixer screen")
            }



            Item {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: childrenRect.height

                Row {
                    id: rowDuraFixer
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: units.gu(2)
                        rightMargin: units.gu(2)
                    }

                    Label {
                        id: duraFixer
                        width: parent.width/2
                        text: i18n.tr("Fixer duration:")
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    TextField {
                        id: duraFixerVal
                        width: parent.width/2
                        anchors.verticalCenter: parent.verticalCenter
                        onActiveFocusChanged: {
                            if (activeFocus) {
                                makeMeVisible(duraFixerVal)
                            }
                        }
                        validator: RegExpValidator { regExp: /^[0-9]{1,6}$/ }
                        placeholderText: i18n.tr("ex: 100(ms)")
                    }
                }
            }

            Divider {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                text: i18n.tr("Fixer colors")
            }
            Item
            {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                height: childrenRect.height+units.gu(5)

                Column {
                    id:columColorDuration
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                }

                AddNew {
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: columColorDuration.bottom
                    }
                    text: i18n.tr("Add new");
                    onClicked: {
                        var component;
                        var addto;

                        component = Qt.createComponent("../Components/AccordionColorDuration.qml");
                        if (component.status == Component.Ready) {
                            finishCreation();
                        }
                        else {
                            component.statusChanged.connect(finishCreation);
                        }

                        function finishCreation() {
                            if (component.status == Component.Ready) {
                                addto = component.createObject(columColorDuration);
                                if (addto == null) {
                                    console.log("Error creating object");
                                }
                            }
                            else if (component.status == Component.Error) {
                                console.log("Error loading component:", component.errorString());
                            }
                        }
                    }
                }
            }
        }
    }

    Column {
        id: globalSettingsButtons
        anchors.leftMargin: units.gu(1)
        anchors.bottomMargin: units.gu(1) + keyboard.height
        anchors.rightMargin: units.gu(1)
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Row
        {
            id:settingButtonsLayout
            anchors.left: parent.left
            anchors.right: parent.right
            Button {
                id: saveButton
                width: parent.width
                text: i18n.tr("Save")
                color:"#DD4814"
                onClicked:
                {
                    SettingsController.SettingsController.save(globalSettings);
                    settingRDY=false;
                    mainPage_PageStack.pop();
                }
            }
        }
    }

    KeyboardRectangle {
        id: keyboard
        onHeightChanged: {
            if (activeItem) {
                makeMeVisible(activeItem)
            }
        }
    }
}
