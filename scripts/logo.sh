#!/bin/sh
# Script to Add Logo on Playlist Channels
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

adrenalina_pura_logo()
{
	
	URL_LOGO="https:\/\/d2mxb63djushzm.cloudfront.net\/images\/Sofa%20Digital\/Adrenalina%20Pura%20TV\/LG\/APTV-Logo-%20400x200.png"
	
	sed -i '/2646 Adrenalina Pura TV (BR) (Substituto TCL)/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
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

record_news_logo()
{
	
	URL_LOGO="https:\/\/images.pluto.tv\/channels\/6102e04e9ab1db0007a980a1\/logo.png?w=380\&h=110\&trim=auto\&trim-sd=10\&trim-md=0\&fit=clip\&fm=png"
	
	sed -i '/Record News/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
}

filmelier_logo()
{
	
	URL_LOGO="https:\/\/d2mxb63djushzm.cloudfront.net\/images\/FILMELIER_400x200_DARK_TRANSPARENTE.png"
	
	sed -i '/Filmelier/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
}

jovempan_news_logo()
{
	
	URL_LOGO="http:\/\/d3bd0tgyk368z1.cloudfront.net\/feeds\/images\/jovempan-fast\/LGLOGO-400X200COLOR.png"
	
	sed -i '/Jovem Pan News/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
}

euronews_logo()
{
	
	URL_LOGO="https:\/\/images.pluto.tv\/channels\/619e6614c9d9650007a2b171\/logo.png?w=380\&h=110\&trim=auto\&trim-sd=10\&trim-md=0\&fit=clip\&fm=png"
	
	sed -i '/Euronews Português/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
}

grjngo_logo()
{
	
	URL_LOGO="https://i.ytimg.com/vi/v6ux1Oty8EA/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCuv65d0euYY4rebzVBsXcG246zIw"
	
	sed -i '/Grjngo/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
}

cindie_logo()
{
	
	URL_LOGO="https:\/\/d1y2dphb29uhu6.cloudfront.net\/c\/433\/images\/cqYA0kmQKlUvEWe95h6O7g.png"
	
	sed -i '/CINDIE LITE/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
}

romance_channel_logo()
{
	
	URL_LOGO="https:\/\/image.roku.com\/developer_channels\/prod\/805c999cb8e6206c655778a7f468ab3f8c4a88dbc7790027a69f72e43f8a3986.png"
	
	sed -i '/Romance Channel/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
}

acao_total_logo()
{
	
	URL_LOGO="https:\/\/www.jwave.com.br\/wp-content\/uploads\/2025\/09\/ACAO-TOTAL-TV.jpg"
	
	sed -i '/Ação Total TV/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
}

medo_logo()
{
	
	URL_LOGO="https:\/\/www.jwave.com.br\/wp-content\/uploads\/2025\/09\/Medo-TV.jpg"
	
	sed -i '/Medo TV/s/group-title="Add"/group-title="Add" tvg-logo="'${URL_LOGO}'"/g' ${PLAYLIST_LLS}
	
}
