window.gamification = {
  var body = document.getElementsByTagName('body');
  body.addEventListener('load', function () {
    var flashElem = document.getElementById('flash_notice');
    if (!flashElem) { return; }
    var str = flashElem.innerText;
    var strs = str.split('#');
    if(strs[0] != 'gamification') { return; }
    alert(strs[1]);
  }, false);
};
