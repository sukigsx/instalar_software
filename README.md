---------
# Instalacion_software
* Script desarrollado en bash
*********************************************
* Diseñado por SUKIGSX
* Contacto: sukigsx.mbsistemas@gmail.com
*********************************************

Este script esta pensado para la instalacion de software de forma automatizada.

- Actualizar el sistema en entornos gnome y plasma por apt.
- Poder instalar otras maquinas de forma remota por ssh.
- Instalacion de repositorios.
- Instalacion de una gran cantidad de software incluida en repositorios.
- Instalacion software externo a los repositorios de forma automatica.
- Buscar equipos por tu red, para poder instalar en remoto.
- Conectar a equipo de red por ssh.
- Ejecuta una terminal de comandos.
- Instalacion en equipos remotos.

El script consta de tres ficheros que son: software_inicio.sh, instalar_software_repositorios.sh y instalar_software_externo.sh. que paso a explicar cada uno de ellos.

##instalar_inicio.sh
Este script de Bash realiza varias tareas relacionadas con la gestión del sistema y la instalación de software en sistemas Linux. A continuación, se describe el funcionamiento del script:

- Definición de colores: Se definen variables que contienen códigos de color ANSI para su uso en la terminal.

- Verificación de conexión: El script verifica si hay conexión a Internet haciendo ping a google.com. Dependiendo del resultado, se establece la variable conexion a "si" o "no".

- Verificación de software necesario: El script verifica la presencia de varios paquetes necesarios en el sistema. Si alguno de ellos falta, intenta instalarlo usando sudo apt install.

- Actualización del script desde GitHub: El script comprueba si hay una versión más reciente en un repositorio de GitHub. Si hay una actualización, el script se actualiza automáticamente.

- Menú principal: Muestra un menú interactivo con opciones numeradas que incluyen la actualización del sistema, la instalación de software, la búsqueda de dispositivos en la red, la conexión SSH a otros   dispositivos, entre otras opciones.

- Funciones auxiliares: El script incluye una función ayuda que muestra información sobre las opciones del menú y una función ctrl_c que se activa cuando se presiona Ctrl + C, mostrando un mensaje de despedida y cerrando la terminal.

- Bucle principal: El script entra en un bucle infinito (while :) que muestra el menú y espera la entrada del usuario para ejecutar las opciones seleccionadas.

Algunos aspectos notables del script:

- Control de versiones: Permite actualizar el script automáticamente desde GitHub.
- Interacción con el usuario: Proporciona un menú interactivo con descripciones claras de las opciones disponibles.
- Gestión de conexiones de red: Permite buscar dispositivos en la red y conectarse a ellos mediante SSH.
- Manejo de errores: Notifica al usuario si no hay conexión a Internet o si no se pueden instalar ciertos paquetes.

## instalar_software_externo.sh
Este script en bash es un programa de instalación que permite al usuario seleccionar y descargar varios programas externos. Aquí hay una descripción del funcionamiento del script:

### Primera parte del script:

- La primera parte del script muestra un menú para seleccionar un navegador web (Google Chrome, Firefox o Chromium).
- Si elige actualizar el script (opción 0), el script se compara con una versión en un repositorio de GitHub. Si hay una actualización, se descarga y reemplaza el script actual.
- Si selecciona un navegador que no está instalado, el script intenta instalarlo.
- Si selecciona salir (opción 99), el script se cierra.

### La segunda parte:

- Muestra un menú con varias opciones para descargar software externo.
- Puedes seleccionar diferentes opciones para descargar software como VirtualBox, Franz, TeamViewer, etc.
- También puedes ver la lista de software descargado (opción 70), borrar los archivos descargados (opción 80) e instalar el software descargado (opción 90).
- Si seleccionas salir (opción 99), el script se cierra.

## instalar_software_repositorios.sh

Este script en Bash es un programa de instalación automatizada para software en sistemas Linux. Te proporcionaré una descripción paso a paso para entender mejor el funcionamiento del script:


- Comprobación de software necesario: El script verifica la presencia de varios programas (wmctrl, figlet, diff, curl, git, xdotool, nmap, ssh, ping, which) que son esenciales para su funcionamiento. Si alguno de estos programas no está instalado, el script intenta instalarlo automáticamente utilizando el comando apt install. Si después de 3 intentos no puede instalar un programa o si no hay conexión a Internet, el script muestra un mensaje de error y termina.

- Comprobación de la conexión a Internet: El script verifica si hay una conexión a Internet usando el comando ping. Si la conexión está disponible, la variable conexion se establece en "si"; de lo contrario, se establece en "no".

- Comprobación de actualizaciones del script: El script compara su versión local con la versión en un repositorio de GitHub. Si hay una diferencia, el usuario tiene la opción de actualizar el script automáticamente.

- Menú de selección de software: Después de todas las comprobaciones, se muestra un menú interactivo que enumera varios programas y herramientas. El usuario puede seleccionar un número para elegir el software que desea instalar o realizar otras acciones, como actualizar el script, listar el software seleccionado para instalar, borrar la lista de software seleccionado o instalar el software seleccionado.

- Actualización automática del script: Si el usuario elige actualizar el script, el script descarga la última versión del repositorio de GitHub y reemplaza el script local.

- Funcionalidades adicionales: El script también incluye funcionalidades para maximizar la ventana de la terminal y proporciona información sobre el estado de la conexión a Internet y la disponibilidad del software necesario.

# Instalacion

Clonar el repositorio

git clone https://github.com/sukigsx/instalar_software.git

# ESPERO OS GUSTE...


