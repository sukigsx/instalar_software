# instalar_software
Script en bash, para la instalacion de software de forma interactiva.

 Por SUKIGSX

 Contacto: (Correo scripts@mbbsistemas.com) (Web https://repositorio.mbbsistemas.es)

 ### INSTALACION DE SOFTWARE

 Este script es un instalador de software interactivo.
 El script presenta al usuario una lista de categorías de software para elegir y luego ejecuta scripts específicos de cada categoría según la elección del usuario.

 Aquí hay una descripción general de cómo funciona el script:

 Utiliza un cuadro de diálogo de lista que presenta al usuario una serie de categorías de software para elegir, organizado en categorias, que son las siguientes:

   1) NAVEGADORES                Los principales navegadores para internet.
   2) AUDIO - VIDEO              Software relacionado el el Audio y el Video.
   3) ENTORNOS GRAFICOS LINUX    Los principales entornos graficos para linux basados en debian.
   4) UTILIDADES                 Cantidad de utilidades
   5) OFIMATICA                  Software dedicado a la ofimatica
   6) SERVIDORES                 Servidores para tu sistema, (ssh, ftp, smb, etc)
   7) GESTOR DE PAQUETES         Software para el control de paquetes. (snap apt etc).
   8) PARA TU TERMINAL           Software pensado para la terminal linux.
   9) DISCOS                     Software de control de discos duros y unidades en general.
  10) JUEGOS                     Pues ya lo dice todo, juegos.
  11) SEGURIDAD                  Software destinado a la seguridad de tu equipo.
  12) MENSAJERIA                 Software de mensajeria en red.
  13) PAQUETES INDEPENDIENTES    Descarga e instala paquetes deb manualmente.

  60) Ver el software marcado para instalar.
  70) Instalar el software seleccionado
  80) Borrar el software para instalar

  90) Ayuda                      Carga la ayuda
  99) Salir                      Salir (ctrl-c)



 - Según la opción seleccionada por el usuario, el script ejecuta un script específico para esa categoría.
    Cada script de categoría (Navegadores, AudioVideo, EntornosGraficosLinux, etc.) instala software relacionado con esa categoría.

 - Estos scripts de categoría están ubicados en una carpeta ($ruta_ejecucion) y se ejecutan utilizando el comando bash.

 - Si el usuario selecciona "Ayuda", se muestra una ventana de texto con información de ayuda (Esta ventana).

 - Si el usuario selecciona "Ver software marcado para instalar", el script verifica si se ha seleccionado algún software.
    Si se ha seleccionado software, procede a su instalacion.

 - Después de que la instalación haya terminado, el script verifica el software instalado y muestra los resultados en una ventana de texto.

 - Al final, el script elimina los archivos temporales utilizados durante el proceso.
    Tambien te la la opcion de poder tener una copia del script de instalacion del software que le has marcado, para furas instalaciones iguales.

 En resumen, este script proporciona una interfaz de usuario para instalar y verificar software en un sistema Linux.
 Es útil para simplificar el proceso de instalación de software para usuarios que prefieren una interfaz en lugar de trabajar en la línea de comandos.


 ### INSTALACION PAQUETES INDEPENDIENTES

 Este script maneja la instalación de paquetes .deb de forma interactiva y ofrece opciones para descargar, instalar y administrar dichos paquetes.
 Para ello primero, el script selecciona una navegador compatible que tengas en tu sistema, para poder cargar pas paquigas web de descarga.

 Aquí está el resumen de las opciones en el menú:

   1) Busqueda Libre           Se abre el navegador en www.google.es para que busuqes manualmente tus paquetes deb.
   2) Franz                    Control de varias cuentas a la vez como google, telegram,etc.
   3) Debreate                 Construccion de paquetes deb.
   4) Genymotion               Emulador de Android en la nube y para PC con integraciones para marcos de prueba. (al seleccionar se instala automatico)
   5) VirtualBox               Sostware gratuito para crear maquinas virtuales.
   6) Script de Sukigsx        Instalador de scripts de Sukigsx. (al seleccionar se instala automatico)
   7) TeamViewer               Control remoto de pc's, tablets y moviles.

  60) Borrar los paquetes descargados.
  70) Instalar los paquetes descargados.

  90) Ayuda                    Carga la ayuda.
  99) Atras                    Salir (ctrl-c)

 - Busqueda libre. Carga google.es en el navegador para que busques tu mismo el paquete *.deb.

 - Las siguientes opciones, ya estan configuradas, para abrir directamente las paginas en donde se encuentran los paquetes *.deb.
     En alguna ocasion las instalaciones NO van con un paque deb, asi que se automatiza el proceso dependiendo de su instalacion.

 - Borrar los paquetes descargador. El script comprobara si tienes paquetes deb descagados, si es asi los borrara todos.

 - Instalar los paquetes descargados. El script comprobara que tengas paquetes deb para su instalacion, realizara un sudo apt update
     y seguido comenzara la instalacion de todos los paquetes deb que dispongas en la carpeta descargas, una vez instalados
     borrara los ficheros *.deb de descargas para no ocupar espacio de disco.

 - Ayuda. Muestra información de ayuda relacionada con la instalación de paquetes independientes (Esta ventana).

 - Atras. Si marcas 99 que es la opcion Atras, el script regresa al menu anterior, si pulsas ctrl-c el script termina y se cierra.


 RESUMEN. este script facilita la descarga, instalación y gestión de paquetes .deb en sistemas Linux utilizando una interfaz interactiva.

 Tambien hay que tener en cuenta que no todo el software se instala desde un .deb, en ocasiones hay que ejecutar un binario de instalacion o cosas similares.
 En esos casos el script decidira la forma de instalacion del mismo.
 En el menu de Paquetes independientes en la descripcion Se informa de ello, como es el ejemplo de:
  Genymotion Emulador de Android en la nube y para PC con integraciones para marcos de prueba. (al dar a Descargar se instala solo)

### Instalacion

Se puede instalar de la forma traducional, clonando el repositorio.
                     
                     git clone https://github.com/sukigsx/instalar_software.git
 
