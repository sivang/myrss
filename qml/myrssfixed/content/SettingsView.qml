import QtQuick 1.0
Item {
    property alias inputFocus: uri.focus
    property alias address: uri.text
    Column {
        Text {
            id:title
            text: "MyRSS! Settings"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 20; font.bold: true; color: "white"; style: Text.Raised; styleColor: "black"
        }
        anchors.centerIn: parent
        spacing: 30
        Column{
            spacing: 4
            Text {
                text: "RSS url:"
                font.pixelSize: 16; font.bold: true; color: "white"; style: Text.Raised; styleColor: "black"
                horizontalAlignment: Qt.AlignRight

            }
            Input{
                id: uri
//                onAccepted: {
//                    window.currentFeed = "http://" + uri.text;
//                    feedModel.reload();
//                }
                text: window.currentFeed
            }


        }

    }

}


