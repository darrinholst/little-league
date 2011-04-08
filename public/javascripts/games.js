$("div.games table").dataTable({
  "bPaginate": false,
  "bLengthChange": false,
  "bFilter": false,
  "bSort": true,
  "bInfo": false,
  "bAutoWidth": false,

  "aoColumns": [
    {sType: "start-date"}, //start date
    null, //visitor
    null, //home
    null, //field
  ]
});

