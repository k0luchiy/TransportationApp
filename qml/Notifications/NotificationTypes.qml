pragma Singleton
import QtQuick 2.15

import Colors

QtObject {

    property var info : QtObject{
        property color  typeColor   : Colors.blue.blue600
        property url    iconSource  : "qrc:/assets/icons/Essentials/Info.svg"
        property string titleText   : qsTr("Information")
    }

    property var success : QtObject{
        property color  typeColor   : Colors.green.green600
        property url    iconSource  : "qrc:/assets/icons/Essentials/Success.svg"
        property string titleText   : qsTr("Success")
    }

    property var warning : QtObject{
        property color  typeColor   : Colors.yellow.yellow600
        property url    iconSource  : "qrc:/assets/icons/Essentials/Warning.svg"
        property string titleText   : qsTr("Warning")
    }

    property var failure : QtObject{
        property color  typeColor   : Colors.red.red600
        property url    iconSource  : "qrc:/assets/icons/Essentials/Failure.svg"
        property string titleText   : qsTr("Failure")
    }
}
