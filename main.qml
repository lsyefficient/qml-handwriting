import QtQuick 2.2

Item {
    id:root
    width:768
    height:263
    anchors.margins: 4

    Image { source: "asset/bg.png"; anchors.fill: parent; }

    // Drawing zone for Text recognition
    Writing {
        id:canvas
        width: Zinnia.drawing_width;
        height: Zinnia.drawing_height;
        x: 200
        y: 0
        // set the handwritingEngine in the writing zone
        engine: Zinnia
    }

    // Presenting the results on the right
    Flow {
        anchors.top: root.top;
        anchors.left: canvas.right
        anchors.right: root.right

        Repeater {
            model: Zinnia.results
            delegate: Item {
                id: delegateItem
                width: 99
                height: delegateText.height
                Rectangle{
                    id: delegateBackground
                    anchors.fill: parent;
                    color: "transparent"
                    opacity: .5
                }
                Text {
                    id: delegateText
                    width: parent.width
                    font.pointSize: 42
                    text: modelData
                    horizontalAlignment: Text.AlignHCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: delegateBackground.color = "black"
                    onReleased: delegateBackground.color = "transparent"
                    // Print the selected result
                    onClicked: console.log(modelData)
                }
            }
        }
    }

    Item {
        id:clearbutton
        width:100
        height:65

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 100

        MouseArea {
            anchors.fill:parent
            onClicked: canvas.clear();
        }
    }
}
