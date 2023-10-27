---------
## Instalacion_software
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

### INSTALACION.

#### Descargar e instalar el paquete DEB.
- [Descargar el paque DEB](https://github.com/sukigsx/Instalacion-software/raw/main/instalacion-software.deb). Y lo puedes instalar con tu forma habitual.

- Instalar paquete DEB desde linea de comando en la terminal, lo descarga, lo instala y despues borra el paquete DEB.

      wget https://github.com/sukigsx/Instalacion-software/raw/main/instalacion-software.deb; sudo dpkg -i instalacion-software.deb; rm instalacion-software.deb
  
 - Clonar el repositorio, desde la terminal. Dar permisos de ejecucion a todos los ficheros.

       git clone https://github.com/sukigsx/Instalacion-software.git

**Nota**. Aconsejo instalar el paquete deb, porque así podrás tener en tu menú de aplicaciones el script con su icono y lo podrás lanzar de forma gráfica sin necesidad de abrir el terminal, además crea una función en el bashrc que al abrir el terminal y escribiendo (scripts), te lista todos mis scripts que tengas instalados en tu sistema que hayas instalado con el paquete deb. Cuando lo desístalas, te pregunta si lo quieres eliminar.

#### Desistalar el paquete deb, desde el terminal.
     sudo dpkg -r instalacion-software

### Forma de ejecucion.
- Si has clonado el repositorio y con permisos de ejecucion posicionandote dentro de la carpeta codigo.

      ./inicio.sukigsx.sh

- Si has instalado el paquete deb. Lo encontraras en el lanzador, menu utilidades y tambien en sistema.
  

### NOTA.
Le voy poniendo cada poco tiempo nuevas funcionalidades y nuevo software que me parece acto 
para nuestras distribuciones de linux y que considero de utilidad.
