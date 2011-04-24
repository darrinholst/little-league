define(["jquery", "rails"], function() {
  $(function() {
    $.ajaxSetup({
      beforeSend: function(xhr) {
        xhr.setRequestHeader("Accept", "application/json")
      }
    });

    setTimeout(function() {
      if($(".notice").html().length) {
        $('.notice').slideUp();
      }
    }, 3000)
  });
});
