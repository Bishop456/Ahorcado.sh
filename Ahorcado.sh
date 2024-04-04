#!/bin/bash                                                                

trap 'echo -e "\nSaliendo del juego..."; if [ "$ganador" = true ]; then echo -e "$color1 ¡Felicidades! Has adivinado la palabra: $palabra $color4"; fi; exit 0' SIGINT

color1="\033[;0;38;5;200m"
color2="\033[;0;38;5;50m"
color3="\033[;0;38;5;80m"
color4="\033[;0;38;5;4m"

palabras=("ahorcado" "gato" "perro" "python" "programacion" "bash")
palabra=${palabras[$RANDOM % ${#palabras[@]}]}
max_intentos=6
letras_adivinadas=""
ganador=false

mostrar_palabra() {
    palabra_oculta=""
    letras_restantes=false
    for letra in $(echo $palabra | grep -o .); do
        if [[ $letras_adivinadas == *"$letra"* ]]; then
            palabra_oculta+="$letra "
        else
            palabra_oculta+="_ "
            letras_restantes=true
        fi
    done
    if [ "$letras_restantes" = true ]; then
        echo "$palabra_oculta"
    else
        echo "$palabra_oculta"
        echo -e "$color1 ¡Felicidades! Has adivinado la palabra: $palabra $color4"
        exit 0
    fi
}

mostrar_ahorcado() {
    caso_ahorcado=$1
    echo -e "$color4"
    if [ $caso_ahorcado -eq 6 ]; then
        echo "  _____"
        echo " |/   |"
        echo " |   \\o/"
        echo " |    |"
        echo " |   / \\"
        echo " |    "
        echo "_|___"
    elif [ $caso_ahorcado -eq 5 ]; then
        echo "  _____"
        echo " |/   |"
        echo " |   \\o/"
        echo " |    |"
        echo " |   / "
        echo " |    "
        echo "_|___"
    elif [ $caso_ahorcado -eq 4 ]; then
        echo "  _____"
        echo " |/   |"
        echo " |   \\o/"
        echo " |    |"
        echo " |    "
        echo " |    "
        echo "_|___"
    elif [ $caso_ahorcado -eq 3 ]; then
        echo "  _____"
        echo " |/   |"
        echo " |   \\o"
        echo " |    |"
        echo " |    "
        echo " |    "
        echo "_|___"
    elif [ $caso_ahorcado -eq 2 ]; then
        echo "  _____"
        echo " |/   |"
        echo " |    o"
        echo " |    |"
        echo " |    "
        echo " |    "
        echo "_|___"
    elif [ $caso_ahorcado -eq 1 ]; then
        echo "  _____"
        echo " |/   |"
        echo " |    o"
        echo " |    "
        echo " |    "
        echo " |    "
        echo "_|___"
    elif [ $caso_ahorcado -eq 0 ]; then
        echo "  _____"
        echo " |/   |"
        echo " |    "
        echo " |    "
        echo " |    "
        echo " |    "
        echo "_|___"
    fi
}

jugar_ahorcado() {
    while [ "$ganador" = false ] && [ "$max_intentos" -gt 0 ]; do
        clear
        mostrar_ahorcado $((6 - max_intentos))
        echo -e "$color1 Palabra : $color2 $(mostrar_palabra)"
        echo -e "$color3 Intentos restantes : $color2 $max_intentos"
        echo -n -e "$color1 Ingresa una letra : $color4"; read -n 1 -r letra
        echo ""
        if [[ $palabra == *"$letra"* ]]; then
            letras_adivinadas+="$letra"
        else
            ((max_intentos--))
            echo "Letra incorrecta. ¡Intenta de nuevo!"
        fi
        mostrar_palabra
        sleep 0.5
    done

    if ! $ganador; then
        clear
        mostrar_ahorcado 6
        echo -e "$color1 Palabra : $color2 $palabra"
        echo "¡Lo siento! Has agotado todos tus intentos."
    fi
}

jugar_ahorcado

