(function() {
  var input, original, isCheckbox;

  var reset = function() {
    if(input) {
      input.remove();
      original.show();
    }
  }

  var setup = function(originalElement) {
    reset();

    original = $(originalElement);
    isCheckbox = original.hasClass('checkbox');

    if(isCheckbox) {
      input = $('<input type="checkbox" ' + (original.hasClass('yes') ? 'checked' : '') + '>')
    } else {
      input = $('<input type="text" value="' + original.html() + '">').width(original.parent().width() - 30).height(10)
    }

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

    input[isCheckbox ? 'change' : 'blur'](function(event) {
      submit();
    });
  }

  var submit = function() {
    if(input && input.val() !== original.html()) {
      var data = {};
      data[original.data('field')] = isCheckbox ? input.is(':checked') : input.val()

      $.ajax(original.parents("[data-update-url]").data("updateUrl"), {
        type: "PUT",
        data: data,
        dataType:"json",

        complete: function(xhr) {
          if(xhr.status >= 200 || xhr.status <= 299) {
            if(isCheckbox) {
              original.html(input.is(':checked') ? 'yes' : 'no')
              original.toggleClass('yes').toggleClass('no')
            } else {
              original.html(input.val());
            }

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
    $("span.editable").dblclick(function() {
      setup(this);
    })

    $("td").dblclick(function() {
      var editable = $(this).children("span.editable")

      if(editable) {
        setup(editable);
      }
    })
  });
})();

