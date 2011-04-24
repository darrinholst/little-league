require(["appcommon", "datepicker"], function() {
  $(function() {
    $('#game_starts_at').datetimepicker({
      ampm: true
    });
  });
});

