import QtQuick 2.15
import QtQuick.Layouts

Item {
    property var headersModel : ["Код", "Дата создания", "Дата доставки", "Улица", "Статус", "Стоимость"]
    property bool iconVisible : true
    property bool enabled: true

    signal headerClicked(index : int)

    id: headersRoot
    width: 200
    height: 40

    RowLayout {
        id: columnsHeader
        anchors.fill: parent
        spacing: 0
        Repeater {
            Layout.fillWidth: true
            model: headersRoot.headersModel //> 0 ? tableHeaders : 1
            TableHeaderCell {
                Layout.fillWidth: true
                text: modelData
                iconVisible: headersRoot.iconVisible
                enabled: headersRoot.enabled
                onClicked: {
                    headersRoot.headerClicked(index)
                }
            }
        }
        TableHeaderCell {
            width: 60
            text: ""
            iconVisible: false
        }
    }
}
