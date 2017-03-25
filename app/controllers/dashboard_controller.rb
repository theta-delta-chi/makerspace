class DashboardController < ApplicationController
  def index
    logger.fatal('Processing a request in index!')
    @emergencies = [{ :time => '9am', :link => 'google.com'}]
    @contacts = [{:name => 'Sully', :number => '42' }]
  end
end
