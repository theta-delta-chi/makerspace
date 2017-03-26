console.log("Update list code is running on page.");
$('#contacts_form').html(
  "<%= escape_javascript(render partial: 'dashboard/contacts', locals: {contacts: contacts}) %>"
)
