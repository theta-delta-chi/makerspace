class DashboardController < ApplicationController
  def index
    logger.info('Processing a request in index!')
    @emergencies = Emergency.all
    @contacts = Contact.all
  end
end
