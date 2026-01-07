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
	
	favorites_check
	
	echo "Join favorites channels..."
	
	cat ${FAVORITES_DIR}/*.txt > ${FAVORITES_FILE}
	
	pluto_download
	
	mv -v ${PLAYLIST_ALL} ${PLAYLIST_LLS}
	
	pluto_group
	
	iptv_create
	
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

pluto_group()
{
	
	sed -i '/#EXTM3U/d' ${PLAYLIST_LLS}
	
	sed -i 's/group-title="Filmes", Pluto TV Cine Romance/group-title="Romance", Pluto TV Cine Romance/g' ${PLAYLIST_LLS}
	sed -i 's/group-title="Filmes", Pluto TV Filmes Nacionais/group-title="Romance", Pluto TV Filmes Nacionais/g' ${PLAYLIST_LLS}
	sed -i 's/group-title="Filmes", Pluto TV Cine Comédia Romântica/group-title="Romance", Pluto TV Cine Comédia Romântica/g' ${PLAYLIST_LLS}
	sed -i 's/group-title="Filmes", Pluto TV Bang Bang/group-title="Velhos", Pluto TV Bang Bang/g' ${PLAYLIST_LLS}
	sed -i 's/group-title="Mistérios e Sobrenatural"/group-title="Mistérios"/g' ${PLAYLIST_LLS}
	
}
