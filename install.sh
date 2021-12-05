#!/usr/bin/env bash

# Instalador para los servicios incluidos en `kde-services-menu`

readonly SERVICEMENU_PATH="${HOME}/.local/share/kservices5/ServiceMenus/"
readonly HOME_LOCAL_BIN="${HOME}/.local/bin"
readonly BIN_FLAG=$(mktemp -t)

install_pdfshrink() {
    [ ! -d "$HOME_LOCAL_BIN" ] && echo 1 > "$BIN_FLAG"

    # Copia aunque no exista ruta objetivo y asigna permisos en modo 755
    install -D --target-directory="$HOME_LOCAL_BIN" ./bin/pdfshrink-plasma.sh
    install -D --target-directory="$SERVICEMENU_PATH" pdfShrink.desktop
}

install_libreoffice2pdf() {
    install -D --target-directory="$SERVICEMENU_PATH" libreOffice2pdf.desktop
}

OPCIONES=$(kdialog --separate-output --title "Instalador" \
            --checklist "Seleccionar una o más opciones:" \
            1 "  PDFShrink" on\
            2 "  LibreOffice2PDF" off)

case $? in
    0)  true
        ;;
    1)  exit
        ;;
    *)  kdialog --error "ERROR durante la selección."
        exit 1
        ;;
esac

while read -r; do
    [ -z "$REPLY" ] && {
        kdialog --sorry "No se ha seleccionado ninguna opción."
        exit; }

    case "$REPLY" in
        1)  install_pdfshrink
            ;;
        2)  install_libreoffice2pdf
            ;;
        *)  kdialog --error "Opción no válida."
            exit 1
    esac
done <<< "$OPCIONES"

if [ -s "$BIN_FLAG" ];then
    kdialog --title "Información" \
        --msgbox "Instalación finalizada correctamente.<br>\
        Es necesario reiniciar sesión para que sean efectivos los cambios."
else
    kdialog --msgbox "Instalación finalizada correctamente."
fi

