import QtQuick 2.6
import QtQuick.LocalStorage 2.0
import Sailfish.Silica 1.0
import "../js/Stats.js" as Stats

Page {
    id: statisticspage
    allowedOrientations: Orientation.PortraitMask

    onVisibleChanged: {
        if(visible) {
            graphcanvas.requestPaint()
        }
    }

    property int numplayed: 0

    PageHeader {
        id: statpageheader
        title: qsTr("Statistics")
//            leftMargin: Theme.horizontalPageMargin
//            rightMargin: Theme.horizontalPageMargin
    }

    Column {
        spacing: Theme.paddingLarge
        leftPadding: Theme.horizontalPageMargin
        rightPadding: Theme.horizontalPageMargin
        anchors.top: statpageheader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Label {
            height: Theme.iconSizeExtraLarge
            width: parent - 2 * Theme.horizontalPageMargin
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Games played: ") + numplayed
        }

        Canvas {
            id: graphcanvas
            width: parent.width - 2*Theme.horizontalPageMargin
            height: parent.width - 2*Theme.horizontalPageMargin
            onPaint: {
                var stats = Stats.load()

                var graphwidth = width - 2*Theme.paddingSmall
                var graphheight = height - 2*Theme.fontSizeExtraSmall

                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)

                // Draw the base line
                ctx.strokeStyle = Theme.primaryColor
                ctx.fillStyle = Theme.highlightColor
                ctx.lineWidth = 3
                ctx.beginPath()
                ctx.moveTo(0, graphheight)
                ctx.lineTo(width, graphheight)
                ctx.stroke();

                // x is number of turns needed, y is number of wins
                var minx = 999999
                var maxx = 0
                var maxy = 0
                for(var i = 0; i < stats.length; i++) {
                    if(stats[i].x > maxx) {
                        maxx = stats[i].x
                    }
                    if(stats[i].x < minx) {
                        minx = stats[i].x
                    }
                    if(stats[i].y > maxy) {
                        maxy = stats[i].y
                    }
                }

                if(maxy == 0) {
                    return
                }

                var nbars = maxx-minx+1 // Number of bars
                var barspacing = Theme.paddingSmall // Spacing between bars
                var barwidth = graphwidth / nbars - (nbars-1)/nbars * barspacing

                // Draw the labels
                ctx.fillStyle = Theme.primaryColor
                for(var i = 0; i < nbars; i++) {
                    ctx.font = Theme.fontSizeExtraSmall + "pt '" + Theme.fontFamily + "'"
                    ctx.textAlign = "center"
                    ctx.fillText(
                        i + minx, // this is the label text
                        Theme.paddingSmall + i*(barwidth + barspacing) + barwidth/2,
                        height-2
                    )
                }

                //Draw the bars
                ctx.fillStyle = Theme.highlightColor
                for(var i = 0; i < stats.length; i++) {
                    ctx.fillRect(
                        Theme.paddingSmall + (stats[i].x - minx)*(barwidth + barspacing),
                        graphheight - graphheight * stats[i].y / maxy,
                        barwidth,
                        graphheight * stats[i].y / maxy - Theme.paddingSmall
                    )
                }
            }
        }

        Item {
            width: parent.width - 2*Theme.horizontalPageMargin
            height: Theme.iconSizeExtraLarge

            Button {
                text: qsTr("Reset")
                anchors.centerIn: parent
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("ResetStatsDialog.qml"))
                    dialog.accepted.connect(function() {
                        Stats.reset()
                        numplayed = 0
                        graphcanvas.requestPaint()
                    })
                }
            }
        }
    }

    Component.onCompleted: {
        var stats = Stats.load()
        numplayed = 0;
        for(var i = 0; i < stats.length; i++) {
            numplayed += stats[i].y
        }
    }
}
