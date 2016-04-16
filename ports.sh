pushed ports/
if [ ! -f all.html ]; then
  wget https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers \
    --output-document=all.html
fi
egrep '<td>[0-9]+' -A4 all.html | \
sed 's/<td>\|<\/td>//g' | \
awk -f all.awk | tee all.json 
