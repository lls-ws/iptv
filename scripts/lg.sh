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
	
	iptv_create
	
}
