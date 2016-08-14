#!/usr/bin/env fish

for i in (ls menu);echo $i;mkdir -p ./commic/$i;cat ./menu/$i >./commic/$i/list.txt;for m in (cat ./commic/$i/list.txt | grep 'shinmangaplayer');echo $m;set name (echo $m | sed -r 's/(.*)\t(.*)/\1/');set url (echo $m | sed -r 's/(.*)\t(.*)/\2/' | sed -r 's/index\.html/smp_cfg.json/');echo $name;echo $url;mkdir -p ./commic/$i/$name;wget -O ./commic/$i/$name/pic.json $url;for j in (jq '.pages.page[]' ./commic/$i/$name/pic.json | sed -r 's/"//g');set pic_url (echo $url | sed -r 's/index\.html//')$j;echo $pic_url;cd ./commic/$i/$name/;pwd;wget $pic_url;cd -;end;end;end
