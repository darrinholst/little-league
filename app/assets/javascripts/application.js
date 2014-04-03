//= require jquery
//= require jquery_ujs
//= require jquery_ui
//= require jquery.cookie
//= require bootstrap/collapse
//= require bootstrap/dropdown
//
//= require inline-edit
//= require inline-edit-select
//= require notification-hider
//
//= require calendar
//= require division_filters

$(function() {
  $.cookie('timezone', new Date().getTimezoneOffset(), {path: '/', expires: 10})

  $.ajaxSetup({
    beforeSend: function(xhr) {
      xhr.setRequestHeader("Accept", "application/json")
    }
  });
});
