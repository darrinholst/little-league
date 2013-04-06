//=require fullcalendar.min

(function() {
  if($("#calendar").length) {
    var displayedDivisions = [];

    var setDisplayedDivisions = function() {
      displayedDivisions = $(".filters li.on a").map(function(index, element) {return $(element).html()});
    }

    setDisplayedDivisions();

    var calendar = $('#calendar').fullCalendar({
      events: 'calendar/home',
      weekMode: 'liquid',
      aspectRatio: 2,
      header: {
        left: 'prev,next',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },

      eventRender: function(event, element) {
        if($("#home-only").prop("checked") && !event.in_town) {
          return false;
        }

        if(event.hide || $.inArray(event.division, displayedDivisions) < 0) {
          return false;
        }
      }
    })

    $("#home-only").change(function() {
      calendar.fullCalendar("rerenderEvents");
    });

    $(".filters li").click(function() {
      $(this).toggleClass("on").toggleClass("off");
      setDisplayedDivisions();
      calendar.fullCalendar("rerenderEvents");
    });
  }
})();
