//=require fullcalendar.min

(function() {
  if ($('#calendar').length) {
    var displayedDivisions = [];

    var calendar = $('#calendar').fullCalendar({
      events: 'calendar/home',
      weekMode: 'liquid',
      aspectRatio: 2,
      header: {
        left: 'prev,next',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },

      eventRender: eventRender,
      eventClick: eventClick
    });

    $('#home-only').change(function() {
      calendar.fullCalendar('rerenderEvents');
    });

    $('.filters li').click(function() {
      $(this)
        .toggleClass('on')
        .toggleClass('off');
      setDisplayedDivisions();
      calendar.fullCalendar('rerenderEvents');
    });

    function eventRender(event, element) {
      if ($('#home-only').prop('checked') && !event.in_town) {
        element.hide();
      }

      if (event.division && $.inArray(event.division, displayedDivisions) < 0) {
        element.hide();
      }
    }

    function eventClick(event) {
      if (event.on_click) {
        window.open(event.on_click, '_blank');
      }
    }

    function setDisplayedDivisions() {
      displayedDivisions = $('.filters li.on a').map(function(index, element) {
        return $(element).html();
      });
    }

    setDisplayedDivisions();
  }
})();
