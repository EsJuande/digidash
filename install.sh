#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -eq 0 ]]; then
  echo "digidash: ejecutá el instalador como tu usuario, sin sudo." >&2
  exit 1
fi

if [[ -z "${HOME:-}" || ! -d "${HOME}" ]]; then
  echo "digidash: HOME no es un directorio." >&2
  exit 1
fi

config_home="${XDG_CONFIG_HOME:-${HOME}/.config}"
data_home="${XDG_DATA_HOME:-${HOME}/.local/share}"
if [[ "${config_home}" != /* || "${data_home}" != /* ]]; then
  echo "digidash: XDG_CONFIG_HOME y XDG_DATA_HOME tienen que ser rutas absolutas." >&2
  exit 1
fi

root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
plugin_source="${root}/digiDash"
plugins_dir="${config_home}/DankMaterialShell/plugins"
plugin_link="${plugins_dir}/digiDash"
legacy_binary="${HOME}/.local/bin/digidash"
legacy_desktop="${config_home}/autostart/digidash.desktop"

remove_legacy() {
  rm -f "${legacy_binary}" "${legacy_desktop}"
  if pgrep -x digidash >/dev/null 2>&1; then
    pkill -x digidash || true
  fi
}

uninstall() {
  if [[ -L "${plugin_link}" ]]; then
    local current expected
    current="$(readlink -f "${plugin_link}")"
    expected="$(readlink -f "${plugin_source}")"
    if [[ "${current}" == "${expected}" ]]; then
      rm -f "${plugin_link}"
    else
      echo "digidash: no quito ${plugin_link} porque apunta a otro plugin." >&2
    fi
  fi
  remove_legacy
  echo "digidash: se quitó el plugin."
}

install_widget() {
  if [[ ! -f "${plugin_source}/plugin.json" ]]; then
    echo "digidash: falta ${plugin_source}/plugin.json." >&2
    exit 1
  fi
  if [[ ! -d /usr/share/quickshell/dms && ! -d "${config_home}/DankMaterialShell" ]]; then
    echo "digidash: no está DankMaterialShell." >&2
    exit 1
  fi
  if [[ -e "${plugin_link}" && ! -L "${plugin_link}" ]]; then
    echo "digidash: ${plugin_link} ya existe y no es un enlace." >&2
    exit 1
  fi

  mkdir -p "${plugins_dir}"
  ln -sfn "${plugin_source}" "${plugin_link}"
  remove_legacy

  cat <<EOF
digidash quedó instalado como widget de DankMaterialShell.
Trae a Dorumon, Gabumon y Terriermon. Elegilos en los ajustes del widget.
Agregalo al escritorio desde los widgets de DMS.
El botón derecho mueve el widget. La esquina inferior derecha cambia el tamaño de la caja.
Con la grilla activa, G la enciende, Z y X cambian el paso.
La escala va del 50 % al 150 %. Al 150 % el sprite mide la mitad de Dorumon.
EOF
}

case "${1:-install}" in
  install) install_widget ;;
  uninstall) uninstall ;;
  *)
    echo "uso: install.sh [install|uninstall]" >&2
    exit 2
    ;;
esac
