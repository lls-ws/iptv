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
	
	tcl_group
	
	iptv_create
	
}

tcl_group()
{

	remove_channel_numbers
	
	remove_extra_names
	
	remove_spaces_end
	
}
