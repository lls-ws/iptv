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

	samsung_logo
	
}

samsung_logo()
{
	
	URL_LOGO="https:\/\/d2mxb63djushzm.cloudfront.net\/images\/Sofa%20Digital\/Adrenalina%20Pura%20TV\/LG\/APTV-Logo-%20400x200.png"
	
	sed -i '/2646 Adrenalina Pura TV (BR) (Substituto TCL)/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
}
