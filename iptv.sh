#!/bin/sh
# Script to Create IPTV Playlists Files
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

iptv_set()
{

	TEXT_EDITOR="featherpad"
	
	SERVER_NAME="${1}"
	SERVER_DIR="${SERVER_NAME}"
	
	FAVORITES_FILE="${SERVER_DIR}/${SERVER_NAME}-favorites"
	FAVORITES_DIR="${SERVER_DIR}/$(echo $(basename ${FAVORITES_FILE}) | cut -d '-' -f 2)"
	
	PLAYLIST_ALL_IPTV="${SERVER_DIR}/${SERVER_NAME^}TV_br.m3u"
	PLAYLIST_LLS="${SERVER_DIR}/LLS_$(basename ${PLAYLIST_ALL_IPTV})"
	PLAYLIST_ALL="${SERVER_DIR}/playlist.m3u8"
	
	REPOSITORY_NAME="lls-ws.github.io"
	REPOSITORY_DIR=~/${REPOSITORY_NAME}
	IPTV_DIR="${REPOSITORY_DIR}/iptv"
	
	FAVORITES_ARRAY=(
		"Filmes"
		"Séries"
		"Notícias"
		"Curiosidades"
	)
	
}

SERVERS_NAME=(
	"pluto"
	"samsung"
	"roku"
)

if [[ " ${SERVERS_NAME[*]} " =~ " ${1} " ]]; then

	iptv_set ${1}
	
	. ${SERVER_NAME}.sh
	
	case "$2" in
		install)
			${SERVER_NAME}_install
			;;
		download)
			${SERVER_NAME}_download
			${SERVER_NAME}_show
			;;
		favorites)
			${SERVER_NAME}_favorites
			;;
		show)
			${SERVER_NAME}_show
			;;
		create)
			${SERVER_NAME}_create
			;;
		clean)
			${SERVER_NAME}_clean
			;;
		upload)
			${SERVER_NAME}_upload
			;;
		all)
			${SERVER_NAME}_install
			${SERVER_NAME}_download
			${SERVER_NAME}_favorites
			${SERVER_NAME}_create
			;;
		*)
			echo "Use: $0 {all|install|download|favorites|show|create|clean|upload}"
			exit 1
			;;
	esac
	
else

	case "$1" in
		all)
			for SERVER_NAME in "${SERVERS_NAME[@]}"
			do
				
				iptv_set ${SERVER_NAME}
				
				. ${SERVER_NAME}.sh
				
				${SERVER_NAME}_all
				
			done
			;;
		*)
			echo "Use: $0 [all ${SERVERS_NAME[@]}]"
			exit 1
			;;
	esac

fi
