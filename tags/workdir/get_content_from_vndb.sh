#!/bin/zsh
mkdir temp
cd temp
for i in {1..`curl https://vndb.org/g/list'?b=1&a=1&t=2' | hq a data|grep last|head -n 1| sed 's!<a href="?a=1&amp;b=1&amp;o=a&amp;p=!!g;s!&amp;q=&amp;s=name&amp;t=2">last »</a>!!g'`}
do  curl -O 'https://vndb.org/g/list?b=1&a=1&t=2&p='$i
    sleep 1
done

cat *|hq td.tc3 text|grep -v ▴▾ > 0
cat *|hq td.tc3 data|hq a attr href|grep -v o > 1

paste 0 1|sort|gawk '{print $NF}' > 2
../process.sh < 2 > 3
mv 3 ../../tags_note.txt

