function booleanstr(value) {
  if (value) return "true"
  return "false"
}

function handle(port, tcp, udp, desc, official) {
  tcp = tcp == "TCP"
  udp = udp == "UDP"
  if (!tcp && !udp) return
  if (desc == "Reserved" || desc == "Unassigned") return
  official = official == "Official"

  # Relative Path
  gsub(/href=["]\//, "href=\"" ROOT_URL "/", desc)
  gsub(/href=["][#]/, "href=\"" BASE_URL "#", desc)

  # Escape
  gsub(/["]/, "\\\"", desc)

  # Collation for hyphen minus(U+2D)
  port = gensub(/([[:digit:]]+)[^[:digit:][:space:]]+([[:digit:]]+)/, "\\1-\\2", 1, port)

  # For multiple ports (6000-6093 and 31820-31829)
  if (index(port, "-") > 0) {
    split(port, portrange, "-")
    port = "[" portrange[1] ", " portrange[2] "]" 
  }

  if (n > 0) print "   },"
  print "   {"
  print "      \"id\":" n "," 
  print "      \"port\":" port ","
  print "      \"tcp\":" booleanstr(tcp) ","
  print "      \"udp\":" booleanstr(udp) ","
  print "      \"desc\":\"" desc "\","
  print "      \"official\":" booleanstr(official) ""
  n+=1
}

BEGIN {
  FS = "\n"
  RS = "--" 
  n=0
  ROOT_URL = "https://en.wikipedia.org"
  BASE_URL = "https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers"
  print "["
} 
{
  handle($2, $3, $4, $5, $6)
}
END {
  print "   }"
  print "]"
}
