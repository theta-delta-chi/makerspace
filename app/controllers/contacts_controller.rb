class ContactsController < ApplicationController
  def set
    # This is a set because it replaces all current contact.
    # Clean and simple.
    logger.info("--- Entered the set ---")
    Rails.logger.info(params.inspect.to_yaml)
    puts "--- Can anybody hear me? ---"
    Contact.delete_all
    params[:contacts].each do |contact|
      Contact.create(contact)
    end
    logger.info('--- Completed updating ---')
    @contacts = Contact.all
    @new_contact = Contact.new
    respond_to do |format|
      format.js { 
        render 'dashboard/update_list', locals: { contacts: @contacts, new_contact: @new_contact }
      }
    end
  end

  def get
  end
end
