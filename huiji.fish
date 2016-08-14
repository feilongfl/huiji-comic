#!/usr/bin/env fish

function get_title
    cat $argv | grep title | sed -r 's/.*>(.*)<.*/\1/';
end

function get_author
	cat $argv | grep -A 5 am-u-sm-8 | tr '\r' ' ' | tr '\n' ' ' | sed -r 's/.*em">(.*)<\/abbr>.*em">(.*)<\/abbr>.*em">\s+(.*)<.*/\1\n\2\n\3/'
end

function get_cover
	cat $argv | grep 'am-img-thumbnail' | sed -r 's/.*src="(.*)".*/\1/'
end

function get_body
	cat $argv | grep 'am-btn' | sed -r 's/.*href="(.*)".*>(.*)<.*/\2\t\1/'
end

set a $argv
if begin;
	wget -O $a http://smp.yoedge.com/view/omnibus/$a;
	end;
	#success
	mkdir menu
	echo $a >menu/$a
	get_title $a >>menu/$a
	get_cover $a >> menu/$a
	get_author $a >>menu/$a
	echo >>menu/$a
	get_body $a >>menu/$a
	rm $a
else;
	echo error $argv
	rm $a
end;

