#!/bin/bash
#############################################
#forma de utilizar los colores en echo
#echo -e "${rojo}Estes es el texto en rojo.${borra_colores"
#colores
rojo="\e[0;31m\033[1m" #rojo
verde="\e[;32m\033[1m" 
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
rosa="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
borra_colores="\033[0m\e[0m" #borra colores


# funcion salida
trap ctrl_c INT
function ctrl_c()
{
clear
figlet -c Gracias por 
figlet -c utilizar mi
figlet -c script
if [ -f /tmp/instalar_software.sh ]
then
    rm -r /tmp/instalar_software.sh 2>/dev/null 1>/dev/null 0>/dev/null
    rm -r /tmp/software 2>/dev/null 1>/dev/null 0>/dev/null
    
else
    #continua por que el fichero esta borrado.
    echo ""
fi
#wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
exit
}

################################################################3
# Empieza lo gordo
if [ -f /tmp/instalar_software.sh ]
then
    rm -r /tmp/instalar_software.sh
    
else
    echo ""
fi

clear
echo -e ""
echo -e "${verde} Comprobando software necesario para ejecutar el script.${borra_colores}"
echo -e ""
## Vericica conexion a internet
    if ping -c1 google.com &>/dev/null;
    then
        echo -e " [${verde}ok${borra_colores}] Conexion a internet."
        conexion="si" #sabemos si tenemos conexion a internet o no
    else
        echo -e " [${rojo}XX${borra_colores}] Conexion a internet."
        conexion=$(echo -e "${rojo}no${borra_colores}") #sabemos si tenemos conexion a internet o no
    fi
    
for paquete in figlet diff curl git nmap ssh ping which #ponemos el fostware a instalar separado por espacios
do
    which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
    sino=$? #recojemos el 0 o 1 del resultado de which
    contador="1" #ponemos la variable contador a 1
    while [ $sino -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
    do
        if [ $contador = "4" ] || [ $conexion = "no" ] #si el contador es 4 entre en then y sino en else
        then #si entra en then es porque el contador es igual a 4 y no ha podido instalar o no hay conexion a internet
            echo ""
            echo -e " ${amarillo}NO se ha podido instalar ($paquete).${borra_colores}"
            echo -e " ${amarillo}Intentelo usted con la orden:${borra_colores}"
            echo -e " ${rojo}-- sudo apt install $paquete --${borra_colores}"
            echo -e ""
            echo -e " ${rojo}No se puede ejecutar el script.${borra_colores}"
            echo ""
            exit
        else #intenta instalar
            echo " Instalando $paquete. Intento $contador/3."
            sudo apt install $paquete -y 2>/dev/null 1>/dev/null 0>/dev/null
            let "contador=contador+1" #incrementa la variable contador en 1
            which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
            sino=$? ##recojemos el 0 o 1 del resultado de which
        fi
done
    echo -e " [${verde}ok${borra_colores}] $paquete."
    software="si"
done

if [ $conexion = "no" ]
then
    echo -e ""
    echo -e "${rojo} Este script no se puede ejecutar correctamente."
    echo -e " Si NO dispone de conexion a internet y no se puede instalar software.${borra_colores}"
    echo ""
    echo -e "${amarillo} Pulsa una tecla para continuar.${borra_colores}"; read p
    ctrl_c
else
    echo -e ""
    echo -e "${verde} Conexion a internet${borra_colores} si"
    conexion="si"
    sleep 2
fi


#comprueba aztualiczacion del script
archivo_local="instalar_software_repositorios.sh" # Nombre del archivo local
ruta_repositorio="https://github.com/sukigsx/instalar_software.git" #ruta del repositorio para actualizar y clonar con git clone

# Obtener la ruta del script
descarga=$(dirname "$(readlink -f "$0")")
git clone $ruta_repositorio /tmp/comprobar >/dev/null 2>&1

diff $descarga/$archivo_local /tmp/comprobar/$archivo_local >/dev/null 2>&1


if [ $? = 0 ]
then
    #esta actualizado, solo lo comprueba
    echo ""
    echo -e "${verde} El script${borra_colores} $0 ${verde}esta actualizado.${borra_colores}"
    echo ""
    chmod -R +w /tmp/comprobar
    rm -R /tmp/comprobar
    actualizado="si"
else
    #hay que actualizar, comprueba y actualiza
    echo ""
    echo -e "${amarillo} EL script${borra_colores} $0 ${amarillo}NO esta actualizado.${borra_colores}"
    echo -e "${verde} Selecciona opcion ( 0 ) del menu para actualizar.${borra_colores}"
    actualizado=$(echo -e "${rojo}no${borra_colores}")
    sleep 3
fi

#maximiza la terminal.
#wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
while :
do
#maximiza la terminal.
#wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz

clear
echo -e "${rosa}"; figlet -c Sukigsx; echo -e "${borra_colores}"
echo -e "${verde}  Diseñado por sukigsx / Contacto:  scripts@mbbsistemas.es${borra_colores}"
echo -e "${verde}                                    https://repositorio.mbbsistemas.es/${borra_colores}"
echo ""
echo -e "${verde} Nombre del script.${borra_colores} $0 ${verde}Funcionamiento.${borra_colores} Seleccion de software para instalar en tu sistema.${borra_colores}"
echo ""
echo -e "${azul} Conexion a internet = ${borra_colores} $conexion ${azul}| Software necesario = ${borra_colores} $software ${azul}| Software actualizado = ${borra_colores} $actualizado ${borra_colores}"
echo ""
echo -e "  0.${azul} Actualiza este scripts.${borra_colores} >> ${turquesa}Actualizacion a la ultima version.${borra_colores}"
echo -e "  1. ${azul}Unity-Tweak-Tool, Perfecta para dejar Unity niquelado.                    ${borra_colores} 36. ${azul}Systemback, Utilidades para gestionar el sistema.${borra_colores}"
echo -e "  2. ${azul}Grub-customizer, modificar gestor de arranque.                            ${borra_colores} 37. ${azul}Nmap, escaner de red modo conosla.${borra_colores}"
echo -e "  3. ${azul}Libre Office.                                                             ${borra_colores} 38. ${azul}Copia de seguridad deja-dup.${borra_colores}"
echo -e "  4. ${azul}Gnome, entorno grafico.                                                   ${borra_colores} 39. ${azul}SSH servidor ssh.${borra_colores}"
echo -e "  5. ${azul}Gparted, poder partinionar los discos y unidades.                         ${borra_colores} 40. ${azul}Apache2 servidor apache.${borra_colores}"
echo -e "  6. ${azul}Vlc, reporoductor.                                                        ${borra_colores} 41. ${azul}FTP servidor ftp.${borra_colores}"
echo -e "  7. ${azul}Cairo-Dock, como su nombre indica en un dock.                             ${borra_colores} 42. ${azul}cifs-utils, para poder montar unidades con script monta.sh.${borra_colores}"
echo -e "  8. ${azul}Opcion vacia.                                                             ${borra_colores} 43. ${azul}Keepass2, Gestion de contraseñas.${borra_colores}"
echo -e "  9. ${azul}Gufw, control de cortafuegos en modo grafico.                             ${borra_colores} 44. ${azul}Openvpn, conexion a una vpn y paquetes para entorno grafico.${borra_colores}"
echo -e " 10. ${azul}Gdebi, instalador de paquetes en modo grafico.                            ${borra_colores} 45. ${azul}Authy, sistemas de proteccion de cuentas.${borra_colores}"
echo -e " 11. ${azul}Synaptic, que decir, muy bueno.                                           ${borra_colores} 46. ${azul}sshpass, poder pasar la clave al ssh.${borra_colores}"
echo -e " 12. ${azul}Tellico, crea tu base de datos de musica,libros,dvd,etc.                  ${borra_colores} 47- ${azul}Skanlite, software mejorado para escanear.${borra_colores}"
echo -e " 13. ${azul}Compizconfig-settings-manager, entorno grafico para el gestor compiz.     ${borra_colores} 48- ${azul}Google chrome stable.${borra_colores}"
echo -e " 14. ${azul}KdeConnect, sincroniza tu movil con el pc.                                ${borra_colores} 49. ${amarillo}Opcion vacia.${borra_colores}"
echo -e " 15. ${azul}Usuarios y Grupos entorno grafico entre otras utilidades.                 ${borra_colores} 50. ${amarillo}Opcion vacia.${borra_colores}"
echo -e " 16. ${azul}Solo instala gnome-online-accouns para drive de google.                   ${borra_colores} 51- ${azul}Transmision, descarga de torrent.${borra_colores}"
echo -e " 17. ${azul}Screenfetch, informacion de sistema.                                      ${borra_colores} 52- ${azul}Software-propietario, Gui gestionar ppa's, software propietario (video).${borra_colores}"
echo -e " 18. ${azul}Chromium, Navegador web.                                                  ${borra_colores} 53- ${azul}Fping, parecido a ping, pero con mas opciones.${borra_colores}"
echo -e " 19. ${azul}Integrar kio gdrive en linux, para entorno KDE.                           ${borra_colores} 54- ${azul}ReTest, Editor de texto de Markdown.${borra_colores}"
echo -e " 20. ${azul}Gestor de particiones de KDE.                                             ${borra_colores} 55- ${amarillo}Typora, Editor de tecto de Markdown.(quita despues el repo, de moneto falla)${borra_colores}"
echo -e " 21. ${azul}Disco de gnome, graba las iso y funciona en entorno KDE.                  ${borra_colores} 56- ${azul}Joplin, Para tomar notas y tareas pendientes.${borra_colores}"
echo -e " 22. ${azul}Brasero, para quemar cd y dvd.                                            ${borra_colores} 57- ${azul}Latte-dock, Crear paneles y docks muy personalizados para entorno plasma.${borra_colores}"
echo -e " 23. ${azul}K3b, quemador de cd y dbd de KDE.                                         ${borra_colores} 58- ${azul}Rclone, Sincroniza tus archivos con el almacenamiento en la nube.${borra_colores}"
echo -e " 24. ${azul}Steam, plataforma de juegos                                               ${borra_colores} 59- ${azul}Skype, Video conferencia de Microsoft.${borra_colores}"
echo -e " 25. ${azul}Spotify, plataforma de musica, Requiere Snap.                             ${borra_colores} 60- ${azul}Telegram, Mensajeria.${borra_colores}"
echo -e " 26. ${azul}Digikam, editor de fotos de KDE.                                          ${borra_colores}"
echo -e " 27. ${azul}Snap, instalador de paquetes.                                             ${borra_colores}"
echo -e " 28. ${azul}Ocamlfuse, sincronizar google drive.                                      ${borra_colores}"
echo -e " 29. ${azul}Terminal de gnome.                                                        ${borra_colores}"
echo -e " 30. ${azul}Simple scan.                                                              ${verde} OPCIONES DE INSTALACION ${borra_colores}"
echo -e " 31. ${azul}Net-tools para tener comandos de red en terminal.                         ${borra_colores} 70. ${azul}Listar el software seleccionado para instalar.${borra_colores}"
echo -e " 32. ${azul}Handbrake.                                                                ${borra_colores} 80. ${azul}BORRAR el software seleccionado para listalar.${borra_colores}"
echo -e " 33. ${azul}Shotwell, programa de fotos.                                              ${borra_colores} 90- ${azul}Instalar el software seleccionado.${borra_colores}"
echo -e " 34. ${azul}Nemo, explorador de ficheros.                                             ${borra_colores}"
echo -e " 35. ${azul}opcion vacia.                                                             ${borra_colores} 99. ${azul}Atras / Salir.${borra_colores}"
echo ""
echo -n " Selecciona el numero del software deseado para instalar --->>> "
read opcion
case $opcion in
    0)  #actualiza el script
        clear
        echo ""
        archivo_local="instalar_software_repositorios.sh" # Nombre del archivo local
        ruta_repositorio="https://github.com/sukigsx/instalar_software.git" #ruta del repositorio para actualizar y clonar con git clone

        # Obtener la ruta del script
        descarga=$(dirname "$(readlink -f "$0")")
        git clone $ruta_repositorio /tmp/comprobar >/dev/null 2>&1

        diff $descarga/$archivo_local /tmp/comprobar/$archivo_local >/dev/null 2>&1

        if [ $? = 0 ]
        then
            #esta actualizado, solo lo comprueba
            echo ""
            echo -e "${verde} El script${borra_colores} $0 ${verde}esta actualizado.${borra_colores}"
            echo ""
            chmod -R +w /tmp/comprobar
            rm -R /tmp/comprobar
        else
            #hay que actualizar, comprueba y actualiza
            echo ""
            echo -e "${amarillo} EL script${borra_colores} $0 ${amarillo}NO esta actualizado.${borra_colores}"
            echo -e "${verde} Se procede a su actualizacion automatica.${borra_colores}"
            sleep 3
            mv /tmp/comprobar/$archivo_local $descarga
            chmod -R +w /tmp/comprobar
            rm -R /tmp/comprobar
            echo ""
            echo -e "${verde} El script se ha actualizado, es necesario cargarlo de nuevo.${borra_colores}"
            echo -e "${amarillo} Se cerrara el terminal en 5 segundos.${borra_colores}"
            sleep 5
            #xdotool windowkill `xdotool getactivewindow`
        fi
        ;;

    1)  #Unity-Tweak-Tool, Perfecta para dejar Unity niquelado.
        #Actualizar completo solo kde con pkcon update
        if [ -d /home/$(whoami)/.kde ]
        then
            clear
            echo "";
            echo -e "${rojo} Tu sistema NO es Ubuntu.${borra_colores}";
            echo ""
            read -p " Seguro que deseas instalar Unity-Tweak-Tool ? (s/n)" sn;
            if [[ $sn = "s" ]] || [[ $sn = "s" ]]
            then
                clear;
                echo "unity" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
                #echo "sudo add-apt-repository -y ppa:freyja-dev/unity-tweak-tool-daily" >> /tmp/instalar_software.sh;
                echo "sudo apt update" >> /tmp/instalar_software.sh;
                echo "sudo apt install -y unity-tweak-tool" >> /tmp/instalar_software.sh;
                echo "" >> /tmp/instalar_software.sh;
                echo "";
                echo -e "${verde} Software añadido.${borra_colores}";
                echo "";
                sleep 1;
            else
                echo -e "${rojo} Regresando al menu.${borra_colores}";
                sleep 2
            fi

        else
            clear;
            echo "unity" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
            #echo "sudo add-apt-repository -y ppa:freyja-dev/unity-tweak-tool-daily" >> /tmp/instalar_software.sh;
            echo "sudo apt update" >> /tmp/instalar_software.sh;
            echo "sudo apt install -y unity-tweak-tool" >> /tmp/instalar_software.sh;
            echo "" >> /tmp/instalar_software.sh;
            echo "";
            echo -e "${verde} Software añadido.${borra_colores}";
            echo "";
            sleep 1;
        fi;;

    2)  #grub-customizer, modificar gestor de arranque.
        clear;
        echo "grub-customizer" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo add-apt-repository -y deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" >> /tmp/instalar_software.sh;
        echo "sudo apt install -y grub-customizer" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;

    3)  #libre office
        clear;
        echo "libreoffice" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo add-apt-repository -y ppa:libreoffice/ppa" >> /tmp/instalar_software.sh;
        echo "sudo apt update" >> /tmp/instalar_software.sh;
        echo "sudo apt install -y libreoffice" >> /tmp/instalar_software.sh;
        echo "sudo apt install -y libreoffice-l10n-es" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    4)  #Gnome, entorno grafico
        clear;
        echo "gnome-todo" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        #echo "" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y gnome" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    5)  #Gparted
        clear;
        echo "gparted" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y gparted" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;

    6)  #vlc
        clear;
        echo "vlc" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y vlc" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    7)  #cairo dock
        clear;
        echo "cairo-dock" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y cairo-dock" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    8)  #virtualbox
        clear;
        #echo "wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -" >> /tmp/instalar_software.sh;
        #echo "wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -" >> /tmp/instalar_software.sh;
        #echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee -a /etc/apt/sources.list >> /tmp/instalar_software.sh;
        #echo "virtualbox" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        #echo "sudo apt update" >> /tmp/instalar_software.sh;
        #echo "sudo apt install -y virtualbox " >> /tmp/instalar_software.sh;
        #echo "sudo apt install -y virtualbox-ext-pack" >> /tmp/instalar_software.sh;
        #echo "sudo apt install -y virtualbox-guest-additions-iso" >> /tmp/instalar_software.sh;
        #echo "" >> /tmp/instalar_software.sh;
        #echo "";
        #echo -e "${verde} Software añadido.${borra_colores}";
        #echo "";
        echo "esta opcion NO tiene nada"
        sleep 1;;
        
    9)  #gufw
        clear;
        echo "gufw" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y gufw" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    10) #gdebi
        clear;
        echo "gdebi" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y gdebi" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    11) #synaptic
        clear;
        echo "synaptic" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y synaptic" >> /tmp/instalar_software.sh;
        echo "sudo apt install -y apt-xapian-index" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    12) #tellico
        clear;
        echo "tellico" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y tellico" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    13) #compiz
        clear;
        echo "compiz" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y compizconfig-settings-manager" >> /tmp/instalar_software.sh;
        echo "sudo apt install -y compiz-plugins-extra" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    14) #kdeconnect
        clear;
        echo "kdeconnect-cli" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y kdeconnect" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    15) #usuarios y grupos
        clear;
        echo "users-admin" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y gnome-system-tools" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    16) #gnome online accouns
        clear;
        echo "gnome-control-center" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y gnome-online-accounts" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    17) #Screenfetch
        clear;
        echo "screenfetch" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y screenfetch" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    18) clear;
        echo "chromium-browser" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y chromium-browser" >> /tmp/instalar_software.sh;
        echo "sudo apt install -y chromium-browser-l10n" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    19) clear;
        echo "kioclient5" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install kio-gdrive kaccounts-providers -y" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    20) clear;
        echo "partitionmanager" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y partitionmanager" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    21) clear;
        echo "gnome-disks" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y gnome-disk-utility" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    22) clear;
        echo "brasero" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y brasero" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    23) clear;
        echo "k3b" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y k3b" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    24) clear;
        echo "steam" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y steam-installer" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    25) clear;
        echo "spotify" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y snapd" >> /tmp/instalar_software.sh;
        echo "sudo snap install spotify" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    26) clear;
        echo "digikam" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y digikam" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    27) clear;
        echo "snap" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y snapd" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    28) clear;
        echo "google-drive-ocamlfuse" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo add-apt-repository -y ppa:alessandro-strada/ppa" >> /tmp/instalar_software.sh
        echo "sudo apt update" >> /tmp/instalar_software.sh;
        echo "sudo apt install -y google-drive-ocamlfuse" >> /tmp/instalar_software.sh
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;

    29) clear;
        echo "gnome-terminal" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y gnome-terminal" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    30) clear;
        echo "simple-scan" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y simple-scan" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    31) clear;
        echo "ifconfig" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y net-tools" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    32) clear;
        echo "handbrake" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y handbrake" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    33) clear;
        echo "shotwell" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y shotwell" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    34) clear
        echo "nemo" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y nemo" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    35) #git y github-desktop
        clear;
        #echo "git" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        #echo "github-desktop" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        #echo 'sudo wget -O /etc/apt/trusted.gpg.d/shiftkey-desktop.asc "https://mirror.mwt.me/ghd/gpgkey"' >> /tmp/instalar_software.sh
        #echo 'sudo add-apt-repository -y deb [arch=amd64] https://mirror.mwt.me/ghd/deb/ any main' >> /tmp/instalar_software.sh
        #echo "sudo apt update" >> /tmp/instalar_software.sh;
        #echo "sudo apt install -y git github-desktop" >> /tmp/instalar_software.sh;
        #echo "" >> /tmp/instalar_software.sh;
        #echo "";
        #echo -e "${verde} Software añadido.${borra_colores}";
        #echo "";
        echo "Esta opcion esta vacia"
        sleep 1;;
        
    36) #systemback
        clear;
        echo "systemback" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 382003C2C8B7B4AB813E915B14E4942973C62A1B" >> /tmp/instalar_software.sh;
        echo "sudo add-apt-repository -y deb http://ppa.launchpad.net/nemh/systemback/ubuntu xenial main" >> /tmp/instalar_software.sh;
        echo "sudo apt update" >> /tmp/instalar_software.sh;
        echo "sudo apt install -y systemback" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    37) clear;
        echo "nmap" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y nmap" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    38) clear;
        echo "deja-dup" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y deja-dup" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    39) clear;
        echo "ssh" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y ssh" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
    
    40) clear;
        echo "apache2" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y apache2" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
    
    41) clear;
        echo "vsftpd" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y vsftpd" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    42) clear;
        echo "cifscreds" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y cifs-utils" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    43) clear;
        echo "keepass2" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y keepass2" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    44) clear;
        echo "openvpn" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y openvpn network-manager-openvpn network-manager-openvpn-gnome" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    45) clear;
        echo "authy" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo snap install authy --beta" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    46) clear;
        echo "sshpass" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y sshpass" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    47) clear;
        echo "skanlite" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y skanlite" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    48) clear;
        echo "google-chrome" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -" >> /tmp/instalar_software.sh;
        echo 'sudo add-apt-repository -y "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"' >> /tmp/instalar_software.sh;
        echo "sudo apt update" >> /tmp/instalar_software.sh;
        echo "sudo apt install -y google-chrome-stable" >> /tmp/instalar_software.sh;
        echo "sudo rm /etc/apt/sources.list.d/google*" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
    
    49) clear;
        #echo "teamviewer" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        #echo "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C5E224500C1289C0" >> /tmp/instalar_software.sh;
        #echo 'sudo add-apt-repository -y "deb http://linux.teamviewer.com/deb/ stable main"' >> /tmp/instalar_software.sh;
        #echo "sudo apt update" >> /tmp/instalar_software.sh;
        #echo "sudo apt install -y teamviewer" >> /tmp/instalar_software.sh;
        #echo "sudo rm /etc/apt/sources.list.d/team*" >> /tmp/instalar_software.sh;
        #echo "" >> /tmp/instalar_software.sh;
        #echo "";
        #echo -e "${verde} Software añadido.${borra_colores}";
        #echo "";
        echo "Esta opcion esta vacia"
        sleep 1;;
    
    50) clear;
        #echo "teamviewer" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        #echo "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C5E224500C1289C0" >> /tmp/instalar_software.sh;
        #echo 'sudo add-apt-repository -y "deb http://linux.teamviewer.com/deb/ stable main"' >> /tmp/instalar_software.sh;
        #echo "sudo apt update" >> /tmp/instalar_software.sh;
        #echo "sudo apt install -y teamviewer-host" >> /tmp/instalar_software.sh;
        #echo "sudo rm /etc/apt/sources.list.d/team*" >> /tmp/instalar_software.sh;
        #echo "" >> /tmp/instalar_software.sh;
        #echo "";
        #echo -e "${verde} Software añadido.${borra_colores}";
        #echo "";
        echo "Esta opcion esta vacia"
        sleep 1;;
    
     51) clear;
        echo "transmission-gtk" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y transmission" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
    
    52) clear;
        echo "software-properties-kde" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y software-properties-gtk software-properties-qt" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    53) clear;
        echo "fping" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y fping" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    54) clear;
        echo "retext" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y retext" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    55) clear;
        echo "typora" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -" >> /tmp/instalar_software.sh;
        echo "sudo add-apt-repository -y 'deb https://typora.io/linux ./'" >> /tmp/instalar_software.sh;
        echo "sudo apt update" >> /tmp/instalar_software.sh;
        echo "sudo apt install typora -y" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    56) clear;
        echo "/home/$(whoami)/.joplin/Joplin.AppImage" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install git" >> /tmp/instalar_software.sh;
        echo "sudo wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash" >> /tmp/instalar_software.sh;
        echo "sudo apt update" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
        
    57) #instala el latte dock
        clear;
        echo "latte-dock" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install latte-dock -y" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
    
    58) clear;
        echo "rclone" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "curl https://rclone.org/install.sh | sudo bash" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
    
    59) clear;
        echo "skype" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt install -y snapd" >> /tmp/instalar_software.sh;
        echo "sudo snap install skype --classic" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;
    
    60) clear;
        echo "telegram-desktop" >> /tmp/software #mete el nombre del programa para poder comprobar su instalacion
        echo "sudo apt -y install telegram-desktop" >> /tmp/instalar_software.sh;
        echo "" >> /tmp/instalar_software.sh;
        echo "";
        echo -e "${verde} Software añadido.${borra_colores}";
        echo "";
        sleep 1;;

    
    70) clear;
        if [ -f /tmp/instalar_software.sh ]
        then 
            cat /tmp/instalar_software.sh;
            echo "";
            echo " Pulsa una ENTER para continuar.";
            echo "";
            read pausa;
        else
            clear;
            echo "";
            echo " Imposible mostar software, nada seleccionado.";
            echo "";
            read -p " Pulsa ENTER para continuar. " pause;
        fi;;

    80) clear;
        echo "";
        echo " Software para instalar borrado.";
        echo "";
        rm -r /tmp/instalar_software.sh 2>/dev/null 1>/dev/null 0>/dev/null;
        read -p " Pulsa ENTER para continuar. " pause;;
        
    90) clear

        if [ -f /tmp/instalar_software.sh ]
        then
            echo "";
            echo -e "${verde} Actualizando tu sistema.${borra_colores}";
            echo "";
            sleep 1
            sudo apt update
            chmod +x /tmp/instalar_software.sh;
            bash /tmp/instalar_software.sh;

            #te muestra si se ha instalado el software, leyendo el fichero (software)
            #Que previamente se han ido metiendo los nombres de programas a instalar.
            clear
            echo ""
            echo -e "${verde} Listado de la instalacion de software.${borra_colores}"
            echo ""
            for existe in $(cat /tmp/software)
            do
            if [ $(which $existe) ]
            then
                echo -e "[${verde}V${borra_colores}] $existe"
            else
                echo -e "[${rojo}X${borra_colores}] $existe"
            fi
            done
            rm /tmp/software;
            echo ""
            echo -e " ${verde}Ficheros temporales borrados.${borra_colores}";

            #pregunta si quieres guardar el fichero de instalacion
            echo ""
            read -p " ¿Quieres guardar el fichero de instalacion para futuras instalaciones? (s/n Enter=Regresar) -->> " sn
            if [[ $sn = "s" ]] || [[ $sn = "S" ]] 2>/dev/null 1>/dev/null 0>/dev/null
            then
                echo ""
                echo -e " ${amarillo}Creando fichero de instalacion.${borra_colores}"
                sleep 2
                echo -e ""
                mv /tmp/instalar_software.sh /home/$(whoami)/instalacion_software_$(whoami).sh 2>/dev/null 1>/dev/null 0>/dev/null
                if [ -f /home/$(whoami)/instalacion_software_$(whoami).sh ]
                then
                    echo -e " ${verde}Colocado en /home/$(whoami). Pulsa una tecla para continuar.${borra_colores}"
                    read pause
                else
                    echo -e " ${rojo}Fallo de creaccion del script de instalacion. Pulsa una tecla para continuar.${borra_colores}"
                    read pause
                fi
            fi

            rm -r /tmp/instalar_software.sh;
            clear

        else
            clear;
            echo "";
            echo -e "${rojo} Imposible instalar el software. Nada seleccionado.${borra_colores}";
            read -p " Pulsa ENTER para continuar " pause;
        fi;;


        
    99) # salida
        ctrl_c;;
        
   
*)  echo "";
    echo "";
    echo -e " ${amarillo}OPCION NO DISPONIBLE EN EL MENU.    Seleccion 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 a 99${borra_colores}";
    echo -e " ${amarillo}PRESIONA ENTER PARA CONTINUAR ........${borra_colores}";
    echo "";
    read pause;;
esac
done
