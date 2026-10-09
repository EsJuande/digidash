import QtQuick
import qs.Modules.Plugins
import "DigiDashRoster.js" as RosterGen

PluginSettings {
    id: root
    pluginId: "digiDash"

    SelectionSetting {
        settingKey: "selectedCritter"
        label: "Digimon"
        options: RosterGen.DigiDashRoster.rosterOptions()
        defaultValue: "Dorumon"
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
        description: "Al 150 % el sprite mide la mitad de Dorumon. Los tres usan ese tamaño."
        defaultValue: 100
        minimum: 50
        maximum: 150
        unit: "%"
    }
}
