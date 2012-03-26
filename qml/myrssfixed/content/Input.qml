import QtQuick 1.0

FocusScope {
    id:container
    width: 320
    height: 28
    BorderImage { source: "images/lineedit.sci"; anchors.fill: parent }
    signal accepted
    property alias text: input.text
    property alias item:input
    TextInput{
        id: input
        width: parent.width - 10
        anchors.centerIn: parent
        font.pixelSize: 16;
        font.bold: true
        color: "#151515"; selectionColor: "mediumseagreen"
        focus: true
        onAccepted:{container.accepted()}
        text: ""
        selectByMouse: true
    }
}
