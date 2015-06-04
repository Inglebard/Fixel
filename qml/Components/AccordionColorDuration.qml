import QtQuick 2.0

Accordion {
    id: accordionColorDuration

    anchors {
        left: parent.left
        right: parent.right
    }
    description:  i18n.tr("Color")
    text:  i18n.tr("Color value")
    contents: ColorDuration {
    }
}
