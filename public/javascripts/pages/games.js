require(["application", "datatables"], function() {
  $(function() {
    $("div.games table").dataTable({
      "bPaginate": false,
      "bLengthChange": false,
      "bFilter": false,
      "bSort": true,
      "bInfo": false,
      "bAutoWidth": true,

      "aoColumns": [
        {sType: "start-date"}, //start date
        null, //visitor
        null, //home
        null, //field
      ]
    });
  });
});

