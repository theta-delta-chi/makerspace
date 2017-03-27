class DashboardController < ApplicationController
  def index
    logger.info('Processing a request in index!')
    @emergencies = Emergency.all
    @contacts = Contact.all
    @new_contact = Contact.new
  end
end
