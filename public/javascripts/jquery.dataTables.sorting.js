jQuery.fn.dataTableExt.oSort['wrapped-date-asc']  = function(a,b) {
  var x = Date.parse( $(a).html() );
  var y = Date.parse( $(b).html() );

  if ( isNaN(x) || x==="" )
  {
    x = Date.parse( "01/01/1970 00:00:00" );
  }
  if ( isNaN(y) || y==="" )
  {
    y = Date.parse( "01/01/1970 00:00:00" );
  }

  return x - y;
};

jQuery.fn.dataTableExt.oSort['wrapped-date-desc'] = function(a,b) {
  var x = Date.parse( $(a).html() );
  var y = Date.parse( $(b).html() );

  if ( isNaN(x) || x==="" )
  {
    x = Date.parse( "01/01/1970 00:00:00" );
  }
  if ( isNaN(y) || y==="" )
  {
    y = Date.parse( "01/01/1970 00:00:00" );
  }

  return y - x;
};

