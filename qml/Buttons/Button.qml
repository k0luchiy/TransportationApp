import QtQuick 2.15
import QtQuick.Layouts
import Colors

Rectangle {
    property var buttonSize : ButtonSizes.mediumSize
    property color bgColor : Themes.colors.primary.primary500
    property color fontColor : "#000000" //Themes.colors.white
    property string btnText : "Button"

    signal clicked()

    id: buttonRoot
    width: buttonSize.width
    height: buttonSize.height

    Text{
        font.pointSize: buttonSize.fontSize
        color: fontColor
        text: buttonRoot.btnText
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            buttonRoot.clicked();
        }
        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
