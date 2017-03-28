class EmergenciesController < ApplicationController
  def create
    Emergency.create(:time => DateTime.now, :link => 'www.placeholder.com')
    notify_contacts("There's an emergency in the Makerspace!")
    render :nothing => true
  end

  def safety_test
    notify_contacts("Makerspace Test Message; Please Ignore")
    render :nothing => true
  end

  private

  def notify_contacts(message)
    @contacts = Contact.all
    @client = Twilio::REST::Client.new(
                ENV['TWILIO_ACCOUNT_SID'],
                ENV['TWILIO_AUTH_TOKEN'])
    @img_urls = get_img_urls
    img_time = get_img_urls[:time].strftime('Image from %m/%d @ %l:%M%P')
    @contacts.each do |contact| 
      @client.account.messages.create(
        :from => ENV['TWILIO_NUMBER'],
        :to => contact[:phone],
        :body => message + "\n\n" + img_time,
        :media_url => [@img_urls[:picam],@img_urls[:usb]]
      )
    end 
  end

end
