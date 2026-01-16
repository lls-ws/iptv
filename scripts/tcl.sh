#!/bin/sh
# Script to Create TCL IPTV Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

tcl_download()
{

	PLAYLIST_URL="https://www.apsattv.com/tclbr.m3u"
	
	iptv_download
	
}

tcl_favorites()
{
	
	iptv_favorites
	
}

tcl_create()
{
	
	favorites_create
	
	jovempan_news_logo
	
	record_news_logo
	
	filmelier_logo
	
	grjngo_logo
	
	iptv_create
	
}
