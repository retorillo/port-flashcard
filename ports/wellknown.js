const fs = require('fs');
const all = require('./all.json');
const indent = new Array(4).join(' ');
const maxport = 1024;
const wellknown = [];
for (var c = 0; c < all.length; c++) {
  var p =  all[c].port.end ? all[c].port.end : all[c].port;
  wellknown.push(all[c]);
  if (p > maxport) break;
}
fs.writeFileSync('wellknown.json', 
  JSON.stringify(wellknown, null, indent), 'utf-8');

