// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  $('#edit_contacts').on('click', function(){
    $('#contacts_list').replaceWith($('#contacts_form'));
  });

  $('.remove_contact').on('click', function(){
    $(this)[0].parentElement.parentElement.remove();
  });

  $('#add_contact').on('click', function(){
    $('#contact_form_list').append($('#new_contact_fields').clone(true));
  });

});
