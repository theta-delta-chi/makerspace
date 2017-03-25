class EmergenciesController < ApplicationController
  def create
    Emergency.create(:time => DateTime.now, :link => 'www.placeholder.com')
    notify_contacts()
    logger.info("--- ! --- Got past notify_contacts() --- ! ---")
    render :nothing => true
  end

  def notify_contacts
    @contacts = Contact.all
    @client = Twilio::REST::Client.new(
                ENV['TWILIO_ACCOUNT_SID'],
                ENV['TWILIO_AUTH_TOKEN'])
    @message = "There's an emergency in the Makerspace!"
    @contacts.each do |contact| 
      send_sms(client, contact[:phone], @message)
    end 
  end

  def send_sms(client, phone, message)
    client.account.messages.create(
			:from => ENV['TWILIO_NUMBER'],,
			:to => phone,
			:body => message
			)	
    logger.info("--- Just sent SMS to phone "+phone+" ---")
  end
end
