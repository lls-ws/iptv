#!/bin/sh
# Script to Create IPTV Playlists Files
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

check_dir()
{
	
	DIR_CHECK="$1"
	
	if [ ! -d ${DIR_CHECK} ]; then
	
		mkdir -v ${DIR_CHECK}
	
	fi
	
}

iptv_check()
{
	
	if [ ! -f ${PLAYLIST_IPTV} ]; then
	
		echo "File ${PLAYLIST_IPTV} not found!"
		echo "Run: bash $0 download"
		exit 1
	
	fi
	
}

playlist_check()
{
	
	check_dir ${SERVER_DIR}
	
	if [ ! -f ${PLAYLIST_ALL_IPTV} ]; then
		
		echo "File ${PLAYLIST_ALL_IPTV} not found!"
		echo "Run: bash $0 ${SERVER_NAME} download"
		exit 1
		
	fi
	
}

iptv_download()
{

	check_dir "${LLS_DIR}"
	
	if [ ! -f ${PLAYLIST_IPTV} ]; then
	
		echo "Getting ${IPTV_NAME}"
		(cd ${LLS_DIR}; wget -O ${IPTV_NAME} ${IPTV_URL}; cd -)
	
	fi 
	
	du -hsc ${PLAYLIST_IPTV}
	
	ls -al ${PLAYLIST_IPTV}
	
}

iptv_set()
{

	TEXT_EDITOR="featherpad"
	
	SERVER_NAME="${1}"
	SERVER_DIR="${SERVER_NAME}"
	
	LLS_DIR="lls"
	
	REPOSITORY_NAME="lls-ws.github.io"
	REPOSITORY_DIR=~/${REPOSITORY_NAME}
	
	IPTV_NAME="iptvlegal.m3u"
	IPTV_DIR="${REPOSITORY_DIR}/iptv"
	IPTV_URL="https://tv.meuted.io/${IPTV_NAME}"
	
	FAVORITES_FILE="${SERVER_DIR}/${SERVER_NAME}-favorites"
	FAVORITES_DIR="${SERVER_DIR}/$(echo $(basename ${FAVORITES_FILE}) | cut -d '-' -f 2)"
	
	PLAYLIST_ALL_IPTV="${SERVER_DIR}/${SERVER_NAME^}TV_br.m3u"
	PLAYLIST_LLS="${SERVER_DIR}/LLS_$(basename ${PLAYLIST_ALL_IPTV})"
	PLAYLIST_NAME="playlist.m3u8"
	PLAYLIST_ALL="${SERVER_DIR}/${PLAYLIST_NAME}"
	PLAYLIST_IPTV="${LLS_DIR}/${IPTV_NAME}"
	PLAYLIST_LLS_TV="${LLS_DIR}/LLS_TV.br.m3u"
	
}

iptv_show()
{
	
	echo "Showing ${SERVER_DIR} files:"
	
	if [ -n "$(ls ${SERVER_DIR}/* 2>/dev/null)" ]; then
	
		ls -al ${SERVER_DIR}/*
		
	else
	
		ls -al
	
	fi
	
}

iptv_clean()
{
	
	echo "Cleanning ${SERVER_NAME} iptv list..."
	
	rm -fv ${PLAYLIST_LLS} ${PLAYLIST_ALL} ${PLAYLIST_ALL_IPTV}
	rm -rfv ${FAVORITES_FILE} ${FAVORITES_DIR} ${SERVER_DIR}
	
	iptv_show
	
}

iptv_update()
{
	
	echo "Uploading $(basename ${PLAYLIST_LLS_TV})"
	
	sudo bash git_download.sh ${REPOSITORY_NAME}
	
	echo -e "\nCopying $(basename ${PLAYLIST_LLS_TV}) to ${REPOSITORY_DIR}"
	
	check_dir ${IPTV_DIR}
	
	cp -fv ${PLAYLIST_LLS_TV} ${IPTV_DIR}
	
	ls -al ${IPTV_DIR}
	
	sudo bash git_remote.sh ${REPOSITORY_NAME}
	
}

iptv_create()
{
	
	if [ -f ${PLAYLIST_LLS_TV} ]; then
	
		rm -fv ${PLAYLIST_LLS_TV}
	
	fi
	
	for SERVER_NAME in "${SERVERS_NAME[@]}"
	do
		
		iptv_set ${SERVER_NAME}
		
		if [ -f ${PLAYLIST_LLS} ]; then
	
			echo "Join ${PLAYLIST_LLS} to ${PLAYLIST_LLS_TV}"
			
			cat ${PLAYLIST_LLS} >> ${PLAYLIST_LLS_TV}
		
		fi
		
	done
	
	du -hsc ${PLAYLIST_LLS_TV}
	
	ls -al ${PLAYLIST_LLS_TV}
	
}

SERVERS_NAME=(
	"pluto"
	"runtime"
	"samsung"
	"roku"
)

if [[ " ${SERVERS_NAME[*]} " =~ " ${1} " ]]; then

	iptv_set ${1}
	
	. ${SERVER_NAME}.sh
	
	case "$2" in
		download)
			${SERVER_NAME}_download
			;;
		favorites)
			${SERVER_NAME}_favorites
			;;
		create)
			${SERVER_NAME}_create
			;;
		show)
			iptv_show
			;;
		clean)
			iptv_clean
			;;
		update)
			iptv_update
			;;
		all)
			${SERVER_NAME}_download
			${SERVER_NAME}_favorites
			${SERVER_NAME}_create
			;;
		*)
			echo "Use: $0 {all|download|favorites|create|show|clean|update}"
			exit 1
			;;
	esac
	
else

	echo "Streaming ${1} not found!"
	echo "Run: $0 [${SERVERS_NAME[@]}]"
	exit 1

fi
