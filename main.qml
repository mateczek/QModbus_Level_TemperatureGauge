import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("QModbus Temperature Level Gauge")
    property int temperature1: 500
    property int level1: 50
    Image {
        id: tlo
        anchors.fill: parent
        source: "background2.jpg"
    }
    Gauge{
        anchors.centerIn: parent
        temperature: temperature1
        level: level1
    }

}
