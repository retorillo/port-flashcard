const express = require('express');
const app = express();
const ports = require('./ports/wellknown.json');
const maxCount = 20;
app.get('/', (req, res) => {
  var count = 1;
  if (req.query.count) {
    var c = parseInt(req.query.count)
    if (!isNaN(c))
      count = Math.max(1, Math.min(c, maxCount));
  }
  var result = [];
  for (var c = 0; c < count; c ++) {
    var index = Math.round(Math.random() * (ports.length - 1));
    result.push(ports[index]);
  }
  res.json(result);
});
app.listen(5900);


