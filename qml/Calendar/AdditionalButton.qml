import QtQuick 2.15

import Colors

Item {
    property string text
    property color fontColor : Themes.colors.neutral.neutral600
    property int fontSize : 10

    signal clicked

    id: btnRoot
    height: 30

    Text{
        color: btnRoot.fontColor
        font.pointSize: btnRoot.fontSize
        text: btnRoot.text

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked : {
                btnRoot.clicked()
            }
        }
    }
}
