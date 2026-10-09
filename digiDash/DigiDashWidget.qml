import QtQuick
import Qt.labs.folderlistmodel
import QtCore
import qs.Common
import qs.Modules.Plugins

DesktopPluginComponent {
    id: root

    minWidth: 64
    minHeight: 64

    property real spriteScale: (pluginData.spriteScale ?? 100) / 100
    property string backgroundStyle: pluginData.backgroundStyle ?? "transparent"
    property string selectedCritter: pluginData.selectedCritter ?? ""

    readonly property string spriteDirectory: StandardPaths.writableLocation(StandardPaths.GenericDataLocation) + "/digidash"

    readonly property color bgColor: {
        if (backgroundStyle === "dms")
            return Theme.surfaceContainer;
        if (backgroundStyle === "glass")
            return Qt.rgba(0, 0, 0, 0.15);
        return "transparent";
    }

    FolderListModel {
        id: rosterModel
        folder: Paths.toFileUrl(root.spriteDirectory)
        nameFilters: ["*.gif", "*.GIF"]
        showDirs: false
        showDotAndDotDot: false
        sortField: FolderListModel.Name
    }

    function spriteUrl(fileName) {
        for (let i = 0; i < rosterModel.count; ++i) {
            if (rosterModel.get(i, "fileName") === fileName)
                return Paths.toFileUrl(rosterModel.get(i, "filePath"));
        }
        return "";
    }

    readonly property string activeFile: root.spriteUrl(root.selectedCritter) !== "" ? root.selectedCritter : rosterModel.count > 0 ? rosterModel.get(0, "fileName") : ""
    readonly property string activeSpriteUrl: root.spriteUrl(root.activeFile)

    Rectangle {
        anchors.fill: parent
        radius: Theme.cornerRadius
        color: root.bgColor
        border.color: root.backgroundStyle === "glass" ? Qt.rgba(255, 255, 255, 0.1) : "transparent"
        border.width: root.backgroundStyle === "glass" ? 1 : 0
    }

    Item {
        anchors.fill: parent

        Item {
            id: critter
            anchors.centerIn: parent
            visible: root.activeSpriteUrl !== ""
            width: Math.max(gifView.implicitWidth, 1) * 2 * root.spriteScale
            height: Math.max(gifView.implicitHeight, 1) * 2 * root.spriteScale

            AnimatedImage {
                id: gifView
                anchors.fill: parent
                source: root.activeSpriteUrl
            }
        }

        Text {
            anchors.centerIn: parent
            width: parent.width - 16
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            visible: rosterModel.status === FolderListModel.Ready && root.activeFile === ""
            color: Theme.surfaceText
            font.pixelSize: Theme.fontSizeSmall
            text: "Copiá un GIF a " + root.spriteDirectory
        }
    }
}
