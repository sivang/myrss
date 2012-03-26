import QtQuick 1.0
import QtWebKit 1.0

Item {

    property alias murl: iView.url

WebView {
    id: iView
    width: 480
    height: 450
    settings.defaultFixedFontSize: 16
    scale: 1
}

}
