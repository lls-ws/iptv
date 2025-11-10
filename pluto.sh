#!/bin/sh
# Script to Create Pluto IPTV Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

TEXT_EDITOR="featherpad"

SERVER_NAME=$(basename ${0%.*})
SERVER_DIR="${SERVER_NAME}"

FAVORITES_FILE="${SERVER_DIR}/pluto-favorites"
FAVORITES_DIR="${SERVER_DIR}/$(echo $(basename ${FAVORITES_FILE}) | cut -d '-' -f 2)"

PLAYLIST_ALL_IPTV="${SERVER_DIR}/PlutoTV_br.m3u"
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

pluto_install()
{
	
	echo "Installing nodejs npm packages..."
	
	sudo apt -y install nodejs npm
	
	echo "Node version: " `node -v`
    echo "npm version: " `npm -v`
	
}

pluto_download()
{

	if [ ! -d ${SERVER_DIR} ]; then
	
		mkdir -v ${SERVER_DIR}
	
	fi

	echo "Get ${SERVER_NAME} iptv list..."
	(cd ${SERVER_DIR}; npx pluto-iptv; cd -)
	
	if [ ! -f ${FAVORITES_FILE} ]; then
		
		mv -v ${PLAYLIST_ALL} ${PLAYLIST_ALL_IPTV}
	
	fi
	
	(cd ${SERVER_DIR}; rm -fv "epg.xml" "cache.json"; cd -)
	
}

pluto_favorites()
{
	
	if [ ! -f ${PLAYLIST_ALL_IPTV} ]; then
		
		echo "File ${PLAYLIST_ALL_IPTV} not found!"
		echo "Run: bash $0 download"
		exit 1
		
	fi
	
	if [ ! -d ${FAVORITES_DIR} ]; then
	
		mkdir -pv ${FAVORITES_DIR}
		
		for FAVORITE_NAME in "${FAVORITES_ARRAY[@]}"
		do
			
			pluto_favorite
			
		done
		
	fi
	
	pluto_show
	
	pluto_edit
	
}

pluto_favorite()
{
	
	FAVORITE_FILE="${FAVORITES_DIR}/${FAVORITE_NAME}.txt"
	
	if [ ! -f ${FAVORITE_FILE} ]; then
	
		echo "# ${FAVORITE_NAME}" > ${FAVORITE_FILE}
		
		echo "Get ${FAVORITE_NAME} Channel Names..."
		cat ${PLAYLIST_ALL_IPTV} | grep ${FAVORITE_NAME} | cut -d '"' -f 2 >> ${FAVORITE_FILE}
		
	else
	
		echo "File $(basename ${FAVORITE_FILE}) already exists!"
		echo -e "Remove to update!\n"
		
	fi
	
}

pluto_create()
{
	
	if [ -z "$(ls ${FAVORITES_DIR}/*.txt 2>/dev/null)" ]; then
	
		echo "Not found files on directoy ${FAVORITES_DIR}"
		echo "Run: bash $0 $(basename ${FAVORITES_DIR})"
		exit 1
	
	fi
	
	echo "Creating $(basename ${FAVORITES_FILE}) file..."
	echo "Join favorites channels..."
	
	cat ${FAVORITES_DIR}/*.txt > ${FAVORITES_FILE}
	
	pluto_download
	
	mv -v ${PLAYLIST_ALL} ${PLAYLIST_LLS}
	
	pluto_epg
	
	pluto_show
	
}

pluto_epg()
{
	
	EPG_URL="https:\/\/i.mjh.nz\/PlutoTV\/br.xml.gz"
	
	if [ -f ${PLAYLIST_LLS} ]; then
	
		echo "Add EPG url"
		sed -i 's/#EXTM3U/#EXTM3U x-tvg-url="'${EPG_URL}'"/g' ${PLAYLIST_LLS}
		
		cat ${PLAYLIST_LLS} | head -1
		
		echo "File ${PLAYLIST_LLS} created!"
		
	fi
	
}

pluto_clean()
{
	
	echo "Cleanning ${SERVER_NAME} iptv list..."
	
	rm -fv ${PLAYLIST_LLS} ${PLAYLIST_ALL} ${PLAYLIST_ALL_IPTV}
	rm -rfv ${FAVORITES_FILE} ${FAVORITES_DIR} ${SERVER_DIR}
	
	pluto_show
	
}

pluto_show()
{
	
	echo "Showing ${SERVER_DIR} files:"
	
	if [ -n "$(ls ${SERVER_DIR}/* 2>/dev/null)" ]; then
	
		ls -al ${SERVER_DIR}/*
		
	else
	
		ls -al
	
	fi
	
}

pluto_edit()
{
	
	echo "Editing ${FAVORITES_DIR} files..."
	
	if [ -n "$(ls ${FAVORITES_DIR}/*.txt 2>/dev/null)" ]; then
	
		${TEXT_EDITOR} $(realpath ${FAVORITES_DIR})/*.txt
		
	else
	
		echo "Not found ${FAVORITES_DIR} files!"
		exit 1
		
	fi
	
}

pluto_upload()
{
	
	echo "Uploading $(basename ${PLAYLIST_LLS})"
	
	sudo bash git_download.sh ${REPOSITORY_NAME}
	
	echo -e "\nCopying $(basename ${PLAYLIST_LLS}) to ${REPOSITORY_DIR}"
	
	if [ ! -d ${IPTV_DIR} ]; then
	
		mkdir -v ${IPTV_DIR}
	
	fi
	
	cp -fv ${PLAYLIST_LLS} ${PLAYLIST_ALL_IPTV} ${IPTV_DIR}
	
	ls -al ${IPTV_DIR}
	
	sudo bash git_remote.sh ${REPOSITORY_NAME}
	
}

case "$1" in
	install)
		pluto_install
		;;
	download)
		pluto_download
		pluto_show
		;;
	favorites)
		pluto_favorites
		;;
	show)
		pluto_show
		;;
	create)
		pluto_create
		;;
	clean)
		pluto_clean
		;;
	upload)
		pluto_upload
		;;
	all)
		pluto_install
		pluto_download
		pluto_favorites
		pluto_create
		;;
	*)
		echo "Use: $0 {all|install|download|favorites|show|create|clean|upload}"
		exit 1
		;;
esac
