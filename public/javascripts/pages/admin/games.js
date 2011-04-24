require(["application", "datatables"], function() {
  $(function() {
    $("div.games table").dataTable({
      "bPaginate": false,
      "bLengthChange": false,
      "bFilter": false,
      "bSort": true,
      "bInfo": false,
      "bAutoWidth": false,

      "aaSorting": [[4, "asc"], [0, "asc"]],

      "aoColumns": [
        null, //division
        null, //visitor
        null, //home
        null, //field
        {sType: "start-date"}, //start date
        {bSortable: false}, //edit | delete
      ]
    });
  });
});

