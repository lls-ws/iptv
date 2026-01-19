#!/bin/sh
# Script to Create MeuTedio IPTV Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

meutedio_download()
{

	PLAYLIST_URL="https://helenfernanda.github.io/gratis/iptvlegal.m3u"
	
	iptv_download
	
	cp -fv ${PLAYLIST_ALL_IPTV} ${PLAYLIST_TMP}
	
	cat ${PLAYLIST_TMP} | grep -A1 'group-title="Brasil: cinema' > ${PLAYLIST_ALL_IPTV}
	
	if [ ! -f ${PLAYLIST_ALL_BACKUP} ]; then
		
		cp -fv ${PLAYLIST_ALL_IPTV} ${PLAYLIST_ALL_BACKUP}
		
	fi
	
}

meutedio_favorites()
{
	
	iptv_favorites
	
}

meutedio_create()
{
	
	favorites_create
	
	meutedio_group
	
	iptv_create
	
}

meutedio_group()
{

	echo -e "\nReplacing group-title..."
	
	sed -i 's/ group-title="Brasil: cinema"//g' ${PLAYLIST_LLS}

}
