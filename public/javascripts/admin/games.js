$("div.games table").dataTable({
  "bPaginate": false,
  "bLengthChange": false,
  "bFilter": false,
  "bSort": true,
  "bInfo": false,
  "bAutoWidth": false,

  "aaSorting": [[3, "asc"], [0, "asc"], [1, "asc"]],

  "aoColumns": [
    null, //division
    null, //visitor
    null, //home
    null, //field
    null, //time
    {bSortable: false}, //edit | delete
  ]
});

