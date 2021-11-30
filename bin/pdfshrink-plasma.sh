#!/usr/bin/env bash

# Script para Dolphin Service Menu
# Reduce el tamaño de los PDF seleccionados.

[ ! $(which gs) ] && {
    kdialog \
    --title "ATENCIÓN" \
    --error "El programa ghostscript no se encuentra instalado!"; \
    exit 1; }

# Main 

OPTION="$1"
FILE="$2"
PATH_FILE="${FILE%/*}"
TITLE="${FILE##*/}"

# Calcula el porcentaje de diferencia entre archivos
dialog_message() {
    local diference
    local size_file
    local size_title_mod

    size_file=$(du "$FILE" | cut -f1)
    size_title_mod=$(du "${PATH_FILE}/${TITLE:: -4}_mod.pdf" | cut -f1)
    diference=$(bc <<< "scale=2; (($size_file - $size_title_mod) / $size_file) * 100")

    kdialog --msgbox "Nuevo archivo ${TITLE:: -4}_mod.pdf reducido ${diference%.00}%"
}

case "$OPTION" in
    ebook)
        ps2pdf -dPDFSETTINGS=/ebook "$FILE" "${PATH_FILE}/${TITLE:: -4}_mod.pdf"
        dialog_message
        ;;
    screen)
        ps2pdf -dPDFSETTINGS=/screen "$FILE" "${PATH_FILE}/${TITLE:: -4}_mod.pdf"
        dialog_message
        ;;
    high)
        gs -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
            -dPDFSETTINGS=/screen  -sDEVICE=pdfwrite \
            -sOutputFile="${PATH_FILE}/${TITLE:: -4}_mod.pdf" "$FILE"
        dialog_message
        ;;
    \*)
        exit 1
esac
