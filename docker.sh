#!/usr/bin/env bash

print_style () {

    if [ "$2" == "info" ] ; then
        COLOR="96m"
    elif [ "$2" == "success" ] ; then
        COLOR="92m"
    elif [ "$2" == "warning" ] ; then
        COLOR="93m"
    elif [ "$2" == "danger" ] ; then
        COLOR="91m"
    else #default color
        COLOR="0m"
    fi

    STARTCOLOR="\e[$COLOR"
    ENDCOLOR="\e[0m"

    printf "$STARTCOLOR%b$ENDCOLOR" "$1"
}

display_options () {
    printf "Available options:\n";
    print_style "   install_dockersync" "info"; printf "\t\t ONLY MAC Installs docker-sync gem on the host machine.\n"
    print_style "   init" "info"; printf "\t\t Initialize docker project.\n"
    print_style "   start" "info"; printf "\t\t Installs docker-sync gem on the host machine.\n"
    print_style "   synclogs" "info"; printf "\t\t For mac get synchro logs.\n"
    print_style "   logs" "info"; printf "\t\t Get containers logs\n"
    print_style "   bash" "info"; printf "\t\t Connect to a container\n"
    print_style "   xdebug enable/disable" "info"; printf "\t\t enable or disable xdebug on php container r\n"
}

if [[ $# -eq 0 ]] ; then
    print_style "Missing arguments.\n" "danger"
    display_options
    exit 1
fi

if [ ! -f .env ] ; then
    if [ "$1" != "init" ] ; then
        print_style "You have to use init first \n"
        display_options
        exit 1
    fi
fi

if [ "$1" == "init" ] ; then

    rm -rf .env
    cp env-conf .env
    export $(egrep -v '^#' .env | xargs)
    echo $"" >> .env

    #Add docker-compose for your platform
    composeFiles="docker-compose.yml"
    if [ "$(uname)" == "Darwin" ]; then
        # Do something under Mac OS X platform
        composeFiles="$composeFiles:docker-compose.mac.yml"
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Do something under GNU/Linux platform
        composeFiles="$composeFiles:docker-compose.linux.yml"
    fi

    #Now build compose file for each plugins
    for plugin in $(echo $PLUGINS | tr "/" "\n")
    do
      composeFiles="$composeFiles:plugins/$plugin/docker-compose.yml"
    done

    echo $"COMPOSE_FILE=$composeFiles" >> .env
elif [ "$1" == "install_dockersync" ]; then
    if [ "$(uname)" == "Darwin" ]; then
        print_style "Installing docker-sync\n" "info"
        gem install docker-sync
    fi
elif [ "$1" == "start" ]; then
    if [ "$(uname)" == "Darwin" ]; then
        # Do something under Mac OS X platform
        docker-sync start
    fi
    docker-compose up -d
elif [ "$1" == "logs" ]; then
        docker-compose logs -f
elif [ "$1" == "synclogs" ]; then
    if [ "$(uname)" == "Darwin" ]; then
        # Do something under Mac OS X platform
        docker-sync logs -f
    fi
elif [ "$1" == "bash" ]; then
    NAME=$(docker ps --format '{{.Names}}')
    #
    arr=($NAME)
    PS3='Choose a container : '
    select opt in "${arr[@]}"
    do
        case $opt in
            *) docker exec -it $opt bash
            break;;
        esac
    done
elif [ "$1" == "stop" ]; then
    if [ "$(uname)" == "Darwin" ]; then
        # Do something under Mac OS X platform
        docker-sync stop
    fi
    docker-compose stop
elif [ "$1" == "xdebug" ]; then
    # get container names on env
    export $(egrep -v '^#' .env | xargs)

    chmod a+x docker/scripts/xdebug-$2.sh && ./docker/scripts/xdebug-$2.sh $APPLICATION_NAME"_php" $PHP_VERSION
else
    print_style "Invalid arguments.\n" "danger"
    display_options
    exit 1
fi