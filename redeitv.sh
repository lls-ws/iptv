#!/bin/sh
# Script to Create RedeItv IPTV Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

redeitv_download()
{

	PLAYLIST_URL="https://www.apsattv.com/redeitv.m3u"
	
	iptv_download
	
}

redeitv_favorites()
{
	
	iptv_favorites
	
}

redeitv_create()
{
	
	favorites_create
	
	redeitv_group
	
	iptv_create
	
}

redeitv_group()
{

	echo -e "\nRemoving group-title..."
	
	sed -i 's/,group-title="sp"//g' ${PLAYLIST_LLS}
	
	echo "Removing Extra Names..."
	
	sed -i 's/CANAL 4 FILMES//g' ${PLAYLIST_LLS}

	favorites_group
	
}
