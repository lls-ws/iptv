#!/bin/sh
# Script to Create Soul IPTV Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

soul_download()
{

	PLAYLIST_URL="https://www.apsattv.com/soultv.m3u"
	
	iptv_download
	
}

soul_favorites()
{
	
	iptv_favorites
	
}

soul_create()
{
	
	favorites_create
	
	soul_group
	
	iptv_create
	
}

soul_group()
{

	echo -e "\nRemoving group-title..."
	
	sed -i 's/ group-title="SoulTV.com.br"//g' ${PLAYLIST_LLS}
	
}
