var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'techstars.html'

page.open('https://mp.weixin.qq.com/profile?src=3&timestamp=1503743147&ver=1&signature=qu-LwAecFNHrhTh3IK64RvupYOW1SV*O6iTDgQPv5PhZuMefPhRZ5Sj1GORmZqnPucW0b5AXUgOI*u1eNz704w==', function (status) {
  var content = page.content;
  fs.write(path,content,'w')
  phantom.exit();
});