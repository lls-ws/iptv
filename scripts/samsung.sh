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
	
	adrenalina_pura_logo
	
	iptv_create
	
}
