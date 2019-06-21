#!/bin/bash

blk=500
input=$2
output=$3
total=$(base64 $input|wc -c|awk '{print $1}')

create(){
  i=1
  count=1
  while [ $i -lt $total ]
  do
    printf "Encode $count \t"
    linesize=$(base64 $input|cut -c$i-$blk|wc -c|awk '{print $1}')
    base64 $input|cut -c$i-$blk|cut -c-4,`echo "$linesize"-4|bc`-|sed 's/./&-/4'|tee -a $output.dm

    if [ "$count" -le 9 ];then
      base64 $input|cut -c$i-$blk|qrencode -o $output-0$count.png
    else
      base64 $input|cut -c$i-$blk|qrencode -o $output-$count.png
    fi
    i=$(echo "$blk+1"|bc)
    blk=$(echo "$blk+500"|bc)
    count=$(echo "$count+1"|bc)
  done
  base64 $output.dm|qrencode -o $output-dm.png
  printf "Garbage colleting on temp files \t"
  rm -fv $output.dm
}

trash(){
  for i in $(find . -type f -name "$input-[0-9]*.png");do
    printf "Cleaning \t"
    rm -fv $i
  done
  printf "Cleaning \t"
  rm -fv $input-dm.png

}

case "$1" in
  build)
    create
  ;;
  clean)
    trash
  ;;
  *|help)
    echo "Use:
          $0 build
          $0 clean
          "
  ;;
esac
