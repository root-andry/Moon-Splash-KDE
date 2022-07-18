import QtQuick 2.5
import QtGraphicalEffects 1.0

Image {

// Background Image
    id: root
    source: "images/background.png"
    fillMode: Image.PreserveAspectCrop
    
    property int stage

// Delay Animation Opacity
    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
            preOpacityAnimation.from = 0;
            preOpacityAnimation.to = 0.85;
            preOpacityAnimation.running = true;
        }
        if (stage == 4) {
            preOpacityAnimation.from = 0.85;
            preOpacityAnimation.to = 0;
            preOpacityAnimation.running = true;
            stop.start();
        }
    }

// Image Moon in Center
    Item {
        id: content
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        opacity: 1
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: logo
            anchors.centerIn: parent
            source: "images/moon.svg"
            width: size
            sourceSize.height: size
        }
    }

// Date and Time
        Text {
            id: date
            text:Qt.formatDateTime(new Date(),"dddd, hh:mm")
            font.pointSize: 32
            color: "#ffffff"
            opacity:0.85
            font { family: "OpenSans Light"; weight: Font.Light ;capitalization: Font.Capitalize}
            anchors.horizontalCenter: parent.horizontalCenter
            y: (parent.height - height) / 1.6
        }

// Loading bar animation
        Rectangle {
            radius: 3
            color: "#1d212f"
            height : 3
            width: height*70
            anchors {
                bottom: parent.bottom
                bottomMargin:200
                horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                radius: 3
                color: "#d3dae3"
                width: (parent.width / 6) * (stage - 0.00)
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }

                Behavior on width {
                    PropertyAnimation {
                        duration: 2000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
        
// Set Animation Global
    SequentialAnimation {
        id: introAnimation
        running: false


    }

// Animation Text
    Text {
        id: preLoadingText
        height: 30
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        text: "Everyone is a moon"
        color: "#ffffff"
        font.family: webFont.name
        font.weight: Font.ExtraLight

        font.pointSize: 20
        opacity: 0
        textFormat: Text.StyledText
        x: (root.width - width) / 2
        y: (root.height / 3) * 2
    }
    
    OpacityAnimator {
        id: preOpacityAnimation
        running: false
        target: preLoadingText
        from: 0
        to: 1
        duration: 700
        easing.type: Easing.InOutQuad
    }
    
    Text {
        id: loadingText
        height: 30
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        text: "And has a dark side which he never shows to anybody."
        color: "#ffffff"
        font.family: webFont.name
        font.weight: Font.ExtraLight

        font.pointSize: 20
        opacity: 0
        textFormat: Text.StyledText
        x: (root.width - width) / 2
        y: (root.height / 3) * 2
    }

    OpacityAnimator {
        id: opacityAnimation
        running: false
        target: loadingText
        from: 0
        to: 1
        duration: 1500
        easing.type: Easing.InOutQuad
        paused: true
    }

    Timer {
        id: stop
        interval: 1500; running: false; repeat: false;
        onTriggered: root.viewLoadingText();
    }

    function viewLoadingText() {
        opacityAnimation.from = 0;
        opacityAnimation.to = 1;
        opacityAnimation.running = true;
    }

}
