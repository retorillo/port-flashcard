BEGIN {
  FS="\n"
  RS="--" 
  n=0
  print "["
} 
{
  if ($3 == "TCP")
    $3="true"
  else
    $3="false"
  
  if ($4 == "UDP")
    $4="true"
  else
    $4="false"
  
  gsub(/["]/, "\\\"", $5)
  
  if ($6 == "Official")
    $6="true"
  else
    $6="false"

  if (($3 == "true" || $4 == "true") && $5 != "Reserved" && $5 != "Unassigned") {
    if (n > 0)
      print "   },"
  
    print "   {"
    print "      \"id\":" n "," 
    print "      \"port\":" $2 ","
    print "      \"tcp\":" $3 ","
    print "      \"udp\":" $4 ","
    print "      \"desc\":\"" $5 "\","
    print "      \"official\":" $6 ""
    n+=1
  }
}
END {
  print "   }"
  print "]"
}
