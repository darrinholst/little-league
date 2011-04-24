define(function() {
  var input, original;
  
  var reset = function() {
    if(input) {
      input.remove();
      original.show();
    }
  }

  var setup = function(originalElement) {
    reset();

    original = $(originalElement);
    input = $('<input type="text" value="' + original.html() + '">').css("width", original.parent().innerWidth() - 40)

    original.hide();
    input.appendTo(original.parent());
    input.focus();

    input.keyup(function(event) {
      if(event.keyCode == 13) { //enter
        submit();
      }

      if(event.keyCode == 27) { //escape
        reset();
      }
    });

    input.blur(function(event) {
      submit();
    });
  }

  var submit = function() {
    if(input && input.attr("value") !== original.html()) {
      var data = {};
      data[original.attr("data-field")] = input.attr("value")

      $.ajax(original.parents("[data-update-url]").attr("data-update-url"), {
        type: "PUT",
        data: data,

        complete: function(xhr) {
          if(xhr.status == 200) {
            original.html(input.attr("value"));
            reset();
          }
          else {
            alert("Oops, can't update that");
          }
        }
      });
    }
    else {
      reset();
    }
  }

  $(function() {
    $("span.editable").click(function() {
      setup(this);
    })

    $("td").click(function() {
      var editable = $(this).children("span.editable")

      if(editable) {
        setup(editable);
      }
    })
  });
});



