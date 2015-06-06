import QtQuick 2.0

Accordion {
    id: accordionColorDuration

    anchors {
        left: parent.left
        right: parent.right
    }
    description:  i18n.tr("Color: ")
                  + contentsItem.colorValue
                  + ", "
                  + i18n.tr("Duration: ")
                  + contentsItem.durationValue
                  + " "
                  +i18n.tr("ms")

    text:  i18n.tr("Color screen")
    contents: ColorDuration {
    }
}
