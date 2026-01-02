#!/bin/sh
# Script to Create Samsung IPTV Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

samsung_download()
{

	PLAYLIST_URL="https://www.apsattv.com/ssungbra.m3u"
	
	iptv_download
	
}

samsung_favorites()
{
	
	iptv_check
	
	check_dir ${FAVORITES_DIR}

	if [ ! -f ${FAVORITE_FILE} ]; then
	
		echo "Get Channel Names..."
		
		cat ${PLAYLIST_ALL_IPTV} | \
		grep "EXTINF" | \
		cut -d ',' -f 2 > ${FAVORITE_FILE}
		
		sed -i '1i # Remove comment to add channel' ${FAVORITE_FILE}
		
		sed -i "s/^/#/" ${FAVORITE_FILE}
		
		iptv_edit
		
	else
	
		echo "File $(basename ${FAVORITE_FILE}) already exists!"
		echo -e "Remove to update!\n"
		
	fi
	
}

samsung_create()
{
	
	favorites_check
	
	echo "Get Favorites Channel Names..."
	cat ${FAVORITE_FILE} | \
	grep -v '#' | \
	cut -d " " -f2- > ${FAVORITES_FILE}
	
	if [ -f ${PLAYLIST_LLS} ]; then
	
		rm -fv ${PLAYLIST_LLS}
	
	fi
	
	echo ""
	
	while IFS= read -r CHANNEL; do
	  
	  echo "Channel: ${CHANNEL}"
	  cat ${PLAYLIST_ALL_IPTV} | grep -A1 "${CHANNEL}" >> ${PLAYLIST_LLS}
	  
	done < ${FAVORITES_FILE}
	
	samsung_group
	
	playlist_show ${PLAYLIST_LLS}
	
	iptv_create
	
}

samsung_group()
{

	echo -e "\nAdd group-title..."
	
	sed -i 's/^\(#EXTINF:-1,\)[0-9]*[[:space:]]/\1/g' ${PLAYLIST_LLS}
	
	sed -i 's/EXTINF:-1/EXTINF:-1 group-title="Filmes"/g' ${PLAYLIST_LLS}
	
	sed -i 's/(BR)//g' ${PLAYLIST_LLS}
	
	sed -i 's/(Substituto TCL)//g' ${PLAYLIST_LLS}
	
	sed -i 's/^[[:space:]]*//;s/[[:space:]]*$//' ${PLAYLIST_LLS}

}
