require(["application", "datatables", "inline-edit"], function() {
  $(function() {
    $("div.players table").dataTable({
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
        {sType: "wrapped-date"}, //birthdate
        null, //age
        {bSortable: false}, //parents
        {bSortable: false}, //phone
        {bSortable: false}, //alternate phone
        null, //shirt size
        null, //division
        null, //team
        {bSortable: false} // edit | delete
      ]
    });
  });
});
