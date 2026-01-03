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
	
	iptv_favorites
	
}

samsung_create()
{
	
	favorites_create
	
	samsung_group
	
	iptv_create
	
}

samsung_group()
{

	echo -e "\nRemoving Channel Numbers..."
	
	sed -i 's/^\(#EXTINF:-1,\)[0-9]*[[:space:]]/\1/g' ${PLAYLIST_LLS}
	
	echo "Removing Extra Names..."
	
	sed -i 's/(BR)//g' ${PLAYLIST_LLS}
	
	sed -i 's/(Substituto TCL)//g' ${PLAYLIST_LLS}
	
	favorites_group
	
}
