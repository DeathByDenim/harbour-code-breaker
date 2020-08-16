import QtQuick 2.6
import QtQuick.LocalStorage 2.0
import Sailfish.Silica 1.0
import "../js/Constants.js" as Constants
import "../js/Game.js" as Game

Page {
    id: gamepage

    allowedOrientations: Orientation.PortraitMask

    ListModel {
        id: movesModel
        ListElement {
            color1: 0
            color2: 0
            color3: 0
            color4: 0
            answer1: 0
            answer2: 0
            answer3: 0
            answer4: 0
            current: true
        }
    }

    SilicaListView {
        id: listView

        PullDownMenu {
            MenuItem {
                text: qsTr("Statistics")
                onClicked: pageStack.push("Statistics.qml")
            }

            MenuItem {
                text: qsTr("New Game")
                onClicked: Game.newGame()
            }
        }

        PushUpMenu {
            MenuItem {
                enabled: true
                id: guessmenu
                text: qsTr("Guess")
                onClicked: Game.newGuess()
            }
        }

        header: PageHeader {
            title: qsTr("Code Breaker")
        }

        model: movesModel

        delegate: ColourLine {
            firstcolor: color1
            secondcolor: color2
            thirdcolor: color3
            fourthcolor: color4
            firstanswer: answer1
            secondanswer: answer2
            thirdanswer: answer3
            fourthanswer: answer4
            editable: current
        }

        anchors.fill: parent

        VerticalScrollDecorator {}

    }

    Component.onCompleted: function() {
        Game.newGame()
    }

    Label {
        anchors.centerIn: parent
        width: parent.width - 2*Theme.paddingMedium
        horizontalAlignment: Text.AlignHCenter
        id: wonLabel
        visible: false
        wrapMode: Text.Wrap
        font.pixelSize: Theme.fontSizeHuge
        color: Theme.primaryColor
        text: qsTr("You won!")
    }
}
