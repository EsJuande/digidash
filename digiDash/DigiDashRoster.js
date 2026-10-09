var DigiDashRoster = {
    referenceEdge: 200,
    maximumPortion: 0.5,
    maximumScale: 150,

    defaultRoster: [
        { name: "Dorumon", file: "sprites/dorumon.gif" },
        { name: "Gabumon", file: "sprites/gabumon.gif" },
        { name: "Terriermon", file: "sprites/terriermon.gif" }
    ],

    getByName: function(name) {
        for (var i = 0; i < this.defaultRoster.length; i++) {
            if (this.defaultRoster[i].name === name)
                return this.defaultRoster[i];
        }
        return this.defaultRoster[0];
    },

    rosterOptions: function() {
        return this.defaultRoster.map(function(entry) {
            return { label: entry.name, value: entry.name };
        });
    },

    displayEdge: function(scalePercent) {
        var scale = Number(scalePercent);
        if (!isFinite(scale))
            scale = 100;
        scale = Math.max(50, Math.min(this.maximumScale, scale));
        return this.referenceEdge * this.maximumPortion * (scale / this.maximumScale);
    }
};
