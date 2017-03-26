// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  $(document).on('click', '#edit_contacts', function(){
    $('#contacts_list').replaceWith($('#contacts_form').clone(true));
  });

  $(document).on('click', '.remove_contact', function(){
    $(this)[0].parentElement.parentElement.remove();
  });

  $(document).on('click', '#add_contact', function(){
    $('#contact_form_list').append($('#new_contact_fields').clone(true));
  });
  
  $('#safety_test').on('click', function(){
    $.ajax({ url : '/makerspace/test', type : 'POST'});
  });
});
