import QtQuick
import qs.Common
import qs.Modules.Plugins
import "DigiDashRoster.js" as RosterGen

DesktopPluginComponent {
    id: root

    minWidth: 64
    minHeight: 64

    property real spriteScale: pluginData.spriteScale ?? 100
    property string backgroundStyle: pluginData.backgroundStyle ?? "transparent"
    property string selectedCritter: pluginData.selectedCritter ?? "Dorumon"

    readonly property var activeCritter: RosterGen.DigiDashRoster.getByName(root.selectedCritter)
    readonly property real displayEdge: RosterGen.DigiDashRoster.displayEdge(root.spriteScale)

    readonly property color bgColor: {
        if (backgroundStyle === "dms")
            return Theme.surfaceContainer;
        if (backgroundStyle === "glass")
            return Qt.rgba(0, 0, 0, 0.15);
        return "transparent";
    }

    Rectangle {
        anchors.fill: parent
        radius: Theme.cornerRadius
        color: root.bgColor
        border.color: root.backgroundStyle === "glass" ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
        border.width: root.backgroundStyle === "glass" ? 1 : 0
    }

    Item {
        anchors.fill: parent

        AnimatedImage {
            anchors.centerIn: parent
            width: root.displayEdge
            height: root.displayEdge
            source: Qt.resolvedUrl(root.activeCritter.file)
            fillMode: Image.PreserveAspectFit
            smooth: false
        }
    }
}
