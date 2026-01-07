#!/bin/sh
# Script to Create IPTV Playlists Files
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

check_dir()
{
	
	DIR_CHECK="$1"
	
	if [ ! -d ${DIR_CHECK} ]; then
	
		mkdir -pv ${DIR_CHECK}
	
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

favorites_check()
{
	
	if [ -z "$(ls ${FAVORITES_DIR}/*.txt 2>/dev/null)" ]; then
	
		echo "Not found files on directoy ${FAVORITES_DIR}"
		echo "Run: bash $0 $(basename ${FAVORITES_DIR})"
		exit 1
	
	fi
	
	echo "Creating $(basename ${FAVORITES_FILE}) file..."
	
}

iptv_download()
{

	check_dir ${SERVER_DIR}
	
	if [ ! -f ${PLAYLIST_ALL_IPTV} ]; then
	
		echo "Getting ${IPTV_NAME}"
		(cd ${SERVER_DIR}; wget -O "${SERVER_NAME^}TV_br.m3u" ${PLAYLIST_URL}; cd -)
	
	fi 
	
	du -hsc ${PLAYLIST_ALL_IPTV}
	
	ls -al ${PLAYLIST_ALL_IPTV}
	
}

iptv_set()
{

	TEXT_EDITOR="featherpad"
	
	SERVER_NAME="${1}"
	SERVER_DIR="${SERVER_NAME}"
	
	LLS_DIR="lls"
	
	REPOSITORY_NAME="lls-ws.github.io"
	REPOSITORY_DIR=~/${REPOSITORY_NAME}
	
	IPTV_DIR="${REPOSITORY_DIR}/iptv"
	
	FAVORITES_FILE="${SERVER_DIR}/${SERVER_NAME}-favorites"
	FAVORITES_DIR="${SERVER_DIR}/$(echo $(basename ${FAVORITES_FILE}) | cut -d '-' -f 2)"
	FAVORITE_FILE="${FAVORITES_DIR}/favorites.txt"
	
	PLAYLIST_NAME="playlist.m3u8"
	PLAYLIST_ALL_IPTV="${SERVER_DIR}/${SERVER_NAME^}TV_br.m3u"
	PLAYLIST_LLS="${SERVER_DIR}/LLS_$(basename ${PLAYLIST_ALL_IPTV})"
	PLAYLIST_ALL="${SERVER_DIR}/${PLAYLIST_NAME}"
	PLAYLIST_LLS_TV="${LLS_DIR}/LLS_TV_br.m3u"
	
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

playlist_show()
{
	
	echo -e "\nFile:"
	
	du -hsc ${1}
	
	ls -al ${1}
	
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
	
	playlist_show ${PLAYLIST_LLS}
	
	if [ -f ${PLAYLIST_LLS_TV} ]; then
	
		rm -fv ${PLAYLIST_LLS_TV}
	
	fi
	
	echo -e "\nCreating $(basename ${PLAYLIST_LLS_TV}) file..."
	
	iptv_epg
	
	for SERVER_NAME in "${SERVERS_NAME[@]}"
	do
		
		iptv_set ${SERVER_NAME}
		
		if [ -f ${PLAYLIST_LLS} ]; then
	
			echo "Join ${PLAYLIST_LLS} to ${PLAYLIST_LLS_TV}"
			
			cat ${PLAYLIST_LLS} >> ${PLAYLIST_LLS_TV}
		
		fi
		
	done
	
	playlist_show ${PLAYLIST_LLS_TV}
	
}

iptv_epg()
{
	
	EPG_URL="https:\\\i.mjh.nz\PlutoTV\br.xml.gz"
	
	echo '#EXTM3U x-tvg-url="'${EPG_URL}'"' > ${PLAYLIST_LLS_TV}
		
	cat ${PLAYLIST_LLS_TV} | head -1
		
	echo -e "EPG for ${PLAYLIST_LLS_TV} created!\n"
		
}

iptv_favorites()
{
	
	iptv_check
	
	check_dir ${FAVORITES_DIR}

	if [ ! -f ${FAVORITE_FILE} ]; then
	
		echo "Get Channel Names..."
		
		cat ${PLAYLIST_ALL_IPTV} | \
		grep "EXTINF" |
		rev | \
		cut -d ',' -f 1 |
		rev > ${FAVORITE_FILE}
		
		sed -i '1i # Remove comment to add channel' ${FAVORITE_FILE}
		
		sed -i "s/^[0-9]*[[:space:]]//" ${FAVORITE_FILE}
		
		sed -i "s/^/#/" ${FAVORITE_FILE}
		
	fi
	
	${TEXT_EDITOR} ${FAVORITE_FILE}
	
}

favorites_create()
{
	
	favorites_check
	
	echo "Get Favorites Channel Names..."
	
	cat ${FAVORITE_FILE} | grep -v '#' | sort > ${FAVORITES_FILE}
	
	if [ -f ${PLAYLIST_LLS} ]; then
	
		rm -fv ${PLAYLIST_LLS}
	
	fi
	
	echo -e "Creating Playlist: ${PLAYLIST_LLS}\n"
	touch ${PLAYLIST_LLS}
	
	while IFS= read -r CHANNEL; do
	  
	  echo "Channel: ${CHANNEL}"
	  
	  cat ${PLAYLIST_ALL_IPTV} | grep -A1 "${CHANNEL}" >> ${PLAYLIST_LLS}
	  
	done < ${FAVORITES_FILE}
	
}

favorites_group()
{

	echo -e "\nAdd group-title..."
	
	sed -i 's/EXTINF:-1/EXTINF:-1 group-title="Filmes"/g' ${PLAYLIST_LLS}
	
	echo "Removing End Line Spaces..."
	
	sed -i 's/^[[:space:]]*//;s/[[:space:]]*$//' ${PLAYLIST_LLS}
	
}

remove_channel_numbers()
{
	
	echo -e "\nRemoving Channel Numbers..."
	
	sed -i 's/^\(#EXTINF:-1,\)[0-9]*[[:space:]]/\1/g' ${PLAYLIST_LLS}
	
}

remove_extra_names()
{
	
	echo "Removing Extra Names..."
	
	sed -i 's/(BR)//g' ${PLAYLIST_LLS}
	
	sed -i 's/(Substituto TCL)//g' ${PLAYLIST_LLS}
	
}

SERVERS_NAME=(
	"samsung"
	"meutedio"
	"movieark"
	"redeitv"
	"tcl"
	"lg"
	"pluto"
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
