class ContactsController < ApplicationController
  def set
    # This is a set because it replaces all current contact.
    # Clean and simple.
    Rails.logger.info(params.inspect.to_yaml)
    Contact.delete_all
    params[:contacts].each do |contact|
      Contact.create(contact)
    end
    @contacts = Contact.all
    @new_contact = Contact.new
    respond_to do |format|
      format.js { 
        render 'dashboard/update_list', locals: { contacts: @contacts, new_contact: @new_contact }
      }
    end
  end

end
