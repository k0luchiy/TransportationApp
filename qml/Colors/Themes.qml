pragma Singleton

import QtQuick 2.9
import Colors

QtObject{
    id: rootObject

    readonly property var themes : QtObject{

        readonly property var light: QtObject{
            id: lightTheme
            readonly property int themeId : 0

            readonly property var elementary : Colors.elementary
            readonly property var primary : Colors.primary
            readonly property var neutral : Colors.neutral
            readonly property var green : Colors.green
            readonly property var red : Colors.red
        }

        readonly property var dark: QtObject{
            id: darkTheme

            readonly property int themeId : 1

            readonly property var elementary : QtObject{
                readonly property string transparent  : Colors.elementary.transparent
                readonly property string white  : Colors.elementary.black
                readonly property string black  : Colors.elementary.white
            }

            readonly property var primary : QtObject{
                readonly property string primary50  : Colors.primary.primary950
                readonly property string primary100 : Colors.primary.primary900
                readonly property string primary200 : Colors.primary.primary800
                readonly property string primary300 : Colors.primary.primary700
                readonly property string primary400 : Colors.primary.primary600
                readonly property string primary500 : Colors.primary.primary500
                readonly property string primary600 : Colors.primary.primary400
                readonly property string primary700 : Colors.primary.primary300
                readonly property string primary800 : Colors.primary.primary200
                readonly property string primary900 : Colors.primary.primary100
                readonly property string primary950 : Colors.primary.primary50
            }

            readonly property var neutral : QtObject{
                readonly property string neutral0   : Colors.neutral.neutral950
                readonly property string neutral50  : Colors.neutral.neutral900
                readonly property string neutral100 : Colors.neutral.neutral800
                readonly property string neutral200 : Colors.neutral.neutral700
                readonly property string neutral300 : Colors.neutral.neutral600
                readonly property string neutral400 : Colors.neutral.neutral500
                readonly property string neutral500 : Colors.neutral.neutral400
                readonly property string neutral600 : Colors.neutral.neutral300
                readonly property string neutral700 : Colors.neutral.neutral200
                readonly property string neutral800 : Colors.neutral.neutral100
                readonly property string neutral900 : Colors.neutral.neutral50
                readonly property string neutral950 : Colors.neutral.neutral0
            }

            readonly property var green : QtObject{
                readonly property string green50  : Colors.green.green950
                readonly property string green100 : Colors.green.green800
                readonly property string green200 : Colors.green.green600
                readonly property string green500 : Colors.green.green500
                readonly property string green600 : Colors.green.green200
                readonly property string green700 : Colors.green.green100
                readonly property string green950 : Colors.green.green50
            }

            readonly property var red : QtObject{
                readonly property string red50  : Colors.red.red950
                readonly property string red100 : Colors.red.red800
                readonly property string red200 : Colors.red.red600
                readonly property string red500 : Colors.red.red500
                readonly property string red600 : Colors.red.red200
                readonly property string red700 : Colors.red.red100
                readonly property string red950 : Colors.red.red50
            }
        }
    }
    property var currentTheme: rootObject.themes.light

    readonly property var colors : QtObject{
        id: colorsObject
        readonly property var elementary : currentTheme.elementary
        readonly property var primary : currentTheme.primary
        readonly property var neutral : currentTheme.neutral
        readonly property var green : currentTheme.green
        readonly property var red : currentTheme.red
    }
}
