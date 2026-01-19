#!/bin/sh
# Script to Check for Update on Server Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

check_backup()
{
	
	playlist_check
	
	if [ ! -f ${PLAYLIST_ALL_BACKUP} ]; then
	
		cp -fv ${PLAYLIST_ALL_IPTV} ${PLAYLIST_ALL_BACKUP}
		
	else
	
		echo "Backup already exist!"
		echo "To create new, remove file: ${PLAYLIST_ALL_BACKUP}"
	
	fi
	
	if [ ${SERVER_NAME} = "pluto" ]; then
	
		mv -v ${FAVORITES_FILE} ${FAVORITE_FILE}
	
	fi
	
	rm -fv ${PLAYLIST_ALL_IPTV}
	
	${SERVER_NAME}_download
	
	check_compare
	
}

check_compare()
{
	
	echo "Comparing files:"
	
	if cmp -s ${PLAYLIST_ALL_IPTV} ${PLAYLIST_ALL_BACKUP}; then
		
		echo "Files are identical!"
		
		du -hsc ${PLAYLIST_ALL_IPTV} ${PLAYLIST_ALL_BACKUP}
		
	else
		
		echo "Files are different!"
		
		check_diff
		
	fi

}

check_diff()
{

	favorites_check
	
	cat ${PLAYLIST_ALL_IPTV} | grep 'EXTINF' | cut -d ',' -f 2 > ${CHANNEL_NAME}
	
	if [ ${SERVER_NAME} = "pluto" ]; then
	
		mv -v ${FAVORITE_FILE} ${FAVORITES_FILE}
		
		cat ${PLAYLIST_ALL_BACKUP} | grep 'EXTINF' | cut -d ',' -f 2 > ${CHANNEL_FAVORITE}
	
	else
	
		cp -fv ${FAVORITE_FILE} ${CHANNEL_FAVORITE}
		
		sed -i '1,2d' ${CHANNEL_FAVORITE}
		
		sed -i 's/Add#//' ${CHANNEL_FAVORITE}
	
		sed -i 's/#//' ${CHANNEL_FAVORITE}
	
	fi
	
	sed -i 's/^ *//' ${CHANNEL_FAVORITE}
	
	sed -i 's/^ *//' ${CHANNEL_NAME}
	
	echo "Check for new channels:"
	
	join -v 1 <(sort ${CHANNEL_NAME}) <(sort ${CHANNEL_FAVORITE}) > ${CHANNEL_NEW}
	
	rm -fv ${CHANNEL_NAME} ${CHANNEL_FAVORITE}
	
	if [ -s ${CHANNEL_NEW} ]; then
	
		echo -e "\nShowing new channels:"
	
		cat ${CHANNEL_NEW}
		
	else
	
		echo "New channels not found!"
	
	fi

}
