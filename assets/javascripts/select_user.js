$(function() {
  var gSelectForm = document.getElementById('rate_user');
  gSelectForm.addEventListener('change', function() {
    var num = this.value;
    $.ajax({
      type: 'get',
      url: '/gamification/user_image/' + num,
      success: function(html) {
        var img = document.createElement('img');
        img.src = this.url;
        if(img.src != null) {
          $('#user-image').html(img);
        }
      }
    });
  }, false);
});
