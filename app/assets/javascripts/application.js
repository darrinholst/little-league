// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery_ui
//= require jquery.cookie
//= require inline-edit
//= require inline-edit-select
//= require twitter/bootstrap/bootstrap-collapse
//= require twitter/bootstrap/bootstrap-dropdown
//= require calendar
//= require division_filters

$(function() {
  $.cookie('timezone', new Date().getTimezoneOffset(), {path: '/', expires: 10})

  $.ajaxSetup({
    beforeSend: function(xhr) {
      xhr.setRequestHeader("Accept", "application/json")
    }
  });

  if($(".notice").html().length) {
    $('.notice').slideDown();
  }

  setTimeout(function() {
    if($(".notice").html().length) {
      $('.notice').slideUp();
    }
  }, 3000)
});
