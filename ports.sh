if [ ! -f ports.html ]; then
  wget https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers \
    --output-document=ports.html
fi
egrep '<td>[0-9]+' -A4 ports.html | \
sed 's/<td>\|<\/td>//g' | \
awk -f ports.awk | tee ports.json 
