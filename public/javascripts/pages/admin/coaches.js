require(["application", "datatables"], function() {
  $(function() {
    $("div.coaches table").dataTable({
      "bPaginate": false,
      "bLengthChange": false,
      "bFilter": false,
      "bSort": true,
      "bInfo": false,
      "bAutoWidth": false,

      "aaSorting": [[1, "asc"]],

      "aoColumns": [
        null, //first name
        null, //last name
        {bSortable: false}, //phone
        {bSortable: false}, //email
        null, //division
        null, //team
        {bSortable: false}, //edit | delete
      ]
    });
  });
});

