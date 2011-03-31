PLL = {}

$.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader("Accept", "application/json")
  }
});

setTimeout(function() {$('.notice').slideUp();}, 3000)

