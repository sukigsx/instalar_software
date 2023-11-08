#!/bin/bash
###################################################################################
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


####################################################################################
# funcion de control-c
trap ctrl_c INT
function ctrl_c()
{
clear
ls /home/$(whoami)/Descargas/*.deb 2>/dev/null 0>/dev/null 1>/dev/null
if [ $? = 0 ] 2>/dev/null 0>/dev/null
then
    rm -R /home/$(whoami)/Descargas/*.deb
    clear
    figlet -c Gracias por 
    figlet -c utilizar mi
    figlet -c script
    #wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    exit
else
    clear
    figlet -c Gracias por 
    figlet -c utilizar mi
    figlet -c script
    #wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    exit
fi
}

clear
echo -e ""
echo -e "${verde} Verificando software necesario.${borra_colores}"
echo -e ""
## Vericica conexion a internet
    if ping -c1 google.com &>/dev/null;
    then
        echo -e " [${verde}ok${borra_colores}] Conexion a internet."
        conexion="si" #sabemos si tenemos conexion a internet o no
    else
        echo -e " [${rojo}XX${borra_colores}] Conexion a internet."
        conexion="no" #sabemos si tenemos conexion a internet o no
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
            read p
            ctrl_c
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
    echo -e " Si NO dispone de conexion a internet.${borra_colores}"
    echo -e "${amarillo} Pulsa una tecla para continuar.${borra_colores}"; read p
else
    echo -e ""
fi


#comprueba actualiczacion del script
archivo_local="instalar_software_externo.sh" # Nombre del archivo local
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
    actualizado="no"
    sleep 3
fi


#seleccion de navegador
while :
do
#maximiza la terminal.
#wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
clear
echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
echo ""
echo -e "${azul}  Diseñado por sukigsx / Contacto: scripts@mbbsistemas.es${borra_colores}"
echo -e "${azul}                                   https://repositorio.mbbsistemas.es/${borra_colores}"
echo ""
echo -e "${azul} Nombre del script.< instalar_software_no_incluido_en_repositorios.sukigsx.sh >${borra_colores}"
echo ""
echo -e "${verde} Funcionamiento.${borra_colores} = Seleccionar software externo para instalar."
echo ""
echo -e "${rojo}NOTA.${amarillo} Si estas conectado de forma remota, NO funcionara, tienes que estar en${borra_colores}"
echo -e "${amarillo}      una termnal en local.${borra_colores}"
echo ""
echo -e "${azul} Conexion a internet  = ${borra_colores} $conexion"
echo -e "${azul} Software necesario   = ${borra_colores} $software"
echo -e "${azul} Software actualizado = ${borra_colores} $actualizado"
echo ""
echo -e " Seleccion de navegador para la descarga de software:"
echo -e ""
echo -e "  0. ${azul}Actualizar el script.${borra_colores}"
echo -e ""
echo -e "  1. ${azul}Google-Chrome.${borra_colores}"
echo -e "  2. ${azul}Firefox.${borra_colores}"
echo -e "  3. ${azul}Chromium.${borra_colores}"
echo -e ""
echo -e " 99. ${azul}Salir/Atras${borra_colores}"
echo -e ""
echo -n " Seleccione un navegador de la lista --->>> "
read navegador
case $navegador in
    
    0) #actualiza el script
    archivo_local="instalar_software_externo.sh" # Nombre del archivo local
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
    
    1)  which google-chrome 2>/dev/null 1>/dev/null 0>/dev/null
        google=$?
        contador="1"
        while [ $google -gt 0 ]
        do
            if [ $contador = "4" ]
            then
                echo ""
                echo -e "${rojo} No tienes conexion a internet, No se puede ejecutar el script.${borra_colores}"
                echo -e "${rojo} Pulsa una tecla para continuar.${borra_colores}"
                read pause
                exit
            else
                echo ""
                echo -e "- ${amarillo}Navegador Google-Chrome, NO esta instalado.${borra_colores}  (Enter = Instalar y continuar -- Control+C = Salir)."
                read pause
                echo -e "- ${amarillo}Intento de instalacion de numero $contador del navegador seleccionado.${borra_colores}"
                wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - #2>/dev/null 1>/dev/null 0>/dev/null
                sudo add-apt-repository "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" #2>/dev/null 1>/dev/null 0>/dev/null
                sudo apt install -y google-chrome-stable #2>/dev/null 1>/dev/null 0>/dev/null
                sudo rm /etc/apt/sources.list.d/google* #2>/dev/null 1>/dev/null 0>/dev/null
                let "contador=contador+1"
                which google-chrome 2>/dev/null 1>/dev/null 0>/dev/null
                google=$?
            fi
        done
        navegador=google-chrome
        break;;

    2)  which firefox 2>/dev/null 1>/dev/null 0>/dev/null
        firefox=$?
        contador="1"
        while [ $firefox -gt 0 ]
        do
            if [ $contador = "4" ]
            then
                echo ""
                echo -e "${rojo} No tienes conexion a internet, No se puede ejecutar el script.${borra_colores}"
                echo -e "${rojo} Pulsa una tecla para continuar.${borra_colores}"
                read pasue
                exit
            else
                echo ""
                echo -e "${amarillo} Navegador Firefox, NO esta instalado.${borra_colores}  (Enter = Instalar y continuar -- Control+C = Salir)."
                read pause
                echo -e "${amarillo} Intento de instalacion de numero $contador del navegador seleccionado.${borra_colores}"
                sudo apt install -y firefox #2>/dev/null 1>/dev/null 0>/dev/null
                let "contador=contador+1"
                which firefox 2>/dev/null 1>/dev/null 0>/dev/null
                firefox=$?
            fi
        done
        navegador=firefox
        break;;
        
    3)  which chromium-browser 2>/dev/null 1>/dev/null 0>/dev/null
        chromium=$?
        contador="1"
        while [ $chromium -gt 0 ]
        do
            if [ $contador = "4" ]
            then
                echo ""
                echo -e "${rojo} No tienes conexion a internet, No se puede ejecutar el script.${borra_colores}"
                echo -e "${rojo} Pulsa una tecla para continuar.${borra_colores}"
                read pasue
                exit
            else
                echo ""
                echo -e "${amarillo} Navegador Chromium, NO esta instalado.${borra_colores}  (Enter = Instalar y continuar -- Control+C = Salir)."
                read pause
                echo -e "${amarillo} Intento de instalacion de numero $contador del navegador seleccionado.${borra_colores}"
                sudo apt install -y chromium-browser #2>/dev/null 1>/dev/null 0>/dev/null
                sudo apt install -y chromium-browser-l10n #2>/dev/null 1>/dev/null 0>/dev/null
                let "contador=contador+1"
                which chromium-browser 2>/dev/null 1>/dev/null 0>/dev/null
                chromium=$?
            fi
        done
        navegador=chromium-browser
        break;;
    
    99) #salir
        ctrl_c;;

    *)  echo "";
        echo -e " ${amarillo}OPCION NO DISPONIBLE EN EL MENU. Seleccion 1, 2 o 3 o 99 Salir/Atras.${borra_colores}";
        echo -e " ${amarillo}PRESIONA ENTER PARA CONTINUAR ........${borra_colores}";
        echo ""
        read pause;; 

esac
done


while :
do
clear
#maximiza la terminal.
#wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
figlet -c sukigsx
echo -e "${verde} Diseñado por sukigsx / Contacto: | sukisx.mbsistemas@gmail.com${borra_colores}"
echo -e "${verde}                                  | https://mbsistemas.ddns.net${borra_colores}"
echo ""
echo -e "${verde} Nombre del script.${borra_colores}               < instalar_software_no_incluido_en_repositorios.sukigsx.sh >"
echo ""
echo -e "${verde} Funcionamiento.${borra_colores}                  Seleccionar software externo para instalar."
echo ""
echo -e "${amarillo} Si estas conectado de forma remota, NO funcionara, tienes que estar en${borra_colores}"
echo -e "${amarillo} una termnal en local.${borra_colores}"
echo ""
echo -e "${amarillo}Recuerda que los paquetes deb que te descarges, tienen que estar en la carpeta descargas.${borra_colores}"
echo -e ""
echo -e "  0. ${azul}Actualiza este scripts.${borra_colores}"
echo -e ""
echo -e "  1. ${azul}Buscar tu software de descarga.${borra_colores}"
echo -e "  2. ${azul}Virtualbox, Para crear maquinas virtuales.${borra_colores}"
echo -e "  3. ${azul}Franz, Control de varias cuentas a la vez como google, telegram,etc.${borra_colores}"
echo -e "  4. ${azul}Teamviwer, Control remoto.${borra_colores}"
echo -e "  5. ${azul}Debreate, Construccion de paquetes deb.${borra_colores}"
echo -e "  6. ${azul}Instalar scripts de sukigsx.${borra_colores}"
echo -e "  7. ${azul}Github Desktop, entorno grafico para gestionar tu github.${borra_colores}"
echo -e "  8. ${azul}Skype para linux .deb.${borra_colores}"
echo -e "  9. ${azul}Genymotion, Emulador de sistemas android.${borra_colores}"
echo -e " 10. ${azul}Steam, plataforma de juegos.${borra_colores}"
echo -e " 11. ${azul}Telegram, plataforma de mensajeria.${borra_colores}"

echo -e ""
echo -e " 70. ${azul}Ver el software para instalar.${borra_colores}"
echo -e " 80. ${azul}Borrar todo lo descargado.  ${rojo}QUIDADO BORRARA TODOS LOS FICHEROS CON EXTENSION *.DEB${borra_colores}"
echo -e " 90. ${azul}Instalar todo lo descargado.${borra_colores}"
echo ""
echo -e " 99. ${azul}Atras / Salir.${borra_colores}"
echo ""
echo -n " Seleccione una opcion del menu --->>> "
read opcion

case $opcion in

    0) #actualiza el script
    if [ -e /usr/bin/inicio.sukigsx.sh ] #comprueba si se ha instalado el script con el deb, comprobando el fichero /usr/bin/inicio.sukigsx.sh
        then
            ruta="/usr/bin"
            cd /tmp
            mkdir temporal_update
            git clone https://github.com/sukigsx/Instalacion-software.git /tmp/temporal_update
            cd /tmp/temporal_update/codigo/
            sudo chmod +x $ruta/*.sukigsx.sh
            sudo cp -r /tmp/temporal_update/codigo/* $ruta
            sudo rm -r /tmp/temporal_update
            clear
            echo "";
            echo -e "${verde} Script actualizado. Tienes que reiniciar el script para ver los cambios.${borra_colores}";
            echo "";
            read -p " Pulsa una tecla para continuar." pause
            ctrl_c;
        else
            ruta=$(pwd)
            cd /tmp
            mkdir temporal_update
            git clone https://github.com/sukigsx/Instalacion-software.git /tmp/temporal_update
            cd /tmp/temporal_update/codigo/
            sudo chmod +x $ruta/*.sukigsx.sh
            sudo cp -r /tmp/temporal_update/codigo/* $ruta
            sudo rm -r /tmp/temporal_update
            clear
            echo "";
            echo -e "${verde} Script actualizado. Tienes que reiniciar el script para ver los cambios.${borra_colores}";
            echo "";
            read -p " Pulsa una tecla para continuar." pause
            ctrl_c;
        fi;; 

    1) $navegador www.google.es 2>/dev/null;;

    2) $navegador https://www.virtualbox.org/wiki/Downloads 2>/dev/null;;

    3) $navegador https://meetfranz.com/ 2>/dev/null;;

    4) $navegador https://www.teamviewer.com/es/descarga/linux/ 2>/dev/null;;

    5) $navegador https://antumdeluge.github.io/debreate-web/ 2>/dev/null;;

    6) $navegador https://sukigsx.github.io 2>/dev/null;;
    
    7) $navegador https://github.com/shiftkey/desktop/releases/ 2>/dev/null;;
    
    8) $navegador https://go.skype.com/skypeforlinux-64.deb 2>/dev/null;;
    
    9) $navegador https://www.genymotion.com/download/
        cd /home/$(whoami)/Descargas
        chmod +x geny*.bin; sudo ./geny*.bin; rm geny*.bin;;

    10) $navegador https://store.steampowered.com/about/?l=spanish;;

    11) $navegador https://desktop.telegram.org/ 2>/dev/null;;

    70) #ls="ls /home/$(whoami)/Descargas";
        ls /home/$(whoami)/Descargas/*.deb 2>/dev/null 0>/dev/null 1>/dev/null
        if [ $? = 0 ] 2>/dev/null 2>/dev/null 0>/dev/null 1>/dev/null
        then 
            echo ""
            echo -e "${verde} Software descargado y listo para instalar${borra_colores}";
            echo "";
            echo -e "${azul}$(ls -c /home/$(whoami)/Descargas/*.deb)${borra_colores}";
            echo "";
            read -p "- Pulsa ENTER para continuar " pause;
        else
            echo "";
            echo -e "${amarillo} No existe ningun software descargado.....${borra_colores}";
            echo "";
            sleep 3
        fi;;
        
    80) ls /home/$(whoami)/Descargas/*.deb 2>/dev/null 0>/dev/null 1>/dev/null
        if [ $? = 0 ] 2>/dev/null 2>/dev/null 0>/dev/null 1>/dev/null
        then
            read -p " Seguro que quieres borrar todo lo de la carpeta descargas? ( S/N ) -->> " respuesta;
            if [ $respuesta = "S" ] || [ $respuesta = "s" ] 2>/dev/null;
            then
                rm -R /home/$(whoami)/Descargas/*.deb;
                echo "";
                echo -e "${verde} Todo borrado.${borra_colores}";
                echo "";
                sleep 3;
            else
                echo "";
                echo -e "${verde} Cancelado, no se borra nada.${borra_colores}";
                echo "";
                sleep 3;
            fi;
        else
            echo "";
            echo -e "${amarillo} No existe ningun software descargado.....${borra_colores}";
            echo "";
            sleep 3
        fi;;
        
    90) ls /home/$(whoami)/Descargas/*.deb 2>/dev/null 0>/dev/null 1>/dev/null
        if [ $? = 0 ] 2>/dev/null 2>/dev/null 0>/dev/null 1>/dev/null
        then 
            echo "";
            echo -e "${verde} Instalando todo lo descargado.${borra_colores}";
            echo "";
            sudo dpkg -i /home/$(whoami)/Descargas/*.deb;
            sudo apt-get -f -y install;
            sudo rm /home/$(whoami)/Descargas/*.deb;
            echo "";
            echo -e "${verde} Todo INSTALADO. presiona enter.${borra_colores}";
            echo "-----------------------------------------------------------------------------------------------------------------------------------------------";        
            read -p " Pulsa ENTER para continuar." pause;
        else
            echo "";
            echo -e "${amarillo} NO hay nada para instalar.${borra_colores}";
            echo "";        
            sleep 3
        fi;;

    99) ctrl_c;;

*) echo "";
   echo -e "${amarillo} OPCION NO DISPONIBLE EN EL MENU. Seleccion 1, 2, 3, 4, 5, etc. a 99${borra_colores}";
   echo -e "${amarillo} PRESIONA ENTER PARA CONTINUAR ........${borra_colores}";
   echo ""
   read pause;;
esac
done
