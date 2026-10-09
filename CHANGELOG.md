# Changelog

Registro de releases, hotfixes y demás cambios publicados. La versión más nueva va arriba. El proyecto usa [versionado semántico](https://semver.org/lang/es/).

Cada versión puede incluir:

- **Añadido** para funcionalidad nueva.
- **Cambiado** para un cambio de comportamiento en algo que ya existía.
- **Corregido** para un hotfix.
- **Eliminado** para algo que se quitó.
- **Seguridad** para un cambio que cierra un riesgo.

## [0.0.0] - 2026-10-08

Primera implementación del widget de escritorio.

### Añadido

- Widget de Digimon para Niri, como plugin de escritorio de DankMaterialShell. Queda detrás de las ventanas. El clic derecho lo mueve y la esquina inferior derecha cambia el tamaño de la caja. Con la grilla del escritorio activa, ese tamaño se ajusta a sus celdas.
- Dorumon, Gabumon y Terriermon incluidos en el plugin. Se elige cuál mostrar desde los ajustes.
- Tamaño común para los tres sprites. La escala va del 50 % al 150 %. Al 150 % el lado mide la mitad del GIF de Dorumon (200 px), es decir 100 px.
- Fondo transparente, del tema de DMS o de vidrio.
- Instalador de usuario, `./install.sh`, que enlaza el plugin en la configuración de DankMaterialShell. No pide administrador y no modifica la configuración de Niri. `./install.sh uninstall` quita ese enlace.
