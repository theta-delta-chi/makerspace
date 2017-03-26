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
    respond_to do |format|
      format.js { 
        render 'dashboard/update_list', locals: { contacts: @contacts }
      }
    end
  end

  def get
  end
end
