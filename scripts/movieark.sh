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
	
	movieark_logo
	
	iptv_create
	
}

movieark_logo()
{
	
	URL_LOGO="https:\/\/images.pluto.tv\/channels\/6102e04e9ab1db0007a980a1\/logo.png?w=380\&h=110\&trim=auto\&trim-sd=10\&trim-md=0\&fit=clip\&fm=png"
	
	sed -i '/Record News/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
	runtime_logo
	
}

runtime_logo()
{
	
	CHANNEL_NAME="Runtime"
	
	URL_LG="https:\/\/lge-static.ottera.tv\/prod\/run\/linear_channel\/thumbnails\/poster\/280x400\/"
	
	FILE_LOGO="cinespanto_brazil_1400x2000.png"
	
	URL_LOGO=${URL_LG}${FILE_LOGO}
	
	sed -i '/CinEspanto/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
	
	FILE_LOGO="runtime_brazil_1400x2000_0.png"
	
	URL_LOGO=${URL_LG}${FILE_LOGO}
	
	sed -i '/'${CHANNEL_NAME}' TV E Filmes/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	sed -i '/'${CHANNEL_NAME}' Romance/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
	runtime_set "crime" "Crime"
	runtime_set "family" "Familia"
	runtime_set "comedy" "Comédia"
	runtime_set "action" "Ação"
	
}

runtime_set()
{
	
	CHANNEL_TYPE="$1"
	
	CHANNEL_TITLE="$2"
	
	FILE_LOGO="runtime_${CHANNEL_TYPE}_brazil_1400x2000.png"
	
	URL_LOGO=${URL_LG}${FILE_LOGO}
	
	sed -i '/'${CHANNEL_NAME}' '${CHANNEL_TITLE}'/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
}
