# kde-services-menu

Diversos Service Menus para KDE Plasma5

## Instalación

### Instalador

- Doble click sobre el archivo `install.sh` y seleccionar la opción **ejecutar**.
- Seleccionar las opciones deseadas para instalar y **aceptar**.

### Instalación manual

Desde el directorio descargado `kde-services-menu`, abrir un terminal en Dolphin (Tecla `F4`).

- Copia los archivos `*.desktop` a `~/.local/share/kservices5/ServiceMenus/` (crea el directorio si no existe).

  ~~~sh
  mkdir -pv "${HOME}/.local/share/kservices5/ServiceMenus/" && cp -v *.desktop "$_"
  ~~~

- Crea el directorio `~/.local/bin/` y copia el contenido de `bin/` a `${HOME}/.local/bin/`.

  ~~~sh
  mkdir -pv "${HOME}/.local/bin/" && cp -v bin/*.sh "$_"
  ~~~

> **ATENCION**: La primera vez que se cree el directorio `~/.local/bin/` deberá cerrar sesión e iniciar de nuevo para hacer efectivos los cambios.

## Servicios

### PDF Shrink

Reduce el tamaño de los archivos PDF seleccionados.

- 3 niveles de compresión:

  - **Normal**: Mejor relación entre calidad y reducción de tamaño.
  - **Medio**: Sacrifica algo de calidad para reducir más el tamaño.
  - **Alto**: Visible reducción de la calidad reduciendo al máximo el tamaño.

### LibreOffice2PDF

Convierte a PDF archivos _odt, ods, odg_ y _odp_.
