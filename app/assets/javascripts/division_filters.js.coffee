$ ->
  if $("#home .games").length
    $(".filters li").click ->
      $filter = $(@)
      $filter.toggleClass("on").toggleClass("off")
      divisions_to_display = ($(link).html() for link in $(".filters li.on a"))

      for game in $(".game")
        $game = $(game)
        if(divisions_to_display.indexOf($game.data("division")) < 0) then $game.hide() else $game.show()

      for date in $(".games > li")
        $date = $(date)
        if($date.find(".game:visible").length) then $date.show() else $date.hide()

