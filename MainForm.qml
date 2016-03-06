import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Extras 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.3
import Qt.labs.folderlistmodel 2.1
import Qt.labs.settings 1.0

Rectangle {
    id: baseRectangle
    
    color: "#37a2f6"
    radius: 0
    property alias mediaListView: mediaListView
    property alias mediaListRectangle: mediaListRectangle
    property alias bottomBarRectangle: bottomBarRectangle
    property alias stopMouseArea: stopMouseArea
    property alias stopImage: stopImage
    property alias playProgressSlider: playProgressSlider
    property alias playlistmouseArea: playlistmouseArea
    property alias playlistImage: playlistImage
    property alias playMouseArea: playMouseArea
    property alias playImage: playImage
    
    property bool isPlaying: false
    property bool isListExpanded: false
    property int listHeight: 0
    border.color: "#00000000"
    opacity: 1
    
    
    Rectangle {
        id: bottomBarRectangle
        height: 56
        color: "#4e4ef1"
        z: 5
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        border.color: "#00000000"
        
        Image {
            id: playImage
            y: 810
            width: 50
            height: 50
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            z: 1
            fillMode: Image.PreserveAspectFit
            source: "images/play-button.svg"
            property alias fadeAnimation: fadeAnimation
            
            
            SequentialAnimation{
                id: fadeAnimation
                PropertyAnimation{
                    id: fadeOutAnimation
                    target: playImage
                    property: "opacity"
                    to:0
                    duration: 250
                    
                }
                ScriptAction{
                    script: {
                        if(!isPlaying){
                            playImage.source= "images/pause-button.svg"
                            isPlaying=true
                        }else{
                            playImage.source="images/play-button.svg"
                            isPlaying=false
                        }
                    }
                }
                
                PropertyAnimation{
                    id: fadeInAnimation
                    target: playImage
                    property: "opacity"
                    to:1
                    duration: 250
                }
            }
            
            
            
            
            MouseArea {
                id: playMouseArea
                z: 1
                anchors.fill: parent
                onClicked: {
                    playImage.fadeAnimation.start()
                }
            }
        }
        
        Image {
            id: playlistImage
            x: 1
            y: 815
            width: 50
            height: 50
            anchors.right: parent.right
            anchors.rightMargin: 0
            z: 1
            anchors.bottomMargin: 0
            MouseArea {
                id: playlistmouseArea
                anchors.fill: parent
                z: 1
                property int tempListHeight:0;

                onClicked: {
                    if(!isListExpanded){
                        listHeight=mediaListRectangle.parent.height-bottomBarRectangle.height
                        mediaListRectangle.mediaListAnimation.start()
                        isListExpanded=true

                    }else{
                        listHeight=0
                        mediaListRectangle.mediaListAnimation.start()
                        isListExpanded=false
                    }
                }


            }
            fillMode: Image.PreserveAspectFit
            anchors.bottom: parent.bottom
            source: "images/playlist.svg"
        }
        
        Slider {
            id: playProgressSlider
            x: 56
            y: 12
            maximumValue: 100
            anchors.rightMargin: 6
            anchors.left: stopImage.right
            anchors.right: playlistImage.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.leftMargin: 6
            anchors.bottomMargin: 6
            anchors.topMargin: 6
            z: 1
        }
        
        Image {
            id: stopImage
            x: 3
            y: 816
            width: 50
            height: 50
            z: 1
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            MouseArea {
                id: stopMouseArea
                z: 1
                anchors.fill: parent
                onClicked: {
                    if(isPlaying){
                        playImage.fadeAnimation.start()
                        playProgressSlider.value=0;
                        
                    }
                }
            }
            fillMode: Image.PreserveAspectFit
            anchors.left: playImage.right
            anchors.bottom: parent.bottom
            source: "images/stop-button.svg"
        }
    }
    
    Rectangle {
        id: mediaListRectangle
        y: 0
        height: 0
        color: "#000000"
        anchors.bottom: bottomBarRectangle.top
        anchors.bottomMargin: 0
        visible: true
        opacity: 0.7

        z: 4
        border.color: "#00000000"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        
        property alias mediaListAnimation: mediaListAnimation
        NumberAnimation on height{
            id:mediaListAnimation
            duration:500
            to:listHeight
        }




        ListView {
            id: mediaListView
            anchors.top: searchTextField.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            visible: true
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10

            delegate: Item {
                x: 5
                width: 80
                height: 40
                Row {
                    id: row1
                    spacing: 10
                    Rectangle {
                        width: 40
                        height: 40
                        color: colorCode
                    }
                    
                    Text {
                        text: name
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                }
            }
            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }
                
                ListElement {
                    name: "Red"
                    colorCode: "red"
                }
                
                ListElement {
                    name: "Blue"
                    colorCode: "blue"
                }
                
                ListElement {
                    name: "Green"
                    colorCode: "green"
                }
            }
        }

        TextField {
            id: searchTextField
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.top: parent.top
            anchors.topMargin: 25
            anchors.right: parent.right
            anchors.rightMargin: 25
            placeholderText: qsTr("Search here")
        }
    }
    
}
