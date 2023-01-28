#!/bin/bash
# this script create the gotify config file inside $HOME/.config directory with gotify app token and gotify url
# then create a symbolic link of the gotify-push script inside /usr/local/bin
# Require root privileges

# Step 1 create the config file or override it
CONFIG_FILE_NAME="gotify-push"
CONFIG_FILE="$HOME/.config/$CONFIG_FILE_NAME"
override_file="no"
create_file="yes"
if [ -f $CONFIG_FILE ]; then
    create_file="no"
    printf "The config file: $CONFIG_FILE already exists. Do you want to override it?\n"
    PS3="Type 1 or 2: "
    actions=("yes" "no")
    select action in "${actions[@]}"; do
        case $action in
        "no")
            override_file="no"
            break
            ;;
        "yes")
            override_file="yes"
            break
            ;;
        *) printf "[!] $REPLY isn't a valid option. Try again\n" ;;
        esac
    done
fi

if [ "yes" == "$create_file" ] || [ "yes" == "$override_file" ]; then
    read -p "Type the gotify app token: " token
    token=${token}
    if [ "" == "$token" ]; then
        echo "[!] The Gotify app token is required."
        exit 1
    fi
    read -p "Type the gotify server url : " url
    url=${url%/}
    if [ "" == "$url" ]; then
        echo "[!] The Gotify server url is required."
        exit 1
    fi
    touch $CONFIG_FILE
    printf "token=$token\nurl=$url" > $CONFIG_FILE
    file_action="created"
    if [ "yes" == "$override_file" ]; then
        file_action="updated"
    fi
    printf "Config file: $CONFIG_FILE $file_action with success.\n"
    #create a symbolic link to allow the root user to run the script
    if [ "root" != "$USER" ]; then
        printf "Type your password to create a symbolic link into /root/.config folder to enable root user to run this script\n"
        sudo ln -sf $CONFIG_FILE /root/.config/$CONFIG_FILE_NAME
        printf "Symbolic link created\n"
    fi
else
    printf "[ok] Step 1 completed.\n"
fi
echo ""
current_path=$(pwd)
script_path="${current_path}/gotify-push"

# Step 2 create a symbolic link from current directory to /usr/local/bin
printf "Do you want to create a symbolic link of this script into /usr/local/bin?\n"
PS3="Type 1 or 2: "
actions=("yes" "no")
select action in "${actions[@]}"; do
    case $action in
    "no")
        printf "[ok] Installation completed. Close and open the terminal again and type: $script_path -h"
        echo ""
        exit 0
        break
        ;;
    "yes")
        if [ ! -d /usr/local/bin ]; then
            printf "[!] Sorry but the /usr/local/bin directory doesn't exists."
            echo "" 
            exit 1
        fi
        sudo ln -sf $script_path /usr/local/bin/gotify-push
        printf "Installation completed. Close and open the terminal again and type: gotify-push -h"
        echo ""
        exit 0
        break
        ;;
    *) printf "[!] $REPLY isn't a valid option. Try again\n" ;;
    esac
done
exit 0
