import QtQuick 2.12

import QtQuick.Shapes 1.14

import QtQuick.Timeline 1.0
import QtQuick.Controls 2.15

Item {
    id: item1
    width: 370
    height: 370
    property real  level: 50
    property real  level_smoth:level*10
    property int  temperature: 700
    property int temperature_smoth: temperature

    Behavior on level_smoth{
        SmoothedAnimation {
            velocity: 0.1
            duration: 1200
        }
    }
    Behavior on temperature_smoth{
        SmoothedAnimation {
            velocity: 0.1
            duration: 1200
        }
    }
    ArcItem {
        id: arc1
        anchors.centerIn: parent
        width: parent.width -40
        height: parent.height-40
        strokeColor: "#ff0000"
        gradient: LinearGradient {
            x2: 330
            y1: 0
            GradientStop {
                position: 0
                color: "#868f96"
            }

            GradientStop {
                position: 1
                color: "#596164"
            }
            y2: 330
            x1: 0
        }
        antialiasing: true
        capStyle: 32
        strokeWidth: 15
        end: -50
        begin: -160
        fillColor: "#00000000"

        Timeline {
            id: timeline1
            currentFrame: temperature_smoth
            startFrame: 0
            enabled: true
            endFrame: 1000

            KeyframeGroup {
                target: arc1
                property: "end"
                Keyframe {
                    value: -150
                    frame: 0
                }

                Keyframe {
                    value: -20
                    frame: 1000
                }

                Keyframe {
                    value: -130
                    frame: 500
                }

                Keyframe {
                    value: -50
                    frame: 700
                }
            }

            KeyframeGroup {
                target: rottation_item
                property: "rotation"
                Keyframe {
                    value: -15
                    frame: 0
                }

                Keyframe {
                    value: 120
                    frame: 1000
                }

                Keyframe {
                    value: 5
                    frame: 500
                }

                Keyframe {
                    value: 87
                    frame: 699
                }
            }

            KeyframeGroup {
                target: arc1
                property: "strokeColor"
                Keyframe {
                    value: "#ff0000"
                    frame: 500
                }

                Keyframe {
                    value: "#ffff0d"
                    frame: 515
                }

                Keyframe {
                    value: "#ffff0d"
                    frame: 692
                }

                Keyframe {
                    value: "#ff0000"
                    frame: 700
                }
            }
        }
    }


    ArcItem {
        id: gaugeLevel
        anchors.centerIn: parent
        width: parent.width-70
        height: parent.height-70
        gradient: LinearGradient {
            x2: 300
            y1: 0
            GradientStop {
                position: 0
                color: "#7085b6"
            }

            GradientStop {
                position: 0.5
                color: "#87a7d9"
            }

            GradientStop {
                position: 1
                color: "#def3f8"
            }
            y2: 300
            x1: 0
        }
        antialiasing: true
        strokeWidth: -1
        end: -359
        begin: -1

        Timeline {
            id: timeline
            currentFrame: level_smoth
            startFrame: 0
            enabled: true
            endFrame: 1000

            KeyframeGroup {
                target: gaugeLevel
                property: "begin"
                Keyframe {
                    value: -180
                    frame: 0
                }

                Keyframe {
                    value: -1
                    frame: 1000
                }
            }

            KeyframeGroup {
                target: gaugeLevel
                property: "end"
                Keyframe {
                    value: -180
                    frame: 0
                }

                Keyframe {
                    value: -359
                    frame: 1000
                }
            }
        }

        Text {
            id: text_level_disp
            text: level+"%"
            anchors.centerIn: parent
            opacity: 0.8
            anchors.fill: parent
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.italic: true
            font.family: "Verdana"
            font.bold: true
            styleColor: "#00000000"
        }




    }


    Image {
        id: image
        x: -24
        y: -5
        width: 418
        height: 381
        source: "glass3.png"
        fillMode: Image.PreserveAspectFit
    }

    Item {
        id: rottation_item
        x: 85
        y: 85
        width: 200
        height: 200
        rotation: 87

        Rectangle {
            id: temperature_disp
            x: -74
            y: 164
            rotation: -parent.rotation
            width: 80
            height: 37
            radius: 13
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#434343"
                }

                GradientStop {
                    position: 1
                    color: "#000000"
                }
            }

            Text {
                id: text_temperature_disp
                color: "#74cf75"

                text: temperature+ qsTr(" °C")
                anchors.fill: parent
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                styleColor: "#00000000"
                font.bold: true
            }
        }
    }


}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66}D{i:5}D{i:1}D{i:36}D{i:35}
}
##^##*/
