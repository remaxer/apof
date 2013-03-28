#!/bin/bash
#
#   apof - download all photos of facebook's profiles
#   Copyright (C) 2012  REmaxer <remaxer@hotmail.it>
#   
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.

#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#	[file]
#	@desc:	download all photos of facebook's profiles
#	@last_mod:	28/03/13
#	@lang:		BASH
#	@vers:		2
#	@author:	REmaxer

#	[function]
#	@desc:	download a pic of a user id
#	@arg1:	user id
function download_pic {
	#making the url
	URL="www.facebook.com/profile.php?id=$1"
	echo "Downloading facebook page ( profile $1 )"
	#download page
	wget --directory-prefix="Pages" --user-agent="Chrome/24.0.1312.56 Safari/537.17"  --load-cookies cookies.txt $URL 
	echo "Page downloaded"
	#page name
	PAGE_NAME=$(echo $URL | cut -c 18-)
	echo "Page name will be '$PAGE_NAME'"
	#parsing page to find pic URL
	PIC_URL=$(grep -Po '(?<=profilePic img\" src=\")https://.+.jpg(?=\" alt)' Pages/$PAGE_NAME)	#using regexp
	echo "Pic URL will be '$PIC_URL'"
	echo "Downloading facebook profile pic"
	#download pic
	wget -O "Pics/user$1.jpg" --user-agent="Chrome/24.0.1312.56 Safari/537.17"  --load-cookies cookies.txt $PIC_URL
	echo "Pic downloaded"
}

#check if directories exist
if [ ! -d "Pages" ];then
	mkdir Pages
fi
if [ ! -d "Pics" ];then
	mkdir Pics
fi
#download pic of $1 user id
download_pic $1
