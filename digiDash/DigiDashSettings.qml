import QtQuick
import Qt.labs.folderlistmodel
import QtCore
import qs.Common
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "digiDash"

    readonly property string spriteDirectory: StandardPaths.writableLocation(StandardPaths.GenericDataLocation) + "/digidash"

    FolderListModel {
        id: rosterModel
        folder: Paths.toFileUrl(root.spriteDirectory)
        nameFilters: ["*.gif", "*.GIF"]
        showDirs: false
        showDotAndDotDot: false
        sortField: FolderListModel.Name
    }

    readonly property var rosterOptions: {
        const options = [];
        for (let i = 0; i < rosterModel.count; ++i) {
            const fileName = rosterModel.get(i, "fileName");
            options.push({
                label: rosterModel.get(i, "fileBaseName") || String(fileName).replace(/\.gif$/i, ""),
                value: fileName
            });
        }
        return options;
    }

    function keepSelectionValid() {
        const options = root.rosterOptions;
        if (!options.length)
            return;
        for (let i = 0; i < options.length; ++i) {
            if (options[i].value === critterSetting.value)
                return;
        }
        critterSetting.value = options[0].value;
    }

    Text {
        width: parent ? parent.width : implicitWidth
        visible: rosterModel.status === FolderListModel.Ready && root.rosterOptions.length === 0
        wrapMode: Text.WordWrap
        color: Theme.surfaceText
        font.pixelSize: Theme.fontSizeSmall
        text: "Copiá un GIF a " + root.spriteDirectory
    }

    SelectionSetting {
        id: critterSetting
        visible: root.rosterOptions.length > 0
        settingKey: "selectedCritter"
        label: "Digimon"
        options: root.rosterOptions
        defaultValue: root.rosterOptions.length > 0 ? root.rosterOptions[0].value : ""
    }

    Connections {
        target: rosterModel
        function onCountChanged() {
            root.keepSelectionValid();
        }
    }

    SelectionSetting {
        settingKey: "backgroundStyle"
        label: "Fondo"
        options: [
            { label: "Transparente", value: "transparent" },
            { label: "Tema de DMS", value: "dms" },
            { label: "Vidrio", value: "glass" }
        ]
        defaultValue: "transparent"
    }

    SliderSetting {
        settingKey: "spriteScale"
        label: "Escala del sprite"
        defaultValue: 100
        minimum: 50
        maximum: 250
        unit: "%"
    }
}
