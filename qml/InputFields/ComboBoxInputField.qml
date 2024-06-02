import QtQuick 2.15
import QtQuick.Layouts

import Colors
import Buttons

Item {
    property color titleColor : Themes.colors.neutral.neutral700
    property color contentColor : Themes.colors.neutral.neutral700
    property color bgColor : Colors.elementary.transparent
    property color borderColor :
        fieldRoot.enabled ? Themes.colors.neutral.neutral100 :
            Themes.colors.neutral.neutral300
    property string title : qsTr("Title:")
    property bool titleVisible : true
    property bool enabled : true
    property int titleFontSize : 12
    property int contentFontSize : 12

    property alias currentText: comboBox.currentText
    property alias currentIndex: comboBox.currentIndex
    property alias currentValue: comboBox.currentValue
    property alias textRole: comboBox.textRole
    property alias model : comboBox.model

    //property alias readOnly : inputField.readOnly
    //signal currentIndexChanged(int index)

    id: fieldRoot
    width: 280
    height: fieldRoot.titleVisible ? 45 + 20 : 45

    ColumnLayout{
        anchors.fill: fieldRoot
        RowLayout{
            Layout.preferredHeight: 20
            Layout.fillWidth: true
            visible : fieldRoot.titleVisible
            Text{
                text : fieldRoot.title
                verticalAlignment: Text.AlignVCenter
                font.pointSize : fieldRoot.titleFontSize
                color: fieldRoot.titleColor
            }
        }

        ComboBoxControl{
            id : comboBox
            enabled: fieldRoot.enabled
            Layout.fillHeight: true
            Layout.fillWidth: true
            selectedColor: Themes.colors.neutral.neutral100
            contentColor: fieldRoot.contentColor
            borderColor : fieldRoot.borderColor
            fontSize : fieldRoot.titleFontSize
            itemHeight : 30
            itemCount : 3
        }
    }
}
