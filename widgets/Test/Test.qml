import Quickshell
import QtQuick
import QtQuick.Shapes

PanelWindow {
    anchors.right: true
    width: 50
    exclusiveZone: 0
    
    // Add an Item to contain everything
    Item {
        id: wrapper
        anchors.fill: parent
        
        // Squircle background
        Shape {
            id: shapeElement
            anchors.fill: parent
            preferredRendererType: Shape.CurveRenderer
            
            transform: Scale {
                id: shapeScale
                origin.x: 0
                origin.y: 0
                xScale: 1  // Changed from 0 to 1 to make it visible
            }
            
            ShapePath {
                fillColor: "lightgray"  // Replace with Colors.surfaceContainer if available
                strokeWidth: 0
                startX: 0
                startY: 0
                
                PathArc {
                    relativeX: 20  // Replace with Dimensions.position.x
                    relativeY: 20  // Replace with Dimensions.position.x
                    radiusX: 10    // Replace with Dimensions.radius.large
                    radiusY: 10    // Replace with Dimensions.radius.large
                    direction: PathArc.Counterclockwise
                }
                PathLine {
                    relativeY: wrapper.height
                    relativeX: 0
                }
                PathArc {
                    relativeX: -20  // Replace with -Dimensions.position.x
                    relativeY: 20   // Replace with Dimensions.position.x
                    radiusX: 10     // Replace with Dimensions.radius.large
                    radiusY: 10     // Replace with Dimensions.radius.large
                    direction: PathArc.Counterclockwise
                }
            }
        }
        
        // Your text on top of the background
        Text {
            text: "Hello"
            anchors.centerIn: parent
        }
    }
}