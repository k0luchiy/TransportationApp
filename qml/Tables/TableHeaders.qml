import QtQuick 2.15
import QtQuick.Layouts

Item {
    property var headersModel : ["Код", "Дата создания", "Дата доставки", "Улица", "Статус", "Стоимость"]

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
            }
        }
        TableHeaderCell {
            width: 60
            text: ""
            iconVisible: false
        }
    }
}
