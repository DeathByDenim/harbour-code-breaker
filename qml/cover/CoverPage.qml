import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    Label {
        anchors.centerIn: parent
        width: parent.width - 2 * Theme.horizontalPageMargin
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("Code Breaker")
        wrapMode: Text.Wrap
        font.pixelSize: Theme.fontSizeLarge
    }
}
