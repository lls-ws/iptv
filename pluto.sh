#!/bin/sh
# Script to Create Pluto IPTV Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

pluto_install()
{
	
	echo "Installing nodejs npm packages..."
	
	sudo apt -y install nodejs npm
	
	echo "Node version: " `node -v`
    echo "npm version: " `npm -v`
	
}

pluto_download()
{

	pluto_install
	
	check_dir ${SERVER_DIR}
	
	echo "Get ${SERVER_NAME} iptv list..."
	(cd ${SERVER_DIR}; npx pluto-iptv; cd -)
	
	if [ ! -f ${FAVORITES_FILE} ]; then
		
		mv -v ${PLAYLIST_ALL} ${PLAYLIST_ALL_IPTV}
	
	fi
	
	(cd ${SERVER_DIR}; rm -fv "epg.xml" "cache.json"; cd -)
	
}

pluto_favorites()
{
	
	playlist_check
	
	FAVORITES_ARRAY=(
		"Filmes"
		"Séries"
		"Notícias"
		"Curiosidades"
	)
	
	check_dir ${FAVORITES_DIR}
		
	for FAVORITE_NAME in "${FAVORITES_ARRAY[@]}"
	do
		
		pluto_favorite
		
	done
		
	iptv_edit
	
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
	
	favorites_check
	
	echo "Join favorites channels..."
	
	cat ${FAVORITES_DIR}/*.txt > ${FAVORITES_FILE}
	
	pluto_download
	
	mv -v ${PLAYLIST_ALL} ${PLAYLIST_LLS}
	
	pluto_epg
	
	iptv_create
	
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
