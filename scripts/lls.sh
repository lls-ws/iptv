#!/bin/sh
# Script to Personalize LLS TV Playlist File
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

lls_download()
{

	check_dir ${FAVORITES_DIR}
	
	if [ -f ${PLAYLIST_LLS_TV} ]; then
	
		cp -fv ${PLAYLIST_LLS_TV} ${PLAYLIST_ALL_IPTV}
		
	else
	
		echo "File ${PLAYLIST_LLS_TV} not found!"
		echo "Run: $0 [${SERVERS_NAME[@]}] create"
		exit 1
		
	fi
	
}

lls_favorites()
{
	
	lls_download
	
	iptv_favorites
	
	lls_order
	
}

lls_order()
{
	
	echo "Removing the first two lines..."
	sed -i '1,2d' ${FAVORITE_FILE}
	
	echo "Removing comments..."
	sed -i 's/^#//' ${FAVORITE_FILE}
	
	echo "Removing spaces from the beginning of a line..."
	sed -i 's/^ *//' ${FAVORITE_FILE}
	
	sort -o ${FAVORITE_FILE} ${FAVORITE_FILE}
	
	sed -i '1i # Example: Suspense#Channel Name' ${FAVORITE_FILE}
	sed -i '1i # Add Groups: Top10 Ação Suspense Família Terror Comédia Velhos Romance Notícias Mistério' ${FAVORITE_FILE}
	sed -i '1i # Change Line Order' ${FAVORITE_FILE}
	
	${TEXT_EDITOR} ${FAVORITE_FILE}
	
}

lls_create()
{

	lls_download
	
	favorites_create
	
	mv -v ${PLAYLIST_LLS} ${PLAYLIST_LLS_TV}
	
	lls_group
	
	playlist_show ${PLAYLIST_LLS_TV}
	
}

lls_group()
{

	remove_group_name
	
	remove_channel_numbers
	
	remove_space_after_comma
	
	remove_extra_names
	
	remove_space_after_comma
	
	remove_spaces_end
	
}

remove_group_name()
{
	
	echo -e "\nRemoving Group Name..."
	
	sed -i 's/ group-title="Filmes"//' ${PLAYLIST_LLS_TV}
	
}

remove_channel_numbers()
{
	
	echo "Removing Channel Numbers..."
	
	sed -i '/^#/ s/^\([^,]*\),[0-9]*\(.*\)/\1,\2/g' ${PLAYLIST_LLS_TV}
	
}

remove_space_after_comma()
{
	
	echo "Removing Space After Comma..."
	
	sed -i 's/, /,/' ${PLAYLIST_LLS_TV}
	
}

remove_extra_names()
{
	
	echo "Removing Extra Names..."
	
	sed -i '/^#/ s/(BR)//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/(Substituto TCL)//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/|//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/Brasil//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/Portuguese//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/LITE//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/ TV//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/Pluto//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/CANAL 4 FILMES//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/Grátis//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/Brazil//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/Soul//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/HD//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/ licenciado exclusivo //g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/Português//g' ${PLAYLIST_LLS_TV}
	
	sed -i '/^#/ s/E Filmes//g' ${PLAYLIST_LLS_TV}
	
}

remove_spaces_end()
{
	
	echo "Removing Spaces at End of Line..."
	
	sed -i '/^#/ s/[[:space:]]*$//' ${PLAYLIST_LLS_TV}
	
}
