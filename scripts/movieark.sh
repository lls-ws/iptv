#!/bin/sh
# Script to Create MovieArk IPTV Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

movieark_download()
{

	PLAYLIST_URL="https://www.apsattv.com/moviearkbr.m3u"
	
	iptv_download
	
}

movieark_favorites()
{
	
	iptv_favorites
	
}

movieark_create()
{
	
	favorites_create
	
	movieark_group
	
	iptv_create
	
}

movieark_group()
{

	remove_spaces_end
	
}
