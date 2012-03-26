import QtQuick 1.1
import QtWebKit 1.0
import "content"
import "content/storage.js" as Storage

Rectangle {
    id: window
    width: 420; height: 480
    state: "feedView"

    property string currentFeed: "rss.news.yahoo.com/rss/topstories"
    property bool loading: feedModel.status == XmlListModel.Loading

    color: "#343434";
    Image { source: "content/images/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }


    SplashScreen {
        id: splashscreen
        anchors.fill: parent
        z: 1
        onSplashScreenCompleted: {
            splashscreen.visibility = false;
            Storage.initialize();
            if (Storage.getSetting("accept") != "yes")
            {
                console.log("agrenment not accepted");
                window.state = "acceptLic"
                toolBar.button1Label = "Accept"
                toolBar.z = 1
            }
            else window.state = 'feedView'
        }
    }

    Loading {
        z: 1
        anchors.centerIn: parent;
        visible: (feedModel.status==XmlListModel.Loading) ||  ( splashscreen.visibility)
    }

    XmlListModel {
        id: feedModel
        source: "http://" + window.currentFeed
        query: "/rss/channel/item"


        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "link"; query: "link/string()" }
        XmlRole { name: "description"; query: "description/string()" }
    }

    ScrollBar { scrollArea: list; height: list.height; width: 10; anchors.right: window.right }

    ListView {
        id: list
        width: window.width;
        height: window.height
        model: feedModel
        delegate: NewsDelegate {}
    }


    ToolBar {
        id: toolBar; height: 40;
        y: parent.height - 40
        width: parent.width; opacity: 0.9
        button1Label: "Settings"
        button2Label: "Quit"
        onButton2Clicked: Qt.quit()
        onButton1Clicked:  {
            console.log("window.state = " + window.state)
            if (window.state=='feedView')
            {
                window.state= 'changeSettings'
            }
            else if (window.state == 'changeSettings')
            {

                window.currentFeed = setview.address
                feedModel.reload();
                //toolBar.button1Label = 'Settings';
                window.state='feedView';

            }
            else if (window.state == 'acceptLic')
            {
                console.log('Setting the setting.')
                console.log(Storage.setSetting("accept","yes"))
                window.state = 'feedView';
                toolBar.button1Label = "Settings";
            }
        }
    }

    Rectangle {
        color: "#343434";
        Image { source: "content/images/stripes.png"; fillMode: Image.Tile; anchors.fill: parent; opacity: 0.3 }
        x: - (window.width - 1.5)
        height: window.height - (toolBar.height + 10)
        width: window.width
        state: "changeSettings"
        id: setRssView

        Rectangle{
            anchors.centerIn: parent
            border.width: 20
            SettingsView {
                id: setview
                inputFocus: true
                anchors.verticalCenter: parent.verticalCenter
            }

        }
    }

    Rectangle {
        color: "white";
        opacity: 0
        height: window.height - toolBar.height
        width: window.width
        state: "acceptLic"
        id: acceptLicView

        Rectangle{
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            focus: true

            Flickable{
                id: licFlick
                width: parent.width
                height: parent.height
                contentHeight: acceptView.contentsSize.height
                contentWidth: acceptView.contentsSize.width
                focus: true

                WebView {
                    id: acceptView
                    width: parent.width
                    height: parent.height
                    url: "file:./content/lic.txt"
                    settings.defaultFixedFontSize: 16
                    scale: 1
                }

            }

            Rectangle {
                id: scrollbar
                anchors.right: licFlick.right
                y: licFlick.visibleArea.yPosition * licFlick.height
                width: 5
                height: licFlick.visibleArea.heightRatio * licFlick.height
                color: "black"
                opacity: 0.3
            }

        }
    }

    states: [
        State {
            name: "changeSettings";
            PropertyChanges { target: setRssView; x: 0; clip: false; z: 1}
            PropertyChanges { target: setview ; inputFocus: true }
            PropertyChanges { target: list; x: +(parent.width * 1.5) }
            PropertyChanges { target: toolBar; button1Label: "Save" }
        },
        State {
            name: "acceptLic";
            PropertyChanges { target: acceptLicView; opacity: 1; focus: true }
            PropertyChanges { target: toolBar; button1Label: "Accept" }
        }
    ]
    transitions: [
        Transition {
            from: "feedView"; to: "changeSettings"; reversible: true;
            NumberAnimation { properties: "x"; duration: 500; easing.type: Easing.InOutQuad }
        },
        Transition {
            from: "feedView"
            to: "acceptLic"
            reversible: true
            NumberAnimation { properties: "y,opacity"; duration: 500; easing.type: Easing.InOutQuad }
        }
    ]
}


