$(".admin div.players table").dataTable({
  "bPaginate": false,
  "bLengthChange": false,
  "bFilter": false,
  "bSort": true,
  "bInfo": false,
  "bAutoWidth": false,

  "aaSorting": [[1, "asc"]],

  "aoColumns": [
    null,
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
  ],

  "aoColumnDefs": [
    { "bSortable": false, "aTargets": [ 0 ] }
  ],

  "fnDrawCallback": function ( oSettings ) {
    if ( oSettings.bSorted || oSettings.bFiltered ) {
      for ( var i=0, iLen=oSettings.aiDisplay.length ; i<iLen ; i++ ) {
        $('td:eq(0)', oSettings.aoData[ oSettings.aiDisplay[i] ].nTr ).html( i+1 );
      }
    }
  }
});
