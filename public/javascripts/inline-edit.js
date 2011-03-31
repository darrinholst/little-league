PLL.InlineEdit = {
  reset: function() {
    if(this.input) {
      this.input.remove();
      this.original.show();
    }
  },

  setup: function(originalElement) {
    var self = this;
    this.reset();

    this.original = $(originalElement);
    this.input = $('<input type="text" value="' + this.original.html() + '">').css("width", this.original.parent().innerWidth() - 40)

    this.original.hide();
    this.input.appendTo(this.original.parent());
    this.input.focus();

    this.input.keyup(function(event) {
      if(event.keyCode == 13) { //enter
        self.submit();
      }

      if(event.keyCode == 27) { //escape
        self.reset();
      }
    });

    this.input.blur(function(event) {
      self.submit();
    });
  },

  submit: function() {
    var self = this;

    if(this.input && this.input.attr("value") != this.original.html()) {
      var data = {};
      data[this.original.attr("data-field")] = this.input.attr("value")

      $.ajax(this.original.parents("[data-update-url]").attr("data-update-url"), {
        type: "PUT",
        data: data,

        complete: function(xhr) {
          if(xhr.status == 200) {
            self.original.html(self.input.attr("value"));
            self.reset();
          }
          else {
            alert("Oops, can't update that");
          }
        }
      });
    }
  }
}

$("span.editable").click(function() {
  PLL.InlineEdit.setup(this);
})

$("td").click(function() {
  var editable = $(this).children("span.editable")

  if(editable) {
    PLL.InlineEdit.setup(editable);
  }
})

