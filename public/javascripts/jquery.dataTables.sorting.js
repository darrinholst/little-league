var DateSorter = {
  sort: function(a, b, direction) {
    var x = Date.parse(a);
    var y = Date.parse(b);

    if ( isNaN(x) || x === "" ) {
      x = Date.parse( "01/01/1970 00:00:00" );
    }

    if ( isNaN(y) || y === "" ) {
      y = Date.parse( "01/01/1970 00:00:00" );
    }

    return "asc" === direction ? (x - y) : (y - x)
  }
}

var WrappedDateSorter = {
  sort: function(a, b, direction) {
    return DateSorter.sort($(a).html(), $(b).html(), direction)
  }
}

var StartDateSorter = {
  insertYear: function(date) {
    var match = date.match(/(\D+ \D+ \d+) (.*)/)

    if(match) {
      date = match[1] + " " + new Date().getFullYear() + " " + match[2]
    }

    return date
  },

  sort: function(a, b, direction) {
    return DateSorter.sort(this.insertYear(a), this.insertYear(b), direction)
  }
}

jQuery.fn.dataTableExt.oSort['wrapped-date-asc']  = function(a,b) {
  return WrappedDateSorter.sort(a, b, "asc")
};

jQuery.fn.dataTableExt.oSort['wrapped-date-desc'] = function(a,b) {
  return WrappedDateSorter.sort(a, b, "desc")
};

jQuery.fn.dataTableExt.oSort['start-date-asc']  = function(a,b) {
  return StartDateSorter.sort(a, b, "asc")
};

jQuery.fn.dataTableExt.oSort['start-date-desc'] = function(a,b) {
  return StartDateSorter.sort(a, b, "desc")
};
