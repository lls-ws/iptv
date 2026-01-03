#!/bin/sh
# Script to Create LG IPTV Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

lg_download()
{

	PLAYLIST_URL="https://www.apsattv.com/brlg.m3u"
	
	iptv_download
	
}

lg_favorites()
{
	
	iptv_favorites
	
}

lg_create()
{
	
	favorites_create
	
	lg_group
	
	iptv_create
	
}

lg_group()
{

	echo -e "\nRemoving Channel Numbers..."
	
	sed -i 's/.*#EXTINF:-1\([^,]*\).[0-9]*\([$[[:space:]]]*\)/#EXTINF:-1\1,\2/g' ${PLAYLIST_LLS}
	
	favorites_group
	
}
