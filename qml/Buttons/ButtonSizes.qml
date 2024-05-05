pragma Singleton
import QtQuick 2.15

QtObject {
//    property var smallSize : ButtonSize{
//        width: 60
//        height: 32
//    }
    property var smallSize : QtObject{
        property int width: 84
        property int height: 32
        property int fontSize: 10
        property int iconSize : 16
        property int radius : 5
    }
    property var mediumSize : QtObject{
        property int width: 105
        property int height: 40
        property int fontSize: 12
        property int iconSize : 20
        property int radius : 8
    }
    property var largeSize : QtObject{
        property int width: 120
        property int height: 48
        property int fontSize: 14
        property int iconSize : 24
        property int radius : 10
    }

}
