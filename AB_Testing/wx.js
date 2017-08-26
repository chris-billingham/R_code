var page=require('webpage').create();
page.open('https://mp.weixin.qq.com/profile?src=3&timestamp=1503743147&ver=1&signature=qu-LwAecFNHrhTh3IK64RvupYOW1SV*O6iTDgQPv5PhZuMefPhRZ5Sj1GORmZqnPucW0b5AXUgOI*u1eNz704w==',function(){
console.log(page.content);//page source
phantom.exit();
});
