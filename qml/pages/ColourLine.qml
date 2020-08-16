import QtQuick 2.6
import Sailfish.Silica 1.0

import "../js/Constants.js" as Constants

ListItem {
    property int firstcolor: 0
    property int secondcolor: 0
    property int thirdcolor: 0
    property int fourthcolor: 0
    property int firstanswer: 0
    property int secondanswer: 0
    property int thirdanswer: 0
    property int fourthanswer: 0
    property int correctplac: 0
    property int correctcolo: 0
    property bool editable: true

    contentHeight: Theme.itemSizeMedium
    anchors.leftMargin: Theme.horizontalPageMargin
    anchors.rightMargin: Theme.horizontalPageMargin
    enabled: false
    id: thislistitem

    Column {
        Row {
            x: Theme.horizontalPageMargin
            spacing: Theme.paddingMedium

            Repeater {
                id: dots
                model: [firstcolor, secondcolor, thirdcolor, fourthcolor]

                GlassItem {
                    width: Theme.iconSizeLarge
                    height: Theme.iconSizeLarge
                    color: Constants.colors[modelData]
                    falloffRadius: modelData == 0 ? 0.1 : 0.25
                    radius: 1
                    cache: true

                    MouseArea {
                        anchors.fill: parent
                        onClicked: function() {
                            if(!editable)
                                return;

                            var last = movesModel.get(movesModel.count - 1)

                            switch(index) {
                            case 0:
                                last.color1 = firstcolor >= Constants.colors.length - 1 ? 1 : firstcolor + 1
                                break;
                            case 1:
                                last.color2 = secondcolor >= Constants.colors.length - 1 ? 1 : secondcolor + 1
                                break;
                            case 2:
                                last.color3 = thirdcolor >= Constants.colors.length - 1 ? 1 : thirdcolor + 1
                                break;
                            case 3:
                                last.color4 = fourthcolor >= Constants.colors.length - 1 ? 1 : fourthcolor + 1
                                break;
                            }
                        }
                        onPressAndHold: function() {
                            if(editable) {
                                colmenu.appliesto = index
                                thislistitem.showMenu()
                            }
                        }
                    }
                }
            }

            ListModel {
                id: hintModel
            }

            Grid {
                anchors.verticalCenter: parent.verticalCenter
                columns: 2
                spacing: Theme.iconSizeExtraSmall/4
                verticalItemAlignment: Grid.AlignVCenter
                Repeater {
                    model: [firstanswer, secondanswer, thirdanswer, fourthanswer]
                    Rectangle {
                        visible: modelData != 0
                        color: modelData == 1 ? "black" : "white"
                        radius: Theme.iconSizeExtraSmall/2
                        width: Theme.iconSizeExtraSmall
                        height: Theme.iconSizeExtraSmall
                        border.width: 1
                        border.color: "gray"
                    }
                }

            }
        }
    }

    menu: ContextMenu {
        property int appliesto: -1
        id: colmenu

        Row {

//            anchors.centerIn: parent
            spacing: Theme.paddingMedium
            leftPadding: Theme.paddingLarge
            topPadding: Theme.paddingMedium
            bottomPadding: Theme.paddingMedium
            Repeater {
                model: Constants.colors.slice(1,Constants.colors.length)

                Rectangle {
                    width: Theme.iconSizeMedium
                    height: Theme.iconSizeMedium
                    color: modelData

                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                        onClicked: function() {
                            var last = movesModel.get(movesModel.count - 1)

                            switch(colmenu.appliesto) {
                            case 0:
                                last.color1 = index+1
                                break;
                            case 1:
                                last.color2 = index+1
                                break;
                            case 2:
                                last.color3 = index+1
                                break;
                            case 3:
                                last.color4 = index+1
                                break;
                            }

                            colmenu.appliesto = -1
                            thislistitem.hideMenu()
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: function() {
        colmenu.appliesto = -1

        hintModel.clear()
        for(var i = 0; i < correctcolo; i++)
            hintModel.append({modelData: 2})
        for(var i = 0; i < correctplac; i++)
            hintModel.append({modelData: 1})
        for(var i = 0; i < 4 - correctcolo - correctplac; i++)
            hintModel.append({modelData: 0})
    }
}
