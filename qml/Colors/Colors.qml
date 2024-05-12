
pragma Singleton

import QtQuick 2.9

QtObject{
    id: colorsObjectRoot


    readonly property var elementary : QtObject{
        readonly property string transparent  : "transparent"
        readonly property string white  : "#FFFFFF"
        readonly property string black  : "#000000"
    }

    readonly property var primary : QtObject{
        readonly property string primary50   : "#E9F1FF"
        readonly property string primary100   : "#CFE5FF"
        readonly property string primary200   : "#9BB8FF"
        readonly property string primary300   : "#638EFF"
        readonly property string primary400   : "#427AFF"
        readonly property string primary500   : "#1371FF"
        readonly property string primary600   : "#0066FF"
        readonly property string primary700   : "#0154D1"
        readonly property string primary800   : "#0049B7"
        readonly property string primary900   : "#0031BA"
        readonly property string primary950   : "#00398F"
    }

    readonly property var neutral : QtObject{
        readonly property string neutral0   : "#FFFFFF"
        readonly property string neutral50  : "#F4F5F7"
        readonly property string neutral100 : "#E9ECF1"
        readonly property string neutral200 : "#D8DDE4"
        readonly property string neutral300 : "#BFC8D4"
        readonly property string neutral400 : "#A4AFC1"
        readonly property string neutral500 : "#8D97B0"
        readonly property string neutral600 : "#717998"
        readonly property string neutral700 : "#62667F"
        readonly property string neutral800 : "#4A4E5E"
        readonly property string neutral900 : "#393C46"
        readonly property string neutral950 : "#17181C"
        //readonly property string neutral1000 : "#000000"
    }

    readonly property var green : QtObject{
        readonly property string green50  : "#F0FDF5"
        readonly property string green100 : "#DCFCE7"
        readonly property string green200 : "#BBF7D0"
        readonly property string green500 : "#22C55E"
        readonly property string green600 : "#16A34A"
        readonly property string green700 : "#15803D"
        readonly property string green950 : "#0D602C"
    }

    readonly property var red : QtObject{
        readonly property string red50  : "#FFF1F3"
        readonly property string red100 : "#FFE4E6"
        readonly property string red200 : "#FECDD3"
        readonly property string red500 : "#F43F5E"
        readonly property string red600 : "#E11D48"
        readonly property string red700 : "#BE123C"
        readonly property string red950 : "#921231"
    }

}
