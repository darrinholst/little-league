(function() {
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
    input = $('<select>').css("width", 100)

    original.hide();
    input.appendTo(original.parent());
    input.focus();

    input.keyup(function(event) {
      if(event.keyCode == 27) { //escape
        reset();
      }
    });

    input.change(function(event) {
      submit()
    });

    input.blur(function(event) {
      submit();
    });

    $.ajax(original.attr("data-endpoint"), {
      type: "GET",
      dataType: "json",

      success: function(data) {
        input[0].options.length = 0;

        $.each(data, function(index, o) {
          input.append($("<option></option>").prop('selected', original.html() === o.name).attr("value", o.id).text(o.name));
        });
      },

      error: function() {
        alert("Oops, can't get the selections");
      }
    });
  }

  var submit = function() {
    var data = {};
    data[original.attr("data-field")] = input.val()

    $.ajax(original.parents("[data-update-url]").attr("data-update-url"), {
      type: "PUT",
      data: data,
      dataType:"json",

      complete: function(xhr) {
        if(xhr.status >= 200 || xhr.status <= 299) {
          original.html(input.find("option:selected").text())
          reset();
        }
        else {
          alert("Oops, can't update that");
        }
      }
    });
  }

  $(function() {
    $("span.editable-select").dblclick(function() {
      setup(this);
    })

    $("td").dblclick(function() {
      var editable = $(this).children("span.editable-select")

      if(editable) {
        setup(editable);
      }
    })
  });
})();

