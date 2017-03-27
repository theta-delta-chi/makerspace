$('#contacts_form').replaceWith(
  "<%= escape_javascript(render partial: 'dashboard/contacts', locals: {contacts: contacts}) %>"
);

$('#contacts_form_container').html(
  "<%= escape_javascript(render partial: 'dashboard/contact_form', locals: {contacts: contacts, new_contact: new_contact}) %>"
);
