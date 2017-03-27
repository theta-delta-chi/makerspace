class EmergenciesController < ApplicationController
  def create
    Emergency.create(:time => DateTime.now, :link => 'www.placeholder.com')
    notify_contacts("There's an emergency in the Makerspace!")
    logger.info("--- ! --- Got past notify_contacts() --- ! ---")
    render :nothing => true
  end

  def safety_test
    notify_contacts("Everything's good in the Makerspace, this is just a test.")
    render :nothing => true
  end

  private

  def notify_contacts(message)
    @contacts = Contact.all
    @client = Twilio::REST::Client.new(
                ENV['TWILIO_ACCOUNT_SID'],
                ENV['TWILIO_AUTH_TOKEN'])
    logger.info('About to get and sort the images from Dropbox')
    filtersort_images()
    logger.info("--- About to try and notify contacts about "+message+" ! ---")
    @contacts.each do |contact| 
      send_sms(client, contact[:phone], message)
    end 
  end

  def send_sms(client, phone, message)
    client.account.messages.create(
			:from => ENV['TWILIO_NUMBER'],,
			:to => phone,
			:body => message)	
    logger.info("--- Just sent SMS to phone "+phone+" ---")
  end

  def filtersort_images()
    dropbox_client = DropboxApi::Client.new
    #result = dropbox_client.get_temporary_link "/TDCMakerspace/picam/2017-03-11/2017-03-11_23-13-14.jpg"
    result = dropbox_client.list_folder "/TDCMakerspace/Security Camera/picam/"
    #=> #<DropboxApi::Results::ListFolderResult>
    puts result.entries
    #=> [#<DropboxApi::Metadata::Folder>, #<DropboxApi::Metadata::File>]
    result.has_more?
    #=> false
    #@image_url = "https://dl.dropboxusercontent.com/apitl/1/AAB1oDWX-cEHpPeH0eeHjVATv4NY7e755rI-4KqfbDi1cLugDrbPFSbGBjTkpBq2czw6ALDBjQnyuCwSdK0CjUl8CvtXx8I8Pi02Me2B0alPG1dZh1H7K4ZP4_S-d0OXRk54pP7cNRjRn73-xG0FoKqal91sODmaY-56o_eXmx6v6ar-Fju3ym0BOYzBWYy0bCSptqUX7-W-qOc2IYkrA2a4vDzIPjzULCkmRrX6ecnbUKW5DxHUDvXO8-li-Ni3tY0phgbuJsgWZYlKp68XZAWFAs9HCcFkVr4MKncGKVwylTYmjnLNh2fEy1nj6wFPTS8"
    puts result
    # result = array.select do |hash|
    #  hash[:date] >= 100
    #end
    result
  end

    @image_url = result.link
  end
end
