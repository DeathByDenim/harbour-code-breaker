import QtQuick 2.6
import Sailfish.Silica 1.0

Dialog {
    DialogHeader { }

    Label {
        wrapMode: Text.Wrap
        font.pixelSize: Theme.fontSizeLarge
        text: qsTr("This will delete all statistics. Are you sure?")
        anchors {
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
            verticalCenter: parent.verticalCenter
        }
    }
}
