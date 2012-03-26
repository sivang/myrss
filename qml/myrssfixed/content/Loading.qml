import QtQuick 1.0

Image {
    id: loading; source: "images/loading.png"
    NumberAnimation on rotation {
        from: 0; to: 360; running: loading.visible == true; loops: Animation.Infinite; duration: 900
    }
}
