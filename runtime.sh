#!/bin/sh
# Script to Create Runtime IPTV Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

runtime_download()
{

	iptv_download
	
}

runtime_create()
{
	
	iptv_create
	
}

runtime_favorites()
{
	
	iptv_check

	echo "Creating ${PLAYLIST_LLS} file..."
	
	cat ${PLAYLIST_IPTV} | \
	grep -A1 'Brasil: cinema",RunTime' > ${PLAYLIST_ALL_IPTV}
	
	cat ${PLAYLIST_ALL_IPTV} | \
	grep -Ev "link 2|6128|Comédia|2553|Família|Romance|4866|pluto" > ${PLAYLIST_LLS}
	
	runtime_group
	
	du -hsc ${PLAYLIST_ALL_IPTV} ${PLAYLIST_LLS}
	
}

runtime_group()
{

	echo "Replacing group-title..."
	sed -i 's/group-title="Brasil: cinema/group-title="Filmes/g' ${PLAYLIST_LLS}

}
