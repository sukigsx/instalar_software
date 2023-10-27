 #!/bin/bash
###################################################################################################3
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

##verificacion de conexion y tambien de fostware necesario
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
    
for paquete in git wmctrl figlet nmap ssh diff #ponemos el fostware a instalar separado por espacios
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

#comprueba actualiczacion del script
archivo_local="software_inicio.sh" # Nombre del archivo local
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

#toma el control al pulsar control + c
trap ctrl_c INT
function ctrl_c()
{
clear
figlet -c Gracias por 
figlet -c utilizar mi
figlet -c script
wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
exit
}

###################################################################################################
#funcion ayuda
function ayuda(){
clear
echo -e ""
echo -e "${verde} Explicacion de los menus principales:${borra_colores}"
echo -e ""
echo -e "  0.${azul} Actualiza este scripts.${borra_colores}                  >>   ${turquesa}Actualizacion a la ultima version.${borra_colores}" 
echo -e ""
echo -e "  1.${azul} Actualizacion de sistema con update.${borra_colores}     >>   ${turquesa}Basicamente realiza una actualizacion de la lista de repositorios de tu sistema.${borra_colores}"
echo -e "  2.${azul} Actualizacion de sistema con upgrade.${borra_colores}    >>   ${turquesa}Realiza la instalacion de las actualizaciones de software y paquetes de tu sistemas.${borra_colores}"
echo -e "  3.${azul} Actualizar sistema con update y upgrade.${borra_colores} >>   ${turquesa}Realiza los dos pasos anteriores a la vez.${borra_colores}"
echo -e "  4.${azul} Actualizacion completo (solo KDE).${borra_colores}       >>   ${turquesa}Realiza la actualizacion del sistema complatamente, solo para entornos KDE PLASMA.${borra_colores}"
echo -e ""
echo -e "  5.${azul} Instalacion repositorios y actualizar.${borra_colores}   >>   ${turquesa}Instala repositorios adicionales, para poder instalar software.${borra_colores}"
echo -e "  6.${azul} Instalar sostware de repositorios.${borra_colores}       >>   ${turquesa}Instalacion de software que tengas disponible en tus repositorios.${borra_colores}"
echo -e ""
echo -e "  7.${azul} Instalar software externo.${borra_colores}               >>   ${turquesa}Podras descargar los paquetes *.deb y luego se instalar todos a la vez.${borra_colores}"
echo -e ""
echo -e "  8.${azul} Busca equipos en la red.${borra_colores}                 >>   ${turquesa}Realiza un nmap que busque dispositivos conectados en tu red para saber la ip.${borra_colores}"
echo -e "  9.${azul} Conectar a equipo de red.${borra_colores}                >>   ${turquesa}Cuando ya sabes la ip, te facilita la conexion por ssh.${borra_colores}"
echo -e ""
echo -e " 40.${azul} Instalar scripts de Suukigsx.${borra_colores}            >>   ${turquesa}Entra en el repositorio de github del desarrollador Sukigsx.${borra_colores}"
echo -e ""
echo -e " 90.${azul} Menu de ayuda.${borra_colores}                           >>   ${turquesa}Lo que estas biendo jejeje.${borra_colores}"
echo -e " 99.${azul} Salir.${borra_colores}                                   >>   ${turquesa}Sale del script.${borra_colores}"
echo -e ""
echo -n " Pulsa ENTER para continuar "; read pause
}

#########################################################
# Aqui empieza el tema

#maximiza la terminal.
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz

while :
do
clear
#maximiza la terminal.
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
echo ""
echo -e "${verde} Diseñado por sukigsx / Contacto:   sukigsx.mbsistemas@gmail.com${borra_colores}"
echo -e "${verde}                                    https://mbsistemas.ddns.net${borra_colores}"
echo ""
echo -e "${verde} Nombre del script < inicio.sukigsx.sh > Instalacion de software en sintemas linux.  ${borra_colores}"
echo ""
echo -e "${azul} Conexion a internet  = ${borra_colores} $conexion"
echo -e "${azul} Software necesario   = ${borra_colores} $software"
echo -e "${azul} Software actualizado = ${borra_colores} $actualizado"
echo -e ""
echo -e "     0. ${azul}Actualiza este scripts.${borra_colores}"
echo -e ""
echo -e "     1. ${azul}Actualizacion de sistema con update.${borra_colores}"
echo -e "     2. ${azul}Actualizacion de sistema con upgrade.${borra_colores}"
echo -e "     3. ${azul}Actualizar sistema completo con update y upgrade.${borra_colores}"
echo -e "     4. ${azul}Actualizar completo. ( Solo valido para kde ).${borra_colores}"
echo ""
echo -e "     5. ${azul}Instalar software de repositorios.${borra_colores}"
echo -e "     6. ${azul}Instalar software externo.${borra_colores}"
echo ""
echo -e "     7. ${azul}Buscar equipos en la red.${borra_colores}"
echo -e "     9. ${azul}Conectar a equipo de red.${borra_colores}"
echo ""
echo -e "    40. ${azul}Instalar scripts de sukigsx.${borra_colores}"
echo ""
echo -e "    90. ${azul}Ayuda.${borra_colores}"
echo -e "    99. ${azul}Salir.${borra_colores}"
echo ""
echo -n " Seleccione una opcion del menu --->>> "
read opcion
case $opcion in
    
    0) #actualiza el script
    archivo_local="software_inicio.sh" # Nombre del archivo local
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
        xdotool windowkill `xdotool getactivewindow`
    fi
    ;;
    
    1) #Actualizar el sistema con update
        clear;
        echo "";
        echo -e " ${amarillo}Enpezando el update.${borra_colores}";
        echo "";
        sudo apt update;
        clear
        echo "";
        echo -e "${verde} sudo apt update, Realizado con exito.${borra_colores}";
        read -p " Pulsa ENTER para continuar " pause;;
        
    2) #Actualizar con upgrade
        if [ -d /home/$(whoami)/.kde ]
        then
            echo ""
            echo -e "${rojo} LO SIENTO, He destectado KDE, la orden no se puede ejecutar, SELECCIONA OPCION ( 4 )${borra_colores}";
            read -p " Pulsa ENTER para continuar " pause;
        else
            sudo apt upgrade;
            clear
            echo "";
            echo -e "${verde} sudo apt update, Realizado con exito.${borra_colores}";
            read -p " Pulsa ENTER para continuar " pause;
        fi;;
        
        
    3) #Actualizar sistema completo NO kde update y upgrade
        if [ -d /home/$(whoami)/.kde ]
        then
            echo ""
            echo -e "${rojo} LO SIENTO, He destectado KDE, la orden no se puede ejecutar, SELECCIONA OPCION ( 4 ).${borra_colores}";
            read -p " Pulsa ENTER para continuar " pause;
        else
            sudo apt update;
            sudo apt upgrade;
            clear
            echo "";
            echo -e "${verde} sudo apt upgrade, Realizado con exito.${borra_colores}";
            read -p " Pulsa ENTER para continuar " pause;
        fi;;
    
    4) #Actualizar completo solo kde con pkcon update
        if [ -d /home/$(whoami)/.kde ]
        then
            sudo pkcon update;
            clear
            echo "";
            echo -e "${verde} sudo pkcon update, realizado con exito.${borra_colores}";
            read -p " Pulsa ENTER para continuar " pause;
        else
            echo "";
            echo -e " ${rojo}Lo siento no estas en un sistema con entorno KDE, seleccion opcion 3.${borra_colores}";
            read -p " Pulsa ENTER para continuar " pause;
        fi;;
    
        
    5) #Instalar software de repositorios
        wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
        if [ -d /home/$(whoami)/scripts ]
        then
            bash /home/$(whoami)/scripts/instalar_software_repositorios.sh
        else
            bash instalar_software_repositorios.sh
        fi
        ;;
        
    6) #Instalar software de terceros
        wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
        if [ -d /home/$(whoami)/scripts ]
        then
            bash /home/$(whoami)/scripts/instalar_software_externo.sh
        else
            bash instalar_software_externo.sh
        fi
        ;;
    
    7) #Buscar equipos en la red con nmap
        echo -e " Tu ip en la red es ${verde}$(hostname -I)${borra_colores}"
        read -p " Dime el rango de tu red lan, por (Ejemplo, 192.168.1) -->> " rango_ip;
        clear;
        echo "";
        echo -e "${verde} Escaneando la red con orden de nmap -sP $rango_ip.0/24${borra_colores}";
        echo "";
        nmap -sP $rango_ip.0/24;
        echo "";
        echo -e "${verde} TERMINADO, Red escaneada.${borra_colores}";
        read -p " Pulsa ENTER para continuar " pause;;
        
     8) #conectar a equipo en la red, por ssh
        echo -e " Tu ip en la red es ${verde}$(hostname -I)${borra_colores}"
        read -p " Dime direccion ip a conectar por (ssh) -->> " ssh_ip;
        read -p " Dime el puerto (ssh, defecto 22) de la maquina $ssh_ip --> " port_maquina_remota
        read -p " Dime nombre de usuario de $ssh_ip con puerto $port_maquina_remota -->> " ssh_usuario;
        clear;
                port=$port_maquina_remota;  # puerto
                connect_timeout=5;            # Tiempo de espera
                timeout $connect_timeout bash -c "</dev/tcp/$ssh_ip/$port";
                if [ $? == 0 ] 2>/dev/null
                then
                    ssh-keygen -f "/home/sukigsx/.ssh/known_hosts" -R "$ssh_ip" 2>/dev/null
                    clear
                    ssh -t -p $port_maquina_remota $ssh_usuario@$ssh_ip "clear;echo INFORMACION de Sukigsx;echo;echo ESTAS EN LA MAQUINA REMOTA;echo;exec \$SHELL --login"
                    echo "";
                    echo -e " ${verde}SALIENDO DE LA CONEXION SSH${borra_colores}, Si has tenido problemas de conexion.";
                    echo "";
                    echo " Espara un momento ..........";
                    echo "";
                    sleep 5;
                else
                    clear;
                    echo "";
                    echo -e "- ${rojo}La conexion al servidor ssh de la maquina $ssh_ip, NO esta disponible.${borra_colores}";
                    echo "";
                    echo " Espara un momento ..........";
                    echo "";
                    sleep 5;
                fi;;

    40) #instalar scripts de sukigsx
        wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
        bash instalar_software_no_incluido_en_los_repositorios.sukigsx.sh;;
        
    
    90) #ayuda
        ayuda;;
                
    99) #salida
        ctrl_c;;

    *)  #se activa cuando se introduce una opcion no controlada del menu
        echo "";
        echo -e " ${amarillo}OPCION NO DISPONIBLE EN EL MENU.    Seleccion 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 40, 90 o 99 ${borra_colores}";
        echo -e " ${amarillo}PRESIONA ENTER PARA CONTINUAR ........${borra_colores}";
        echo "";
        read pause;;
esac
done
