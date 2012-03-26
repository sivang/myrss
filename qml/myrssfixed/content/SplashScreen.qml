import QtQuick 1.0

Item {
    id: splashScreenContainer
    // image source is kept as an property
    property string imageSource: "images/myrss1.jpg"
    property bool visibility: true
    // signal emits when splashscreen animation completes
    signal splashScreenCompleted()
    Image {
        id: splashImage
        source: splashScreenContainer.imageSource
        anchors.fill: splashScreenContainer
        visible: parent.visibility
    }

    // simple QML animation to give a goof User Experience
    SequentialAnimation {
        id:splashanimation
        PauseAnimation { duration: 4200 }
        PropertyAnimation {
            target: splashImage
            duration: 500
            properties: "opacity"
            to:0
        }
        onCompleted: {
            splashScreenContainer.splashScreenCompleted()
        }
    }
    //starts the splashScreen
    Component.onCompleted: splashanimation.start()
}
