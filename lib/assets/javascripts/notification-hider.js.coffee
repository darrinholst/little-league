$('.notice').slideDown() if $(".notice").html()?.length

setTimeout((->
  $('.notice').slideUp() if $(".notice").html()?.length
  $('.flash').slideUp() if $(".flash").html()?.length
), 3000)

