#!/usr/bin/env bash
#
# Get Git Mail
# A simple extrator user email account from github public data :)
#
# https://github.com/saymoncoppi/get_git_mail
#
# Author:     Saymon Coppi <saymoncoppi@gmail.com>
# Maintainer: Saymon Coppi <saymoncoppi@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Text styles 
bold=$(tput bold);normal=$(tput sgr0)

# Base URLs
GIT_URL="https://github.com/saymoncoppi/get_git_mail"

# Clear the screen
clear

if [ -z $1 ]; then
       echo 
       printf "${bold}How to use: ${normal}Run ./ggm.sh UserName from github.com/...\n"
       echo        
    else
# prnting ascii art made on http://patorjk.com/software/taag
echo "

             _           _ _                     _ _ 
            | |         (_) |                   (_) |
   __ _  ___| |_    __ _ _| |_   _ __ ___   __ _ _| |
  / _  |/ _ \ __|  / _  | | __| |  _   _ \ / _  | | |
 | (_| |  __/ |_  | (_| | | |_  | | | | | | (_| | | |
  \__, |\___|\__|  \__, |_|\__| |_| |_| |_|\__,_|_|_|
   __/ |            __/ |                            
  |___/            |___/                             
"
UserName=$1
git_user_url="https://api.github.com/users/${UserName}/events/public"

# Check user email
function get_git_mail {
    wget --quiet --tries=1 --spider "${git_user_url}"
    if [ $? -eq 0 ]; then
        EmailAccount=$(wget -nv -q -O- https://api.github.com/users/${UserName}/events/public | sed -n -e 's/^.*"email": "//p' | sed -e 's/\"\,//g' | head -1)
        GithubPage="https://github.com/${UserName}"
        
        echo 
        printf "${bold}Extraction Results${normal}\n"
        echo "------------------------------------------------------"
        echo "User Name:          $UserName"
        echo "Email Account:      $EmailAccount"
        echo "Github Page:        $GithubPage"

        echo -e "\n\n"
    else
        echo "Ops! Url Not Found!"
        exit
    fi
}
get_git_mail       
    fi